import 'package:flutter/material.dart';
import 'package:online_course/CheckOutScreen.dart';
import 'package:online_course/NotificationDetailScreen.dart';
import 'package:online_course/QRScannerScreen.dart';
import 'package:online_course/SearchScreen.dart';
import 'package:online_course/components/BottomNavBar.dart';
import 'package:online_course/components/HeroSearchBar.dart';
import 'package:online_course/components/RecomenderCard.dart';
import 'package:online_course/components/SectionTitle.dart';
import 'package:online_course/components/TopBar.dart';
import 'package:online_course/models/store.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:online_course/services/ApiService.dart';
import 'package:online_course/services/LocationService.dart';
import 'package:online_course/services/MapBuilder.dart';
import 'package:online_course/services/OSMService.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Map<int, int> cart = {}; // key = index produk, value = quantity
  LatLng? _selectedPoint;
  LatLng? _userLocation;
  List<Store>? _nearbyStores;
  final MapController _mapController = MapController();

  int get totalItems => cart.values.fold(0, (sum, qty) => sum + qty);

  void addItem(int index) {
    setState(() {
      cart[index] = (cart[index] ?? 0) + 1;
    });
  }

  void removeItem(int index) {
    setState(() {
      if (cart[index] != null && cart[index]! > 0) {
        cart[index] = cart[index]! - 1;
        if (cart[index] == 0) cart.remove(index);
      }
    });
  }

  Future<void> _initMap() async {
    final userLoc = await LocationService.getUserLatLng();
    if (userLoc == null) return;

    final stores = await OSMService.fetchNearbyStores(userLoc, radius: 1000);
    setState(() {
      _userLocation = userLoc;
      _nearbyStores = stores;
    });

    _mapController.move(userLoc, 16.0);
  }

  void _addToCart(BuildContext context, int productId) async {
    try {
      final newItem = {
        "product_id": productId,
        "is_fav": false,
        "is_cart": true,
      };

      final result = await ApiService.createCollection(newItem);

      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            behavior: SnackBarBehavior.floating,
            content: Text("Ditambahkan ke keranjang: ${result['id']}"),
            duration: Duration(seconds: 2),
          ),
        );
    } catch (e) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            behavior: SnackBarBehavior.floating,
            content: Text("Gagal menambah ke keranjang: $e"),
            duration: Duration(seconds: 2),
          ),
        );
    }
  }

  @override
  void initState() {
    super.initState();
    _initMap();
  }

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> products = [
      {"id": 1, "name": "Produk A"},
      {"id": 2, "name": "Produk B"},
      {"id": 3, "name": "Produk C"},
    ];

    return Scaffold(
      backgroundColor: Colors.blueAccent,
      body: Stack(
        children: [
          SafeArea(
            child: Column(
              children: [
                TopBar(),
                SizedBox(height: 12),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: HeroSearchBar(),
                ),
                SizedBox(height: 12),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: SectionTitle('Rekomendasi Untukmu'),
                        ),
                        SizedBox(height: 8),
                        Container(
                          height: 160,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16.0,
                            ),
                            itemCount: mockStores.length,
                            itemBuilder: (c, i) {
                              final s = mockStores[i];
                              return Padding(
                                padding: const EdgeInsets.only(right: 12.0),
                                child: RecommendedCard(store: s),
                              );
                            },
                          ),
                        ),
                        SizedBox(height: 16),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: SectionTitle('Dekat Kamu'),
                        ),
                        SizedBox(height: 8),
                        // Mini map card placeholder
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: GestureDetector(
                            onTap:
                                () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => SearchScreen(),
                                  ),
                                ),
                            child: Container(
                              height: 160,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(14),
                                color: Colors.white.withOpacity(0.04),
                              ),
                              // child: _buildMapView(mockStores, context),
                              child: MapBuilder(
                                results: _nearbyStores ?? [],
                                mapController: _mapController,
                                userLocation: _userLocation,
                                selectedPoint: _selectedPoint,
                              ),
                              // _buildMapView(
                              //   _nearbyStores ?? [],
                              //   context,
                              // ),
                            ),
                          ),
                        ),
                        SizedBox(height: 24),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: SectionTitle('Products'),
                        ),
                        SizedBox(height: 8),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 8,
                                  childAspectRatio: 50 / 72,
                                ),
                            itemCount: 10,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return Card(
                                clipBehavior: Clip.antiAlias,
                                child: Column(
                                  children: [
                                    ListTile(
                                      leading: CircleAvatar(
                                        radius: 20,
                                        backgroundImage: NetworkImage(
                                          'https://picsum.photos/seed/p$index/120/80',
                                          scale: 1,
                                        ),
                                      ),
                                      title: const Text(
                                        "Product Name",
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      subtitle: Text(
                                        'Prduct Small Desciption',
                                        style: TextStyle(
                                          color: Colors.black.withOpacity(0.6),
                                          fontSize: 10,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Text(
                                        'Greyhound divisively hello coldly wonderfully marginally far upon excluding.',
                                        style: TextStyle(
                                          color: Colors.black.withOpacity(0.6),
                                        ),
                                      ),
                                    ),
                                    OverflowBar(
                                      alignment: MainAxisAlignment.start,
                                      children: [
                                        TextButton(
                                          onPressed: () async {
                                            try {
                                              // ambil data keranjang dari API
                                              final List<dynamic> cartState =
                                                  await ApiService.getCollections();

                                              // cek apakah product_id sudah ada
                                              final alreadyInCart = cartState
                                                  .any(
                                                    (cart) =>
                                                        cart['product_id'] ==
                                                        index + 1,
                                                  );

                                              if (alreadyInCart) {
                                                ScaffoldMessenger.of(context)
                                                  ..hideCurrentSnackBar()
                                                  ..showSnackBar(
                                                    const SnackBar(
                                                      behavior:
                                                          SnackBarBehavior
                                                              .floating,
                                                      content: Text(
                                                        "Produk sudah ada di keranjang",
                                                      ),
                                                      duration: Duration(
                                                        seconds: 2,
                                                      ),
                                                    ),
                                                  );
                                              } else {
                                                _addToCart(context, index + 1);
                                              }
                                            } catch (e) {
                                              ScaffoldMessenger.of(context)
                                                ..hideCurrentSnackBar()
                                                ..showSnackBar(
                                                  SnackBar(
                                                    behavior:
                                                        SnackBarBehavior
                                                            .floating,
                                                    content: Text(
                                                      "Gagal cek keranjang: $e",
                                                    ),
                                                    duration: Duration(
                                                      seconds: 2,
                                                    ),
                                                  ),
                                                );
                                            }
                                          },
                                          child: const Icon(
                                            Icons.shopping_cart,
                                          ),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            // Perform some action
                                          },
                                          child: const Icon(Icons.info),
                                        ),
                                        Icon(Icons.favorite, size: 20),
                                        SizedBox(width: 10),
                                        Icon(Icons.share, size: 20),
                                      ],
                                    ),
                                    const Divider(
                                      height: 1,
                                      color: Colors.black26,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        IconButton(
                                          icon: Icon(
                                            Icons.remove_circle_outline,
                                          ),
                                          onPressed: () => removeItem(index),
                                        ),
                                        Text(
                                          "${cart[index] ?? 0}",
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        IconButton(
                                          icon: Icon(Icons.add_circle_outline),
                                          onPressed: () => addItem(index),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Floating action panel
          if (totalItems > 0)
            Positioned(
              bottom: 30, // di atas bottomNav
              left: 20,
              right: 20,
              child: Material(
                elevation: 6,
                borderRadius: BorderRadius.circular(16),
                color: Colors.green,
                child: InkWell(
                  borderRadius: BorderRadius.circular(16),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (BuildContext context) => CheckoutScreen(),
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 14,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "$totalItems produk dipilih",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              "Checkout",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(width: 6),
                            Icon(Icons.arrow_forward, color: Colors.white),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
      bottomNavigationBar: BottomNav(),
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const QrScannerScreen()),
          );
        },
        child: Icon(Icons.qr_code_scanner),
        backgroundColor: Colors.white.withOpacity(0.8),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

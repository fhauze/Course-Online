import 'package:flutter/material.dart';
import 'package:online_course/QRScannerScreen.dart';
import 'package:online_course/SearchScreen.dart';
import 'package:online_course/StoreDetailScreen.dart';
import 'package:online_course/components/BottomNavBar.dart';
import 'package:online_course/components/HeroSearchBar.dart';
import 'package:online_course/components/RecomenderCard.dart';
import 'package:online_course/components/SectionTitle.dart';
import 'package:online_course/components/TopBar.dart';
import 'package:online_course/models/store.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      body: SafeArea(
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
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
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
                              MaterialPageRoute(builder: (_) => SearchScreen()),
                            ),
                        child: Container(
                          height: 160,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                            color: Colors.white.withOpacity(0.04),
                          ),
                          child: _buildMapView(mockStores, context),
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
                              childAspectRatio: 50 / 70,
                            ),
                        itemCount: 10,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return Card(
                            clipBehavior: Clip.antiAlias,
                            child: Column(
                              children: [
                                ListTile(
                                  leading: Icon(Icons.arrow_drop_down_circle),
                                  title: const Text("Product Name"),
                                  subtitle: Text(
                                    'Prduct Small Desciption',
                                    style: TextStyle(
                                      color: Colors.black.withOpacity(0.6),
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
                                      onPressed: () {
                                        // Perform some action
                                      },
                                      child: const Icon(Icons.shopping_cart),
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
                                const Divider(height: 1, color: Colors.black26),
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
        backgroundColor: Color(0xFF7C3AED),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget _buildMapView(List<Store> results, BuildContext context) {
    LatLng? _selectedPoint;
    LatLng? _userLocation;
    return FlutterMap(
      options: MapOptions(
        center:
            _userLocation, //LatLng(-6.2, 106.816666), // Jakarta Pusat sebagai contoh
        zoom: 13,
        onTap: (tapPosition, point) {
          // `point` berisi LatLng(lat, lng)
          print("User tapped at: ${point.latitude}, ${point.longitude}");
        },
      ),
      children: [
        TileLayer(
          urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
          userAgentPackageName: 'com.example.marketplace',
        ),
        MarkerLayer(
          markers:
              results.map((s) {
                return Marker(
                  point: LatLng(s.lat, s.lng),
                  width: 40,
                  height: 40,
                  child: IconButton(
                    icon: const Icon(Icons.location_on, color: Colors.red),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => StoreDetailScreen(store: s),
                        ),
                      );
                    },
                  ),
                );
              }).toList(),
        ),
        if (_selectedPoint != null)
          MarkerLayer(
            markers: [
              Marker(
                point: _selectedPoint!,
                width: 40,
                height: 40,
                child: const Icon(
                  Icons.location_on,
                  color: Colors.red,
                  size: 40,
                ),
              ),
            ],
          ),
      ],
    );
  }
}

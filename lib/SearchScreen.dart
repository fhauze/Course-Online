import 'package:flutter/material.dart';
import 'dart:math';
import 'package:online_course/FilteredStoreCard.dart';
import 'package:online_course/StoreDetailScreen.dart';
import 'package:online_course/models/store.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  bool useMyLocation = true;
  double radiusKm = 2.0;
  RangeValues priceRange = RangeValues(1, 3);
  RangeValues priceRng = RangeValues(10000, 1000000);
  String query = '';
  List<Store> results = mockStores;
  bool isMapView = true;
  LatLng? _selectedPoint;
  LatLng? _userLocation;
  void applyFilters() {
    // For demo: simple filtering by price and a mock distance calculation
    setState(() {
      results =
          mockStores.where((s) {
            final withinPrice =
                s.priceLevel >= priceRange.start &&
                s.priceLevel <= priceRange.end;
            final distKm = mockDistanceKm(-6.200, 106.816, s.lat, s.lng);
            final withinRadius = distKm <= radiusKm;
            final matchesQuery =
                query.isEmpty ||
                s.name.toLowerCase().contains(query.toLowerCase()) ||
                s.category.toLowerCase().contains(query.toLowerCase());
            return withinPrice && withinRadius && matchesQuery;
          }).toList();
      // Sort by distance ascending
      results.sort((a, b) {
        final da = mockDistanceKm(-6.200, 106.816, a.lat, a.lng);
        final db = mockDistanceKm(-6.200, 106.816, b.lat, b.lng);
        return da.compareTo(db);
      });
    });
  }

  Future<void> _initLocation() async {
    final loc = await _getUserLocation();
    setState(() {
      _userLocation = loc;
    });
  }

  @override
  void initState() {
    super.initState();
    _initLocation();
    applyFilters();
    // _getNearByStores();
  }

  // void _getNearByStores() async {
  //   final stores = await OSMService.fetchNearbyStores(_userLocation!);
  //   setState(() {
  //     results = stores;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: TextField(
          decoration: InputDecoration(
            hintText: 'Cari toko atau kategori',
            hintStyle: TextStyle(color: Colors.white54),
            border: InputBorder.none,
            suffixIcon: IconButton(
              onPressed: () => _openFilters(),
              icon: Icon(Icons.filter_list),
            ),
          ),
          onChanged: (v) {
            query = v;
            // debounce can be added later
            applyFilters();
          },
        ),
      ),
      body: Column(
        children: [
          // Toggle view
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
            child: Row(
              children: [
                ChoiceChip(
                  label: Text('Jelajah'),
                  selected: isMapView,
                  onSelected: (v) => setState(() => isMapView = true),
                ),
                SizedBox(width: 8),
                ChoiceChip(
                  label: Text('Terdekat'),
                  selected: !isMapView,
                  onSelected: (v) => setState(() => isMapView = false),
                ),
                Spacer(),
                Text('${results.length} hasil'),
              ],
            ),
          ),
          Expanded(
            child:
                isMapView ? _buildMapView(results, context) : _buildListView(),
          ),
        ],
      ),
    );
  }

  // Widget _buildMapView() {
  //   return Stack(
  //     children: [
  //       GoogleMap(
  //         initialCameraPosition: CameraPosition(
  //           target: LatLng(
  //             -6.200000,
  //             106.816666,
  //           ), // Jakarta pusat sebagai contoh
  //           zoom: 14,
  //         ),
  //         myLocationEnabled: true,
  //         myLocationButtonEnabled: true,
  //         zoomControlsEnabled: false,
  //         markers:
  //             results.map((s) {
  //               return Marker(
  //                 markerId: MarkerId(s.id),
  //                 position: LatLng(s.lat, s.lng),
  //                 infoWindow: InfoWindow(
  //                   title: s.name,
  //                   snippet: "${s.category} • ★ ${s.rating.toStringAsFixed(1)}",
  //                   onTap: () {
  //                     Navigator.push(
  //                       context,
  //                       MaterialPageRoute(
  //                         builder: (_) => StoreDetailScreen(store: s),
  //                       ),
  //                     );
  //                   },
  //                 ),
  //               );
  //             }).toSet(),
  //       ),

  //       DraggableScrollableSheet(
  //         initialChildSize: 0.25,
  //         minChildSize: 0.12,
  //         maxChildSize: 0.6,
  //         builder: (context, sc) {
  //           return Container(
  //             decoration: BoxDecoration(
  //               color: Colors.black54,
  //               borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
  //             ),
  //             child: ListView.builder(
  //               controller: sc,
  //               itemCount: results.length,
  //               itemBuilder: (c, i) => FilteredStoreCard(store: results[i]),
  //             ),
  //           );
  //         },
  //       ),
  //     ],
  //   );
  // }
  Widget _buildMapView(List<Store> results, BuildContext context) {
    return FlutterMap(
      options: MapOptions(
        center:
            _userLocation, //LatLng(-6.2, 106.816666), // Jakarta Pusat sebagai contoh
        zoom: 13,
        onTap: (tapPosition, point) {
          // `point` berisi LatLng(lat, lng)
          print("User tapped at: ${point.latitude}, ${point.longitude}");
          setState(() {
            _selectedPoint = point; // simpan titik yang dipilih user
          });
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
        DraggableScrollableSheet(
          initialChildSize: 0.25,
          minChildSize: 0.12,
          maxChildSize: 0.6,
          builder: (context, sc) {
            return Container(
              decoration: BoxDecoration(
                color: Colors.black54,
                borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
              ),
              child: ListView.builder(
                controller: sc,
                itemCount: results.length,
                itemBuilder: (c, i) => FilteredStoreCard(store: results[i]),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildListView() {
    return ListView.builder(
      itemCount: results.length,
      padding: const EdgeInsets.all(12),
      itemBuilder: (c, i) => FilteredStoreCard(store: results[i]),
    );
  }

  void _openFilters() async {
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, updateMDL) {
            return Container(
              height: MediaQuery.of(context).size.height * 0.6,
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Color(0xFF0F1724),
                borderRadius: BorderRadius.vertical(top: Radius.circular(18)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      width: 40,
                      height: 4,
                      color: Colors.white12,
                    ),
                  ),
                  SizedBox(height: 12),
                  Text(
                    'Filter',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 12),

                  // Location toggle + radius
                  SwitchListTile(
                    title: Text(
                      'Gunakan Lokasiku',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    value: useMyLocation,
                    onChanged: (v) => updateMDL(() => useMyLocation = v),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Text(
                      'Radius: ${radiusKm.toStringAsFixed(1)} km',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Slider(
                    min: 0.5,
                    max: 50,
                    divisions: 9,
                    value: radiusKm,
                    label: '${radiusKm} km',
                    onChanged:
                        (v) => updateMDL(
                          () => radiusKm = double.parse(v.toStringAsFixed(1)),
                        ),
                  ),

                  SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Text(
                      'Harga Range',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  RangeSlider(
                    values: priceRange,
                    min: 1,
                    max: 3,
                    divisions: 3,
                    labels: RangeLabels(
                      priceLabel(priceRange.start.toInt()),
                      priceLabel(priceRange.end.toInt()),
                    ),
                    onChanged:
                        (r) => updateMDL(
                          () =>
                              priceRange = RangeValues(
                                r.start.roundToDouble(),
                                r.end.roundToDouble(),
                              ),
                        ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Text(
                      'Rentang Harga',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  RangeSlider(
                    values: priceRng,
                    min: 1000,
                    max: 1000000,
                    divisions: 10,
                    labels: RangeLabels(
                      priceLabel(priceRange.start.toInt()),
                      priceLabel(priceRange.end.toInt()),
                    ),
                    onChanged:
                        (ac) => updateMDL(() {
                          priceRng = ac;
                        }),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [Text("Murah"), Text("Menengah"), Text("Mahal")],
                  ),

                  Spacer(),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {
                            // Reset
                            updateMDL(() {
                              useMyLocation = true;
                              radiusKm = 2.0;
                              priceRange = RangeValues(1, 3);
                            });
                          },
                          child: Text('Reset'),
                        ),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            // Apply
                            Navigator.pop(context);
                            applyFilters();
                          },
                          child: Text('Terapkan'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Future<LatLng> _getUserLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw Exception("Location services are disabled");
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception("Location permissions are denied");
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw Exception("Location permissions are permanently denied");
    }

    final pos = await Geolocator.getCurrentPosition();
    return LatLng(pos.latitude, pos.longitude);
  }

  String priceLabel(int p) =>
      p == 1 ? 'Murah' : (p == 2 ? 'Menengah' : 'Mahal');
}

double mockDistanceKm(double lat1, double lon1, double lat2, double lon2) {
  // Haversine — approximate
  const R = 6371; // km
  final dLat = _deg2rad(lat2 - lat1);
  final dLon = _deg2rad(lon2 - lon1);
  final a =
      sin(dLat / 2) * sin(dLat / 2) +
      cos(_deg2rad(lat1)) * cos(_deg2rad(lat2)) * sin(dLon / 2) * sin(dLon / 2);
  final c = 2 * atan2(sqrt(a), sqrt(1 - a));
  return R * c;
}

double _deg2rad(double deg) => deg * (pi / 180);

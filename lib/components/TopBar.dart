import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:online_course/CartScreen.dart';
import 'package:online_course/HomeScreen.dart';
import 'package:online_course/NotificationDetailScreen.dart';
import 'package:online_course/SearchScreen.dart';
import 'package:online_course/chats.dart';
import 'package:online_course/services/LocationService.dart';

class TopBar extends StatefulWidget {
  @override
  _TopBarState createState() => _TopBarState();
}

class _TopBarState extends State<TopBar> {
  String? _location = "Mencari lokasi...";
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;

  void _toggleNotifications() {
    if (_overlayEntry == null) {
      _overlayEntry = _createOverlayEntry();
      Overlay.of(context).insert(_overlayEntry!);
    } else {
      _overlayEntry?.remove();
      _overlayEntry = null;
    }
  }

  @override
  void initState() {
    super.initState();
    _getUserLocation();
  }

  Future<void> _getUserLocation() async {
    try {
      final userLatLng = await LocationService.getUserLatLng();
      if (userLatLng == null) {
        setState(() => _location = "Lokasi tidak aktif");
        return;
      }

      // Ubah jadi nama kota
      final placemarks = await placemarkFromCoordinates(
        userLatLng.latitude,
        userLatLng.longitude,
      );

      if (placemarks.isNotEmpty) {
        final place = placemarks.first;
        setState(() {
          _location = "${place.locality}, ${place.country}";
        });
      } else {
        setState(() => _location = "Lokasi tidak ditemukan");
      }
    } catch (e) {
      setState(() => _location = "Lokasi error");
    }
  }

  OverlayEntry _createOverlayEntry() {
    return OverlayEntry(
      builder:
          (context) => Positioned.fill(
            child: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () {
                _toggleNotifications(); // klik area luar → tutup panel
              },
              child: Stack(
                children: [
                  CompositedTransformFollower(
                    link: _layerLink,
                    showWhenUnlinked: false,
                    offset: const Offset(-200, 50),
                    child: Material(
                      elevation: 6,
                      borderRadius: BorderRadius.circular(12),
                      child: Container(
                        width: 250,
                        constraints: const BoxConstraints(maxHeight: 300),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: ListView(
                          padding: const EdgeInsets.all(8),
                          shrinkWrap: true,
                          children: [
                            ListTile(
                              leading: const Icon(
                                Icons.local_offer,
                                color: Colors.blue,
                              ),
                              title: const Text("Promo Diskon 50%"),
                              subtitle: const Text(
                                "Diskon besar untuk produk pilihan",
                              ),
                              onTap: () {
                                _toggleNotifications();
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder:
                                        (_) => NotificationDetailScreen(
                                          title: "Promo Diskon 50%",
                                          body:
                                              "Diskon besar untuk produk pilihan",
                                        ),
                                  ),
                                );
                              },
                            ),
                            const Divider(),
                            const ListTile(
                              leading: Icon(
                                Icons.delivery_dining,
                                color: Colors.green,
                              ),
                              title: Text("Pesanan Dikirim"),
                              subtitle: Text(
                                "Pesanan #12345 sedang dalam perjalanan",
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: Colors.white12,
            child: Icon(Icons.person),
          ),
          SizedBox(width: 12),
          Expanded(
            child: GestureDetector(
              onTap:
                  () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => SearchScreen()),
                  ),
              child: Row(
                children: [
                  Icon(Icons.location_on, size: 18, color: Colors.white70),
                  SizedBox(width: 6),
                  Text(
                    _location ?? "Memuat...",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Icon(Icons.keyboard_arrow_down, color: Colors.white70),
                ],
              ),
            ),
          ),
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.white12,
              shape: BoxShape.circle,
            ),
            child: Stack(
              children: [
                CompositedTransformTarget(
                  link: _layerLink,
                  child: IconButton(
                    onPressed: _toggleNotifications,
                    icon: Icon(Icons.notifications_none),
                  ),
                ),
                Positioned(
                  right: 0,
                  top: 0,
                  child: Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            child: Stack(
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.of(
                      context,
                    ).push(MaterialPageRoute(builder: (_) => Chats()));
                  },
                  icon: Icon(Icons.chat_bubble_outline),
                ),
                Positioned(
                  right: 0,
                  top: 0,
                  child: Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ],
            ),
          ),

          Container(
            child: Stack(
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => CartScreen()),
                    );
                  },
                  icon: Icon(Icons.shopping_cart),
                ),
                Positioned(
                  right: 0,
                  top: 0,
                  child: Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

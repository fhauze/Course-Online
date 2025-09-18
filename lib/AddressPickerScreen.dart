import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:online_course/services/LocationService.dart';

class AddressPickerScreen extends StatefulWidget {
  @override
  _AddressPickerScreenState createState() => _AddressPickerScreenState();
}

class _AddressPickerScreenState extends State<AddressPickerScreen> {
  LatLng? _currentPos;
  String? _currentAddress;
  final TextEditingController _detailController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  final MapController _mapController = MapController();

  @override
  void initState() {
    super.initState();
    _determinePosition();
  }

  Future<void> _determinePosition() async {
    final pos = await Geolocator.getCurrentPosition();
    setState(() {
      _currentPos = LatLng(pos.latitude, pos.longitude);
    });
    _updateAddress(_currentPos!);
  }

  // Future<void> _updateAddress(LatLng point) async {
  //   try {
  //     final placemarks = await placemarkFromCoordinates(
  //       point.latitude,
  //       point.longitude,
  //     );

  //     if (placemarks.isNotEmpty &&
  //         (placemarks.first.street?.isNotEmpty ?? false)) {
  //       final place = placemarks.first;
  //       setState(() {
  //         _currentAddress =
  //             "${place.street}, ${place.subLocality}, ${place.locality}";
  //       });
  //     } else {
  //       // fallback ke OSM Nominatim
  //       final osmAddress = await LocationService.reverseGeocodeWithPOI(
  //         point.latitude,
  //         point.longitude,
  //       );
  //       setState(() {
  //         _currentAddress =
  //             osmAddress ?? "Lat: ${point.latitude}, Lng: ${point.longitude}";
  //       });
  //     }
  //   } catch (e) {
  //     setState(() {
  //       _currentAddress = "Lat: ${point.latitude}, Lng: ${point.longitude}";
  //     });
  //   }
  // }
  Future<void> _updateAddress(LatLng point) async {
    try {
      List<Placemark> placemarks = [];

      try {
        placemarks = await placemarkFromCoordinates(
          point.latitude,
          point.longitude,
        );
      } catch (e) {
        // di web bisa gagal → abaikan
        debugPrint("placemarkFromCoordinates error: $e");
      }

      if (placemarks.isNotEmpty &&
          (placemarks.first.street?.isNotEmpty ?? false)) {
        final place = placemarks.first;
        setState(() {
          _currentAddress =
              "${place.street}, ${place.subLocality}, ${place.locality}";
        });
        return; // cukup pakai hasil ini, ga perlu lanjut ke OSM
      }

      // fallback ke OSM
      final osmAddress = await LocationService.reverseGeocodeWithPOI(
        point.latitude,
        point.longitude,
      );

      setState(() {
        _currentAddress = osmAddress;
      });
    } catch (e) {
      setState(() {
        _currentAddress =
            "Lat: ${point.latitude}, Lng: ${point.longitude}"; // fallback terakhir
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Pilih Alamat")),
      body:
          _currentPos == null
              ? Center(child: CircularProgressIndicator())
              : Stack(
                children: [
                  FlutterMap(
                    mapController: _mapController,
                    options: MapOptions(
                      center: _currentPos,
                      zoom: 16,
                      onTap: (tapPos, point) {
                        setState(() => _currentPos = point);
                        _updateAddress(point);
                      },
                    ),
                    children: [
                      TileLayer(
                        urlTemplate:
                            "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
                        userAgentPackageName: 'com.example.marketplace',
                      ),
                      MarkerLayer(
                        markers: [
                          Marker(
                            point: _currentPos!,
                            width: 40,
                            height: 40,
                            child: Icon(
                              Icons.location_pin,
                              color: Colors.red,
                              size: 40,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  // Panel bawah
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(16),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 8,
                            offset: Offset(0, -2),
                          ),
                        ],
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              _currentAddress ??
                                  "Alamat tidak dikenali, gunakan koordinat berikut:\n"
                                      "Lat: ${_currentPos!.latitude.toStringAsFixed(5)}, "
                                      "Lng: ${_currentPos!.longitude.toStringAsFixed(5)}",
                              style: TextStyle(fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 12),
                            TextField(
                              controller: _detailController,
                              decoration: InputDecoration(
                                labelText: "Detail bangunan",
                                hintText: "Contoh: Rumah cat biru, Blok A2",
                                border: OutlineInputBorder(),
                              ),
                            ),
                            SizedBox(height: 12),
                            TextField(
                              controller: _noteController,
                              decoration: InputDecoration(
                                labelText: "Penanda tambahan",
                                hintText:
                                    "Contoh: Sebelah masjid, dekat minimarket",
                                border: OutlineInputBorder(),
                              ),
                            ),
                            SizedBox(height: 16),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context, {
                                  "address":
                                      _currentAddress ??
                                      "Lat: ${_currentPos!.latitude}, Lng: ${_currentPos!.longitude}",
                                  "detail": _detailController.text,
                                  "note": _noteController.text,
                                });
                              },
                              child: Text("Gunakan Lokasi Ini"),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final pos = await Geolocator.getCurrentPosition();
          setState(() => _currentPos = LatLng(pos.latitude, pos.longitude));
          _mapController.move(_currentPos!, 16);
          _updateAddress(_currentPos!);
        },
        child: Icon(Icons.my_location),
      ),
    );
  }
}

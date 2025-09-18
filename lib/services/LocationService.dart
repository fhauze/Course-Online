import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class LocationService {
  /// Ambil koordinat user (LatLng)
  static Future<LatLng?> getUserLatLng() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) return null;

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) return null;
    }
    if (permission == LocationPermission.deniedForever) return null;

    final pos = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    return LatLng(pos.latitude, pos.longitude);
  }

  // static Future<String?> reverseGeocodeOSM(double lat, double lon) async {
  //   final url = Uri.parse(
  //     "https://nominatim.openstreetmap.org/reverse?format=jsonv2&lat=$lat&lon=$lon",
  //   );

  //   final response = await http.get(
  //     url,
  //     headers: {
  //       "User-Agent": "UKM_market_place", // wajib ada user agent
  //     },
  //   );

  //   if (response.statusCode == 200) {
  //     final data = json.decode(response.body);
  //     debugPrint(data.toString());
  //     return data["display_name"]; // ini alamat lengkap
  //   }
  //   return null;
  // }

  static Future<String> reverseGeocodeWithPOI(double lat, double lon) async {
    String addrName = '';
    final url = Uri.parse(
      "https://nominatim.openstreetmap.org/reverse?format=jsonv2&lat=$lat&lon=$lon&addressdetails=1&zoom=18&extratags=1",
    );

    final response = await http.get(
      url,
      headers: {"User-Agent": "your_app_name"},
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      // Ambil name kalau ada
      final name = data["name"];
      final displayName = data["display_name"];

      addrName = data["display_name"];

      // if (name != null && name.toString().isNotEmpty) {
      //   return name; // misalnya "YRS.10"
      // }

      // if (displayName != null) {
      //   return displayName; // fallback alamat panjang
      // }
    }

    return addrName;
    // return "Lat: $lat, Lng: $lon";
    // return LatLng(lat, lon);
  }
}

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:latlong2/latlong.dart';
import 'package:online_course/models/store.dart';

class OSMService {
  static Future<List<Store>> fetchNearbyStores(
    LatLng userLocation, {
    int radius = 1000,
  }) async {
    final url = Uri.parse(
      'https://overpass-api.de/api/interpreter?data=[out:json];'
      '(node["shop"](around:$radius,${userLocation.latitude},${userLocation.longitude});'
      'way["shop"](around:$radius,${userLocation.latitude},${userLocation.longitude});'
      'relation["shop"](around:$radius,${userLocation.latitude},${userLocation.longitude}););'
      'out center;',
    );

    final res = await http.get(url);
    if (res.statusCode != 200) {
      throw Exception("Gagal ambil data dari Overpass API");
    }

    final data = json.decode(res.body);
    List<Store> stores = [];

    for (var el in data['elements']) {
      final id = el['id'].toString();
      final lat = el['lat'] ?? el['center']?['lat'];
      final lon = el['lon'] ?? el['center']?['lon'];

      if (lat == null || lon == null) continue;

      final tags = el['tags'] ?? {};
      final name = tags['name'] ?? 'Toko tanpa nama';
      final category = tags['shop'] ?? 'unknown';

      stores.add(
        Store(
          id: id,
          name: name,
          category: category,
          lat: lat.toDouble(),
          lng: lon.toDouble(),
          rating: 0.0, // placeholder (bisa nanti ambil dari API lain)
          priceLevel: 0, // placeholder
          heroImage: "https://picsum.photos/seed/$id/300/200", // dummy image
          price: 0, // placeholder
        ),
      );
    }

    return stores;
  }
}

import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

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

// logic recommend

// score = α*(view_count) + β*(purchase_count) + γ*(store_visit) + δ*(category_match) + ε*(search_similarity)

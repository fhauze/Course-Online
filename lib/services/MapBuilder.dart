import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:online_course/StoreDetailScreen.dart';
import 'package:online_course/models/store.dart';
import 'package:latlong2/latlong.dart';

class MapBuilder extends StatelessWidget {
  final List<Store> results;
  final MapController mapController;
  final LatLng? userLocation;
  final LatLng? selectedPoint;

  const MapBuilder({
    super.key,
    required this.results,
    required this.mapController,
    required this.userLocation,
    required this.selectedPoint,
  });

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      mapController: mapController,
      options: MapOptions(
        center: userLocation ?? LatLng(-6.2, 106.816666),
        zoom: 14,
        onTap: (tapPosition, point) {
          print("User tapped at: ${point.latitude}, ${point.longitude}");
        },
      ),
      children: [
        TileLayer(
          urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
          userAgentPackageName: 'com.example.marketplace',
        ),
        // Marker toko
        MarkerLayer(
          markers:
              results.map((s) {
                return Marker(
                  point: LatLng(s.lat, s.lng),
                  width: 40,
                  height: 40,
                  child: IconButton(
                    icon: const Icon(Icons.store, color: Colors.red),
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
        // Marker user
        if (userLocation != null)
          MarkerLayer(
            markers: [
              Marker(
                point: userLocation!,
                width: 40,
                height: 40,
                child: const Icon(
                  Icons.my_location,
                  color: Colors.blue,
                  size: 30,
                ),
              ),
            ],
          ),
        // Marker custom jika user tap
        if (selectedPoint != null)
          MarkerLayer(
            markers: [
              Marker(
                point: selectedPoint!,
                width: 40,
                height: 40,
                child: const Icon(
                  Icons.location_on,
                  color: Colors.green,
                  size: 40,
                ),
              ),
            ],
          ),
      ],
    );
  }
}

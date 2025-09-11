import 'package:flutter/material.dart';
import 'package:online_course/StoreDetailScreen.dart';
import 'package:online_course/models/store.dart';

import 'util/utils.dart';

class FilteredStoreCard extends StatelessWidget {
  final Store store;
  const FilteredStoreCard({required this.store});
  @override
  Widget build(BuildContext context) {
    final dist = mockDistanceKm(-6.200, 106.816, store.lat, store.lng);
    return Card(
      color: Colors.white10,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: EdgeInsets.symmetric(vertical: 8),
      child: InkWell(
        onTap:
            () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => StoreDetailScreen(store: store),
              ),
            ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  store.heroImage,
                  width: 90,
                  height: 70,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          store.name,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Spacer(),
                        Text('€' * store.priceLevel),
                      ],
                    ),
                    SizedBox(height: 6),
                    Text(
                      '${store.category} • ${dist.toStringAsFixed(1)} km • ★ ${store.rating.toStringAsFixed(1)}',
                      style: TextStyle(color: Colors.white70),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:online_course/StoreDetailScreen.dart';
import 'package:online_course/models/store.dart';

class RecommendedCard extends StatelessWidget {
  final Store store;
  const RecommendedCard({required this.store});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:
          () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => StoreDetailScreen(store: store)),
          ),
      child: Container(
        width: 240,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          gradient: LinearGradient(
            colors: [Color(0xFF6EE7B7), Color(0xFF7C3AED)],
          ),
        ),
        child: Stack(
          children: [
            Positioned.fill(
              child: Opacity(
                opacity: 0.2,
                child: Image.network(store.heroImage, fit: BoxFit.cover),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    store.name,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 6),
                  Text(
                    '${store.category} • ★ ${store.rating.toStringAsFixed(1)}',
                    style: TextStyle(color: Colors.white70),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

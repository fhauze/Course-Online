import 'package:flutter/material.dart';
import 'package:online_course/SearchScreen.dart';

class HeroSearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap:
          () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => SearchScreen()),
          ),
      child: Container(
        height: 54,
        padding: EdgeInsets.symmetric(horizontal: 14),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.04),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(Icons.search, color: Colors.white70),
            SizedBox(width: 12),
            Expanded(
              child: Text(
                'Cari toko, produk, atau lokasi',
                style: TextStyle(color: Colors.white54),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.white12,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Icon(Icons.filter_list, size: 16),
                  SizedBox(width: 6),
                  Text('Filters'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

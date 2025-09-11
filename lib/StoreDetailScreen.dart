import 'package:flutter/material.dart';
import 'package:online_course/components/ProductTile.dart';
import 'package:online_course/models/store.dart';

class StoreDetailScreen extends StatelessWidget {
  final Store store;
  const StoreDetailScreen({required this.store});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 240,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(store.name),
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(store.heroImage, fit: BoxFit.cover),
                  Container(color: Colors.black26),
                ],
              ),
            ),
            actions: [
              IconButton(onPressed: () {}, icon: Icon(Icons.bookmark_border)),
              IconButton(onPressed: () {}, icon: Icon(Icons.share)),
            ],
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Chip(label: Text(store.category)),
                      SizedBox(width: 8),
                      Icon(Icons.star, size: 18),
                      Text(store.rating.toStringAsFixed(1)),
                      Spacer(),
                      Text('Buka sekarang'),
                    ],
                  ),
                  SizedBox(height: 12),
                  Text(
                    'Alamat: Jl. Contoh No. 123, Jakarta',
                    style: TextStyle(color: Colors.white70),
                  ),
                  SizedBox(height: 12),
                  Text(
                    'Menu Unggulan',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Column(
                    children: List.generate(4, (i) => ProductTile(index: i)),
                  ),
                  SizedBox(height: 80),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomSheet: Container(
        color: Colors.transparent,
        padding: EdgeInsets.all(12),
        child: Row(
          children: [
            Expanded(
              child: Text(
                'Subtotal 0 items',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            ElevatedButton(onPressed: () {}, child: Text('Order Now')),
          ],
        ),
      ),
    );
  }
}

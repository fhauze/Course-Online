import 'package:flutter/material.dart';

class ProductTile extends StatelessWidget {
  final int index;
  const ProductTile({required this.index});
  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.network(
          'https://picsum.photos/seed/p\$index/120/80',
          width: 80,
          fit: BoxFit.cover,
        ),
      ),
      title: Text(
        'Product \$index',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Text('Short description'),
      trailing: IntrinsicHeight(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('€${(index + 1) * 2}'),
            // SizedBox(height: 6),
            ElevatedButton(
              onPressed: () {},
              child: Text('Add'),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                visualDensity: VisualDensity.compact,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

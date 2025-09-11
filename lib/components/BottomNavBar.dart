import 'package:flutter/material.dart';
import 'package:online_course/SearchScreen.dart';

class BottomNav extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: CircularNotchedRectangle(),
      color: Colors.black26,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(onPressed: () {}, icon: Icon(Icons.home)),
            IconButton(
              onPressed:
                  () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => SearchScreen()),
                  ),
              icon: Icon(Icons.search),
            ),
            SizedBox(width: 48),
            IconButton(onPressed: () {}, icon: Icon(Icons.receipt_long)),
            IconButton(onPressed: () {}, icon: Icon(Icons.person)),
          ],
        ),
      ),
    );
  }
}

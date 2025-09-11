import 'package:flutter/material.dart';
import 'package:online_course/SearchScreen.dart';

class TopBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: Colors.white12,
            child: Icon(Icons.person),
          ),
          SizedBox(width: 12),
          Expanded(
            child: GestureDetector(
              onTap:
                  () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => SearchScreen()),
                  ),
              child: Row(
                children: [
                  Icon(Icons.location_on, size: 18, color: Colors.white70),
                  SizedBox(width: 6),
                  Text(
                    'Jakarta, ID',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Icon(Icons.keyboard_arrow_down, color: Colors.white70),
                ],
              ),
            ),
          ),
          IconButton(onPressed: () {}, icon: Icon(Icons.notifications_none)),
          IconButton(onPressed: () {}, icon: Icon(Icons.chat_bubble_outline)),
        ],
      ),
    );
  }
}

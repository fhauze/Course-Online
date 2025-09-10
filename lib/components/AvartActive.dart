import 'package:flutter/material.dart';

class AvatarActive extends StatelessWidget {
  final String label;
  final bool isActive;

  const AvatarActive({super.key, required this.label, this.isActive = false});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CircleAvatar(
          radius: 35,
          backgroundColor: Colors.white,
          backgroundImage: AssetImage("assets/images/profile.png"),
        ),

        if (isActive)
          Positioned(
            top: 10,
            right: 0,
            child: Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.green,
              ),
            ),
          ),
      ],
    );
  }
}

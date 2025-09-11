import 'package:flutter/material.dart';

class NavBar extends StatelessWidget {
  const NavBar({super.key});

  @override
  Widget build(BuildContext context) {
    const profilePath = "assets/images/profile.jpg";
    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text("UserKamu"),
            accountEmail: Text("emailkamu@example.com"),
            currentAccountPicture: CircleAvatar(
              // backgroundImage:
              //     (profilePath.isNotEmpty) ? AssetImage(profilePath) : null,
              child:
              // (profilePath.isEmpty) ?
              Icon(Icons.person, size: 40),
              // : null,
            ),

            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/banner.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text("Home"),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text("Profile"),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text("Settings"),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}

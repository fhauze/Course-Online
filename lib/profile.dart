import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:online_course/CartScreen.dart';
import 'package:online_course/VendorDashboard.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key});

  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  dynamic _profileImage;
  dynamic _headerImage;
  ImageProvider? imageProvider;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage(bool isProfile) async {
    if (kIsWeb) {
    } else {
      final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        final imageFile = File(pickedFile.path);
        setState(() {
          if (isProfile) {
            _profileImage = imageFile;
          } else {
            _headerImage = imageFile;
          }

          imageProvider =
              kIsWeb ? MemoryImage(_profileImage) : FileImage(_profileImage);
        });
      } else {
        imageProvider = AssetImage("assets/images/luffy.png");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final buttonScanSize = screenWidth * 0.20;
    final double bottomPadding = (9000 / screenWidth).clamp(0, 0.2);
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(backgroundColor: const Color.fromARGB(255, 3, 66, 126)),
      body: Stack(
        children: [
          Container(color: const Color.fromARGB(255, 3, 66, 126), height: 150),
          SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 200),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20.0,
                    vertical: 5,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 241, 238, 238),
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(20),
                        bottom: Radius.circular(20),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withValues(alpha: 0.8),
                          spreadRadius: 1,
                          blurRadius: 1,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: ListView(
                      shrinkWrap: true,
                      padding: EdgeInsets.symmetric(horizontal: 0),
                      children: [
                        _buildListItem(Icons.person, "Akun", () {}),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25.0),
                          child: Divider(height: 0),
                        ),
                        _buildListItem(Icons.person, "Statistik Penjualan", () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => VendorDashboard(),
                            ),
                          );
                        }),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25.0),
                          child: Divider(height: 0),
                        ),
                        _buildListItem(Icons.person, "Point Saya", () {}),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 25.0,
                            vertical: 0,
                          ),
                          child: Divider(height: 0),
                        ),
                        SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 241, 238, 238),
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(20),
                        bottom: Radius.circular(20),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withValues(alpha: 0.8),
                          spreadRadius: 1,
                          blurRadius: 1,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        _buildListItem(
                          Icons.lock,
                          "FAQ",
                          () => {},
                        ), // bisa diubah disini
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 241, 238, 238),
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(20),
                        bottom: Radius.circular(20),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withValues(alpha: 0.8),
                          spreadRadius: 1,
                          blurRadius: 1,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        _buildListItem(
                          Icons.language,
                          "Kebijakan & Privasi",
                          () => {},
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 241, 238, 238),
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(20),
                        bottom: Radius.circular(20),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withValues(alpha: 0.8),
                          spreadRadius: 1,
                          blurRadius: 1,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        _buildListItem(Icons.language, "Bantuan", () => {}),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 241, 238, 238),
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(20),
                        bottom: Radius.circular(20),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withValues(alpha: 0.8),
                          spreadRadius: 1,
                          blurRadius: 1,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        _buildListItem(
                          Icons.logout,
                          "Keluar",
                          isLogout: true,
                          () => {},
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 0,
            left: screenWidth / 2 - 52,
            child: Container(
              width: 100,
              child: Image.asset('assets/images/logo.png', width: 80),
            ),
          ),
          Positioned(
            top: 90,
            right: MediaQuery.of(context).size.width / 2 - 50,
            child: GestureDetector(
              onTap: () => _pickImage(true),
              child: Stack(
                alignment: Alignment.centerLeft,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Color.fromARGB(255, 3, 66, 126),
                        width: 4,
                      ),
                    ),
                    child: CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.grey[300],
                      backgroundImage:
                          _profileImage != null
                              ? (kIsWeb
                                  ? MemoryImage(_profileImage) as ImageProvider
                                  : FileImage(_profileImage) as ImageProvider)
                              : null,
                      child:
                          _profileImage == null
                              ? Image.asset("assets/images/luffy.png")
                              : null,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildListItem(
    IconData icon,
    String label,
    VoidCallback onTap, {
    bool isLogout = false,
  }) {
    return ListTile(
      leading: Icon(
        icon,
        color:
            isLogout
                ? const Color.fromARGB(255, 181, 47, 47)
                : const Color.fromARGB(255, 54, 52, 52),
      ),
      title: Text(label, style: TextStyle(fontSize: 16, color: Colors.black)),
      trailing: Icon(Icons.arrow_forward_ios, size: 16),
      onTap: onTap,
    );
  }
}

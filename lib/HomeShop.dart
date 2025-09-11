import 'package:flutter/material.dart';
import 'package:online_course/SearchScreen.dart';

class Homeshop extends StatefulWidget {
  const Homeshop({super.key});

  @override
  State<Homeshop> createState() => _HomeshopState();
}

class _HomeshopState extends State<Homeshop> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 49, 147, 196),
      appBar: CustomAppBar(title: "title", subTitle: "subTitle"),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            height: 40,
            color: const Color.fromARGB(255, 21, 195, 105),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.qr_code),
                  VerticalDivider(
                    color: const Color.fromARGB(255, 145, 141, 141),
                  ),
                  Text("Home"),
                  VerticalDivider(color: Color.fromARGB(255, 145, 141, 141)),
                  Text("Home"),
                  VerticalDivider(color: Color.fromARGB(255, 145, 141, 141)),
                  Text("Home"),
                ],
              ),
            ),
          ),
          SizedBox(height: 2),
          Container(
            width: double.infinity,
            height: 70,
            color: const Color.fromARGB(255, 56, 24, 112),
          ),
          Container(
            height: 200,
            width: double.infinity,
            child: Row(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width / 2,
                  color: Colors.cyan,
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 2,
                  color: Colors.amber,
                ),
              ],
            ),
          ),
          Expanded(
            child: GridView.builder(
              itemCount: 10,
              // itemExtent: 80,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 2,
              ),
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Container(
                    color: const Color.fromARGB(255, 118, 5, 84),
                    child: Center(child: Text("Item $index")),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'Business',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.school), label: 'School'),
        ],
        currentIndex: 0,
        selectedItemColor: Colors.amber[800],
      ),
    );
  }
}

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final String subTitle;
  const CustomAppBar({super.key, required this.title, required this.subTitle});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.yellow,
      width: double.infinity,
      height: 50,
      child: Column(
        children: [
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 10),
              //   child: GestureDetector(
              //     child: Icon(Icons.arrow_back, size: 27),
              //     onTap: () {
              //       Navigator.pop(context);
              //     },
              //   ),
              // ),
              Expanded(
                child: SizedBox(
                  height: 35,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: GestureDetector(
                      onTap:
                          () => Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => SearchScreen()),
                          ),
                      child: Container(
                        height: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          color: Colors.white.withOpacity(0.04),
                          border: Border.all(
                            color: const Color.fromARGB(137, 146, 141, 141),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            'Mini Map Placeholder — Tap to explore',
                            style: TextStyle(color: Colors.white70),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 10),
              //   child: Icon(Icons.search),
              // ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(50);
}

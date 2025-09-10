import 'package:flutter/material.dart';
import 'package:online_course/components/AvartActive.dart';

class ChatOpen extends StatefulWidget {
  @override
  State<ChatOpen> createState() => _ChatOpenState();
}

class _ChatOpenState extends State<ChatOpen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Chat", subTitle: "Message"),
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) {
                  return Row(
                    mainAxisAlignment:
                        index.isEven
                            ? MainAxisAlignment.start
                            : MainAxisAlignment.end,
                    children: [
                      Container(
                        margin: const EdgeInsets.all(10),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color:
                              index.isEven
                                  ? const Color.fromARGB(
                                    255,
                                    192,
                                    86,
                                    86,
                                  ) // merah untuk kiri
                                  : Colors.indigo, // biru untuk kanan
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          "Pesan $index",
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
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
      width: double.infinity,
      height: 100,
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
      ),
      child: Column(
        children: [
          SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: GestureDetector(
                  child: Icon(Icons.arrow_back, size: 27),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              Column(
                children: [
                  Text(
                    "User",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Online",
                    style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Icon(Icons.search),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(100);
}

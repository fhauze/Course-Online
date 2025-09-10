import 'package:flutter/material.dart';
import 'package:online_course/NavBar.dart';
import 'package:online_course/chats.dart';

class CourseDetail extends StatefulWidget {
  final String? title;
  const CourseDetail({Key? key, this.title}) : super(key: key);
  @override
  State<CourseDetail> createState() => _CourseDetailState();
}

class _CourseDetailState extends State<CourseDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Course Detail", subTitle: widget.title),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
        child: Container(
          child: Column(
            children: [
              Expanded(
                child: Container(
                  height: 300,
                  child: SingleChildScrollView(
                    child: DataTable(
                      columns: [
                        DataColumn(
                          label: Text(
                            "Lessons",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            "Duration",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                      rows: [
                        for (int i = 0; i < 10; i++)
                          DataRow(
                            cells: [
                              DataCell(
                                Container(width: 200, child: Text("Lesson $i")),
                              ),
                              DataCell(
                                Container(width: 200, child: Text("$i:30")),
                              ),
                            ],
                          ),
                        //
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              SizedBox(
                height: 20,
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Lessons Summary",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
              ),
              SizedBox(
                height: 130,
                child: ListView.builder(
                  padding: EdgeInsets.all(10),
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder:
                      (context, index) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.indigo,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          height: 100,
                          width: 70,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(height: 10),
                              Icon(
                                Icons.video_chat,
                                color: Colors.white,
                                size: 40,
                              ),
                              SizedBox(height: 10),
                              if (index == 0)
                                GestureDetector(
                                  child: Center(
                                    child: Text(
                                      "data $index",
                                      style: TextStyle(
                                        color: Colors.blueAccent,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  onTap: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => Chats(),
                                      ),
                                    );
                                  },
                                )
                              else
                                Center(
                                  child: Text(
                                    "data $index",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),

                              SizedBox(height: 10),
                            ],
                          ),
                        ),
                      ),
                  itemCount: 10,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final String? subTitle;
  const CustomAppBar({Key? key, required this.title, this.subTitle})
    : super(key: key);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(bottomRight: Radius.circular(50)),
          ),
          width: double.infinity,
          height: 190,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(bottomRight: Radius.circular(50)),
              color: Colors.indigo,
            ),
          ),
        ),

        Positioned(
          top: 20,
          right: 10,
          left: 10,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    child: Icon(Icons.arrow_back, color: Colors.white),
                    onTap: () => Navigator.pop(context),
                  ),
                  Text(title, style: TextStyle(color: Colors.white)),
                  Icon(Icons.abc, color: Colors.white),
                ],
              ),
              SizedBox(height: 80),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        this.subTitle ?? "",
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        "Jobs and School",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),

                  Padding(
                    padding: const EdgeInsets.only(right: 50),
                    child: Icon(
                      Icons.monetization_on,
                      color: Colors.white,
                      size: 40,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(200);
}

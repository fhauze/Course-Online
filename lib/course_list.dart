import 'package:flutter/material.dart';
import 'package:online_course/cource_detail.dart';

class CourseList extends StatefulWidget {
  const CourseList({Key? key}) : super(key: key);
  @override
  State<CourseList> createState() => _CourseListState();
}

class _CourseListState extends State<CourseList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
        child: Container(
          child: ListView.builder(
            itemCount: 10,
            itemBuilder:
                (context, index) => Container(
                  height: 100,
                  margin: EdgeInsets.all(10),
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: index % 2 == 0 ? Colors.indigo : Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 3,
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Course ${index + 1}",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: index % 2 == 0 ? Colors.white : Colors.black,
                        ),
                      ),

                      GestureDetector(
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            // borderRadius: BorderRadius.circular(20),
                            shape: BoxShape.circle,
                            border: Border.all(
                              color:
                                  index % 2 == 0 ? Colors.white : Colors.black,
                            ),
                            // color: Colors.green,
                          ),
                          child: Icon(
                            index == 1 ? Icons.money_off : Icons.access_alarm,
                            color: index % 2 == 0 ? Colors.white : Colors.black,
                          ),
                        ),
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder:
                                  (BuildContext context) => CourseDetail(
                                    title: "Course ${index + 1}",
                                  ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
          ),
        ),
      ),
    );
  }
}

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
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
          child: ClipRRect(
            borderRadius: BorderRadius.only(bottomRight: Radius.circular(50)),
            child: Image(
              image: Image.asset("assets/images/banner.png").image,
              fit: BoxFit.cover,
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
                  Icon(Icons.abc, color: Colors.white),
                ],
              ),
              SizedBox(height: 100),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Engish",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    "Main Units",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
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

import 'package:flutter/material.dart';

class NodelCenter extends StatefulWidget {
  const NodelCenter({super.key});

  @override
  State<NodelCenter> createState() => _NodelCenterState();
}

class _NodelCenterState extends State<NodelCenter> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xFFf7f8fc),
      appBar: AppBar(
        backgroundColor: const Color(0xFFf7f8fc),
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios,
            size: height / 40,
          ),
        ),
        title: Text(
          "Nobel Center",
          style: TextStyle(fontSize: height / 40),
        ),
        actions: [
          Container(
            color: Colors.yellow,
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: width / 30, vertical: height / 100),
              child: Row(
                children: [
                  Icon(
                    Icons.star,
                    size: height / 60,
                  ),
                  Text(
                    " VIP",
                    style: TextStyle(
                        fontSize: height / 60,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: width / 30,
              vertical: height / 100,
            ),
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                  'https://images.pexels.com/photos/13870516/pexels-photo-13870516.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
                ),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Text(
                          'Gift Income',
                          style: TextStyle(
                            fontSize: height / 60,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: height / 30),
                          height: height / 200,
                          width: width / 10,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: const Color(0xFFE05DD3),
                          ),
                        ),
                      ],
                    ),
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Text(
                          'Gift Income',
                          style: TextStyle(
                            fontSize: height / 60,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: height / 30),
                          height: height / 200,
                          width: width / 10,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: const Color(0xFFE05DD3),
                          ),
                        ),
                      ],
                    ),
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Text(
                          'Gift Income',
                          style: TextStyle(
                            fontSize: height / 60,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: height / 30),
                          height: height / 200,
                          width: width / 10,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: const Color(0xFFE05DD3),
                          ),
                        ),
                      ],
                    ),
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Text(
                          'Gift Income',
                          style: TextStyle(
                            fontSize: height / 60,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: height / 30),
                          height: height / 200,
                          width: width / 10,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: const Color(0xFFE05DD3),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: height / 5,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: width / 30,
                  ),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: width / 30,
                      vertical: height / 100,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              children: [
                                Text(
                                  "INR 56789",
                                  style: TextStyle(
                                    fontSize: height / 40,
                                  ),
                                ),
                                Text(
                                  "Total Income",
                                  style: TextStyle(
                                    fontSize: height / 60,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                                height: height / 20,
                                child: const VerticalDivider()),
                            Column(
                              children: [
                                Text(
                                  "INR 56789",
                                  style: TextStyle(
                                    fontSize: height / 40,
                                  ),
                                ),
                                Text(
                                  "Total Income",
                                  style: TextStyle(
                                    fontSize: height / 60,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Text(
                          "Lorem Ipsum has been the industry's standard dummy text ever since the 1500s",
                          style: TextStyle(
                            fontSize: height / 60,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: height / 50,
          ),
          Expanded(
              child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: width / 30,
                vertical: height / 100,
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(width: width / 5, child: const Divider()),
                      Text(
                        "Display privileges",
                        style: TextStyle(
                          fontSize: height / 60,
                        ),
                      ),
                      SizedBox(width: width / 5, child: const Divider()),
                    ],
                  ),
                  Image.asset(
                    "assets/nodel1.png",
                  ),
                  Image.asset(
                    "assets/nodel2.png",
                  ),
                  Image.asset(
                    "assets/nodel3.png",
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(width: width / 5, child: const Divider()),
                      Text(
                        "Pratical privileges",
                        style: TextStyle(
                          fontSize: height / 60,
                        ),
                      ),
                      SizedBox(width: width / 5, child: const Divider()),
                    ],
                  ),
                  Image.asset(
                    "assets/nodel4.png",
                  ),
                ],
              ),
            ),
          ))
        ],
      ),
    );
  }
}

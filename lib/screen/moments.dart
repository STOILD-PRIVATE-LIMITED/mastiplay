import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_octicons/flutter_octicons.dart';
import 'package:spinner_try/model/model.dart';
import 'package:spinner_try/screen/share_moments.dart';
import 'package:spinner_try/shivanshu/utils.dart';
import 'package:http/http.dart' as http;

class Moments extends StatefulWidget {
  const Moments({super.key});

  @override
  State<Moments> createState() => _MomentsState();
}

class _MomentsState extends State<Moments> {
  String url = "https://s65zvs58-3002.inc1.devtunnels.ms";

  List<String> tags = [
    "mastiplay",
    'hot',
  ];

  sendPost() async {
    await http.post(
      Uri.parse('$url/'),
      body: {
        'id': '1',
        'title': 'Doodle',
        'description': 'A book about a doodle',
        'imageUrl': 'Image URl HERE',
        'likes': 3,
        'tags': tags,
      },
    );
  }

  List<MomentsModel> momentsModel = [];

  getAllMoments() async {
    final response = await http.get(Uri.parse("$url/moments"), headers: {
      "Accept": "application/json",
    });
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      momentsModel = data['moments']
          .map<MomentsModel>((json) => MomentsModel.fromJson(json))
          .toList();
      print(momentsModel.length);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      floatingActionButton: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(bottom: 100.sp),
          child: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ShareMoments(),
                ),
              );
            },
            child: const Icon(
              Icons.camera,
              color: Colors.black,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
              vertical: height / 20, horizontal: width / 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Text(
                        'Moments',
                        style: TextStyle(
                            fontSize: height / 30,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 2),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: height / 25),
                        height: height / 200,
                        width: width / 4,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: const Color(0xFFE05DD3),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: height / 30,
                    child: Row(
                      children: [
                        Image.asset('assets/Tick-Square.png'),
                        SizedBox(
                          width: width / 30,
                        ),
                        Image.asset('assets/Notifications.png'),
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(
                height: height / 40,
              ),
              Container(
                width: width,
                height: height / 15,
                decoration: const BoxDecoration(
                  color: Color(0xFFE2FBF5),
                ),
                padding: EdgeInsets.only(left: width / 30),
                alignment: Alignment.centerLeft,
                child: Text("#mastiplay official",
                    style: TextStyle(
                        fontSize: height / 40,
                        fontWeight: FontWeight.bold,
                        color: Colors.black)),
              ),
              SizedBox(
                height: height / 40,
              ),
              Row(
                children: [
                  Container(
                    height: height / 20,
                    width: width / 3,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: const Color(0xFFE05DD3),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '🔥Hot',
                          style: TextStyle(
                              fontSize: height / 45,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: width / 30,
                  ),
                  Container(
                    height: height / 20,
                    width: width / 3,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: const Color(0xFFE7E4E0),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '⌛Recent',
                          style: TextStyle(
                              fontSize: height / 45,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: height / 40,
              ),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: width / 25),
                        child: Row(
                          children: [
                            const Icon(Icons.abc),
                            SizedBox(
                              width: width / 30,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Name...",
                                  style: TextStyle(
                                      fontSize: height / 45,
                                      color: Colors.black),
                                ),
                                Text(
                                  "Time",
                                  style: TextStyle(
                                      fontSize: height / 55,
                                      color: Colors.grey),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              sendPost();
                            },
                            child: Container(
                              height: height / 20,
                              width: width / 5,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                border: Border.all(color: Colors.yellow),
                              ),
                              alignment: Alignment.center,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.person_add,
                                    color: Colors.yellow,
                                    size: height / 50,
                                  ),
                                  Text(
                                    'Follow',
                                    style: TextStyle(
                                        fontSize: height / 60,
                                        color: Colors.yellow),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            width: width / 30,
                          ),
                          const Icon(
                            Icons.more_vert,
                            color: Colors.grey,
                          )
                        ],
                      ),
                    ],
                  ),
                  Container(
                    height: height / 2.8,
                    width: width,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: const Color(0xFFE2FBF5),
                    ),
                    child: const Icon(
                      Icons.abc,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(
                    height: height / 40,
                  ),
                  const Row(
                    children: [Text("_____ ❤️❤️❤️❤️❤️")],
                  ),
                  SizedBox(
                    height: height / 40,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      height: height / 40,
                      width: width / 5,
                      padding: EdgeInsets.only(left: width / 30),
                      decoration: BoxDecoration(
                        color: const Color(0xFFf0f9fc),
                        borderRadius: BorderRadius.circular(40),
                      ),
                      alignment: Alignment.center,
                      child: Row(
                        children: [
                          Icon(
                            Icons.ac_unit,
                            color: Colors.yellow,
                            size: height / 50,
                          ),
                          SizedBox(
                            width: width / 60,
                          ),
                          Text(
                            'HOT',
                            style: TextStyle(
                                fontSize: height / 60, color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height / 40,
                  ),
                  Row(
                    children: [
                      const Icon(OctIcons.thumbsup_16),
                      SizedBox(
                        width: width / 40,
                      ),
                      const Text("1.5k"),
                      const SizedBox(
                        width: 10,
                      ),
                      const Icon(Icons.comment),
                      SizedBox(
                        width: width / 40,
                      ),
                      const Text("1.5k"),
                      SizedBox(
                        width: width / 40,
                      ),
                      const Icon(Icons.share),
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class RoomSetting extends StatefulWidget {
  const RoomSetting({super.key});

  @override
  State<RoomSetting> createState() => _RoomSettingState();
}

class _RoomSettingState extends State<RoomSetting> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            width: width,
            height: height / 3.2,
            padding: EdgeInsets.symmetric(
                horizontal: width / 30, vertical: height / 40),
            decoration: const BoxDecoration(
              color: Color(0xFFCEC3C3),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Room Settings",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, fontSize: height / 40),
                ),
                SizedBox(
                  height: height / 40,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        Container(
                          width: width / 5,
                          height: height / 20,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Icon(
                            Icons.mic,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          "Room type",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: height / 50),
                        )
                      ],
                    ),
                    Column(
                      children: [
                        Container(
                          width: width / 5,
                          height: height / 20,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Icon(
                            Icons.mic,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          "Edit room",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: height / 50),
                        )
                      ],
                    ),
                    Column(
                      children: [
                        Container(
                          width: width / 5,
                          height: height / 20,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Icon(
                            Icons.mic,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          "Theme",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: height / 50),
                        )
                      ],
                    ),
                    Column(
                      children: [
                        Container(
                          width: width / 5,
                          height: height / 20,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Icon(
                            Icons.mic,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          "Password",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: height / 50),
                        )
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: height / 40,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        Container(
                          width: width / 5,
                          height: height / 20,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Icon(
                            Icons.mic,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          "Room data",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: height / 50),
                        )
                      ],
                    ),
                    Column(
                      children: [
                        Container(
                          width: width / 5,
                          height: height / 20,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Icon(
                            Icons.mic,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          "Fan Badge",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: height / 50),
                        )
                      ],
                    ),
                    Column(
                      children: [
                        Container(
                          width: width / 5,
                          height: height / 20,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Icon(
                            Icons.mic,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          "RoomAdmin",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: height / 50),
                        )
                      ],
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

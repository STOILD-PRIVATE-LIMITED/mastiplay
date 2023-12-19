import 'package:flutter/material.dart';
import 'package:spinner_try/shivanshu/utils.dart';

class AudioGo extends StatefulWidget {
  final String roomID;
  const AudioGo({super.key, required this.roomID});

  @override
  State<AudioGo> createState() => _AudioGoState();
}

class _AudioGoState extends State<AudioGo> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Container(
      height: height / 1.8,
      padding:
          EdgeInsets.symmetric(horizontal: width / 30, vertical: height / 40),
      decoration: const BoxDecoration(
        color: Color(0xFF21242D),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          "Room Play",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: height / 40,
            color: Colors.white,
          ),
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
                    gradient: const LinearGradient(
                      begin: Alignment(-1.00, -0.00),
                      end: Alignment(1, 0),
                      colors: [
                        Color(0x5EE05DD3),
                        Color(0xFFE05DD3),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Image.asset('assets/PK.png'),
                ),
                Text(
                  "Room PK",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: height / 70,
                    color: Colors.white,
                  ),
                )
              ],
            ),
            Column(
              children: [
                Container(
                  width: width / 5,
                  height: height / 20,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      begin: Alignment(-1.00, -0.00),
                      end: Alignment(1, 0),
                      colors: [
                        Color(0x5EE05DD3),
                        Color(0xFFE05DD3),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Icon(
                    Icons.mic,
                    color: Colors.black,
                  ),
                ),
                Text(
                  "Battle",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: height / 70,
                    color: Colors.white,
                  ),
                )
              ],
            ),
            Column(
              children: [
                Container(
                  width: width / 5,
                  height: height / 20,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      begin: Alignment(-1.00, -0.00),
                      end: Alignment(1, 0),
                      colors: [
                        Color(0x5EE05DD3),
                        Color(0xFFE05DD3),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Icon(
                    Icons.mic,
                    color: Colors.black,
                  ),
                ),
                Text(
                  "Calculator",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: height / 70,
                    color: Colors.white,
                  ),
                )
              ],
            ),
            Column(
              children: [
                Container(
                  width: width / 5,
                  height: height / 20,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      begin: Alignment(-1.00, -0.00),
                      end: Alignment(1, 0),
                      colors: [
                        Color(0x5EE05DD3),
                        Color(0xFFE05DD3),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Icon(
                    Icons.mic,
                    color: Colors.black,
                  ),
                ),
                Text(
                  "Game PK",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: height / 70,
                    color: Colors.white,
                  ),
                )
              ],
            ),
          ],
        ),
        SizedBox(
          height: height / 40,
        ),
        Text(
          "Tools",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: height / 40,
            color: Colors.white,
          ),
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
                      gradient: const LinearGradient(
                        begin: Alignment(-1.00, -0.00),
                        end: Alignment(1, 0),
                        colors: [
                          Color(0x5EE05DD3),
                          Color(0xFFE05DD3),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Image.asset(
                      'assets/Volume-Down.png',
                      height: 20.sp,
                    )),
                Text(
                  "Voice On",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: height / 70,
                    color: Colors.white,
                  ),
                )
              ],
            ),
            Column(
              children: [
                Container(
                  width: width / 5,
                  height: height / 20,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      begin: Alignment(-1.00, -0.00),
                      end: Alignment(1, 0),
                      colors: [
                        Color(0x5EE05DD3),
                        Color(0xFFE05DD3),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Icon(
                    Icons.mic,
                    color: Colors.black,
                  ),
                ),
                Text(
                  "Get Effects",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: height / 70,
                    color: Colors.white,
                  ),
                )
              ],
            ),
            Column(
              children: [
                Container(
                  width: width / 5,
                  height: height / 20,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      begin: Alignment(-1.00, -0.00),
                      end: Alignment(1, 0),
                      colors: [
                        Color(0x5EE05DD3),
                        Color(0xFFE05DD3),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Icon(
                    Icons.mic,
                    color: Colors.black,
                  ),
                ),
                Text(
                  "Clean",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: height / 70,
                    color: Colors.white,
                  ),
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
                    gradient: const LinearGradient(
                      begin: Alignment(-1.00, -0.00),
                      end: Alignment(1, 0),
                      colors: [
                        Color(0x5EE05DD3),
                        Color(0xFFE05DD3),
                      ],
                    ),
                  ),
                  child: const Icon(
                    Icons.mic,
                    color: Colors.black,
                  ),
                ),
                Text(
                  "Public Msg",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: height / 70,
                    color: Colors.white,
                  ),
                )
              ],
            ),
          ],
        ),
        SizedBox(
          height: height / 60,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                Container(
                  width: width / 5,
                  height: height / 20,
                  padding: EdgeInsets.all(5.sp),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: const LinearGradient(
                      begin: Alignment(-1.00, -0.00),
                      end: Alignment(1, 0),
                      colors: [
                        Color(0x5EE05DD3),
                        Color(0xFFE05DD3),
                      ],
                    ),
                  ),
                  child: Image.asset(
                    'assets/Discovery.png',
                    height: 10.sp,
                  ),
                ),
                Text(
                  "Music",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: height / 70,
                    color: Colors.white,
                  ),
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
                    gradient: const LinearGradient(
                      begin: Alignment(-1.00, -0.00),
                      end: Alignment(1, 0),
                      colors: [
                        Color(0x5EE05DD3),
                        Color(0xFFE05DD3),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Icon(
                    Icons.mic,
                    color: Colors.black,
                  ),
                ),
                Text(
                  "Photo",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: height / 70,
                    color: Colors.white,
                  ),
                )
              ],
            ),
            Column(
              children: [
                Container(
                    width: width / 5,
                    height: height / 20,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        begin: Alignment(-1.00, -0.00),
                        end: Alignment(1, 0),
                        colors: [
                          Color(0x5EE05DD3),
                          Color(0xFFE05DD3),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: EdgeInsets.all(5.sp),
                    child: Image.asset('assets/Group 18117.png')),
                Text(
                  "Message",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: height / 70,
                    color: Colors.white,
                  ),
                )
              ],
            ),
            InkWell(
              onTap: () {
                shareRoomLink(widget.roomID);
              },
              child: Column(
                children: [
                  Container(
                      width: width / 5,
                      height: height / 20,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          begin: Alignment(-1.00, -0.00),
                          end: Alignment(1, 0),
                          colors: [
                            Color(0x5EE05DD3),
                            Color(0xFFE05DD3),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: EdgeInsets.all(7.sp),
                      alignment: Alignment.center,
                      child: Image.asset('assets/Send.png')),
                  Text(
                    "Share",
                    style: TextStyle(
                      // fontWeight: FontWeight.bold,
                      fontSize: height / 70,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ]),
    );
  }
}

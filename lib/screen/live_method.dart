import 'package:flutter/material.dart';

class LiveMethod extends StatefulWidget {
  const LiveMethod({super.key});

  @override
  State<LiveMethod> createState() => _LiveMethodState();
}

class _LiveMethodState extends State<LiveMethod> {
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
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      height: height / 15,
                      child: Row(
                        children: [
                          Image.asset(
                            "assets/Group 18115.png",
                            height: height / 10,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Live",
                            style: TextStyle(
                                fontSize: height / 30,
                                letterSpacing: 3,
                                fontWeight: FontWeight.w500,
                                color: Colors.black),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: height / 15,
                      child: Row(
                        children: [
                          Image.asset(
                            "assets/Frame.png",
                            height: height / 10,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Chat",
                            style: TextStyle(
                                fontSize: height / 30,
                                letterSpacing: 3,
                                fontWeight: FontWeight.w500,
                                color: Colors.black),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: height / 20,
                ),
                Container(
                  width: width / 2,
                  height: height / 10,
                  decoration: BoxDecoration(
                    color: const Color(0xFFE05DD3),
                    borderRadius: BorderRadius.circular(100),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    "CONVERT",
                    style: TextStyle(
                        fontSize: height / 30,
                        letterSpacing: 3,
                        fontWeight: FontWeight.w500,
                        color: Colors.white),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

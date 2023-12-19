import 'package:flutter/material.dart';

class GiftMe extends StatefulWidget {
  const GiftMe({super.key});

  @override
  State<GiftMe> createState() => _GiftMeState();
}

class _GiftMeState extends State<GiftMe> {
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
            height: height / 2,
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
                Text(
                  "Room Play",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, fontSize: height / 40),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

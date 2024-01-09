import 'package:flutter/material.dart';

class CommonElevatedButton extends StatelessWidget {
  final String image;
  final String diamond;
  final String text;
  final Function onPressed;
  const CommonElevatedButton(
      {super.key,
      required this.image,
      required this.diamond,
      required this.text,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed(),
      style: ElevatedButton.styleFrom(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        backgroundColor: Colors.transparent,
        minimumSize: const Size(400, 400),
        maximumSize: const Size(400, 400),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(image, height: 70),
          Text(
            text,
            style: const TextStyle(color: Colors.white, fontSize: 15),
          ),
          Row(
            children: [
              Image.asset("assets/diamond.png", height: 10),
              Text(diamond),
            ],
          )
        ],
      ),
    );
  }
}

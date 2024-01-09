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
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(image, height: 90),
          Text(
            text,
            style: const TextStyle(color: Colors.white, fontSize: 15),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/diamond.png", height: 15),
              const SizedBox(
                width: 5,
              ),
              Text(
                diamond,
                style: const TextStyle(
                  color: Colors.grey,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

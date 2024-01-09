import 'package:flutter/material.dart';
import 'package:spinner_try/shivanshu/utils.dart';

class CommonElevatedButton extends StatefulWidget {
  final String image;
  final String diamond;
  final String text;
  final Function() onPressed;
  const CommonElevatedButton(
      {super.key,
      required this.image,
      required this.diamond,
      required this.text,
      required this.onPressed});

  @override
  State<CommonElevatedButton> createState() => _CommonElevatedButtonState();
}

class _CommonElevatedButtonState extends State<CommonElevatedButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: widget.onPressed,
      style: ElevatedButton.styleFrom(
        elevation: 0,
        backgroundColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image.asset(
            widget.image,
            height: 100.sp,
            width: 100.sp,
          ),
          Text(
            widget.text,
            style: TextStyle(
              color: Colors.white,
              fontSize: 15.sp,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/diamond.png",
                height: 10.sp,
              ),
              Text(
                widget.diamond,
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

import 'package:flutter/material.dart';
import 'package:spinner_try/shivanshu/screens/audio_page.dart';
import 'package:spinner_try/shivanshu/utils.dart';

class BottomModel extends StatefulWidget {
  final String imageUrl;
  final String name;
  final String frame;
  final String roomId;
  const BottomModel(
      {super.key,
      required this.imageUrl,
      required this.name,
      required this.frame,
      required this.roomId});

  @override
  State<BottomModel> createState() => _BottomModelState();
}

class _BottomModelState extends State<BottomModel> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.sp,
      // color: Colors.black26,
      color: const Color(0xFF011a51),
      child: Stack(
        clipBehavior: Clip.none,
        fit: StackFit.loose,
        alignment: Alignment.center,
        children: [
          Positioned(
            top: -30,
            child: AudioUserTile(
                imgUrl: widget.imageUrl,
                frame: widget.frame,
                name: widget.name),
          ),
          Padding(
            padding: EdgeInsets.only(top: 40.0.sp, left: 10.0.sp),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(2.sp),
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(10.sp),
                      ),
                      child: Text(
                        "ID:  ",
                        style: TextStyle(
                          fontSize: 10.sp,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Text(
                      widget.roomId,
                      style: TextStyle(
                        fontSize: 10.sp,
                        color: Colors.white,
                      ),
                    ),
                    Icon(
                      Icons.copy,
                      color: Colors.white,
                      size: 10.sp,
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

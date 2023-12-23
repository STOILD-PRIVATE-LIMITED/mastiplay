import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
      height: 150.sp,
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
            padding: EdgeInsets.only(top: 50.0.sp, left: 20.0.sp),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 5.sp,
                        vertical: 2.sp,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(10.sp),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        "ID",
                        style: TextStyle(
                          fontSize: 13.sp,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 8.0.sp),
                      child: Text(
                        widget.roomId,
                        style: TextStyle(
                          fontSize: 13.sp,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 4.0),
                      child: GestureDetector(
                        onTap: () {
                          Clipboard.setData(ClipboardData(text: widget.roomId));
                          showMsg(context, "Copied to clipboard");
                        },
                        child: Icon(
                          Icons.copy,
                          color: Colors.white,
                          size: 13.sp,
                        ),
                      ),
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

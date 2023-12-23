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
    return Stack(
      clipBehavior: Clip.none,
      fit: StackFit.loose,
      alignment: Alignment.center,
      children: [
        Positioned(
            top: -30,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  child: Stack(
                    children: [
                      Positioned(
                        left: 5,
                        top: 10,
                        child: Container(
                          clipBehavior: Clip.hardEdge,
                          decoration:
                              const BoxDecoration(shape: BoxShape.circle),
                          child: Image.network(
                            widget.imageUrl,
                            fit: BoxFit.cover,
                            width: 65,
                            height: 65,
                          ),
                        ),
                      ),
                      Image.asset(
                        'assets/Frame ${widget.frame}.png',
                        fit: BoxFit.cover,
                        width: 80,
                        height: 80,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  widget.name.isEmpty ? "Name is empty" : widget.name,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 15.sp),
                ),
              ],
            )),
        Padding(
          padding: EdgeInsets.only(
            top: 90.0.sp,
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
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
    );
  }
}

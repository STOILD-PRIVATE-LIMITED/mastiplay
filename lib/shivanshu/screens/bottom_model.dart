import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:spinner_try/shivanshu/utils.dart';
import 'package:spinner_try/shivanshu/utils/profile_image.dart';
import 'package:spinner_try/user_model.dart';

class BottomModel extends StatefulWidget {
  final UserModel user;
  final String roomId;
  const BottomModel({super.key, required this.roomId, required this.user});

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
                SizedBox(
                  height: 90,
                  width: 90,
                  child: ProfileImage(user: widget.user),
                ),
                const SizedBox(height: 5),
                Text(
                  widget.user.name.isEmpty ? "Name is empty" : widget.user.name,
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

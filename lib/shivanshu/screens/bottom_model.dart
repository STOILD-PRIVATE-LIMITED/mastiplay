import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:spinner_try/shivanshu/screens/moments.dart';
import 'package:spinner_try/shivanshu/utils.dart';
import 'package:spinner_try/shivanshu/utils/loading_elevated_button.dart';
import 'package:spinner_try/user_model.dart';

import '../../chat/models/chat.dart';

class BottomModel extends StatefulWidget {
  final UserModel user;
  const BottomModel({super.key, required this.user});

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
            top: -60.sp,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                    height: 140.sp,
                    width: 140.sp,
                    // child: ProfileImage(user: widget.user),
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        return Stack(
                          fit: StackFit.passthrough,
                          alignment: Alignment.center,
                          children: [
                            Positioned(
                              top: 220 / 1080 * constraints.maxHeight,
                              bottom: 220 / 1080 * constraints.maxHeight,
                              child: Container(
                                height: 500 / 1080 * constraints.maxHeight,
                                decoration:
                                    const BoxDecoration(shape: BoxShape.circle),
                                clipBehavior: Clip.hardEdge,
                                child: widget.user.photo.isNotEmpty
                                    ? Image.network(
                                        widget.user.photo,
                                        fit: BoxFit.cover,
                                      )
                                    : Image.asset(
                                        'assets/${widget.user.gender == 0 ? 'male' : 'female'}.jpg',
                                        fit: BoxFit.cover,
                                      ),
                              ),
                            ),
                            Positioned.fill(
                              child: Image.asset(
                                'assets/Frame ${widget.user.frame}.png',
                                fit: BoxFit.cover,
                                height: constraints.maxHeight,
                              ),
                            ),
                          ],
                        );
                      },
                    )),
                SizedBox(height: 5.sp),
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
            top: 120.0.sp,
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
                      widget.user.id ?? "No id",
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
                        Clipboard.setData(
                            ClipboardData(text: widget.user.id ?? "No id"));
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
              SizedBox(height: 10.sp),
              Wrap(
                alignment: WrapAlignment.spaceAround,
                spacing: 10,
                children: [
                  LoadingElevatedButton(
                    icon: const Icon(Icons.chat_rounded),
                    onPressed: () async {
                      print(widget.user.id!);
                      await showChatWithUserId(widget.user.id!, context);
                    },
                    label: const Text("Chat"),
                  ),
                  LoadingElevatedButton(
                    icon: const Icon(Icons.collections_rounded),
                    onPressed: () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Moments(),
                        ),
                      );
                    },
                    label: const Text("Moments"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

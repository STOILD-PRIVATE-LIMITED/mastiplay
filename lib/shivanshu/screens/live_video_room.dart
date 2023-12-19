import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:spinner_try/shivanshu/models/globals.dart';
import 'package:spinner_try/shivanshu/utils.dart';

class LiveVideoRoomPage extends StatefulWidget {
  final bool showVideoButton;
  final TextEditingController controller;
  final void Function(File? newImgUrl) onChanged;
  const LiveVideoRoomPage({
    super.key,
    this.showVideoButton = true,
    required this.controller,
    required this.onChanged,
  });

  @override
  State<LiveVideoRoomPage> createState() => _LiveVideoRoomPageState();
}

class _LiveVideoRoomPageState extends State<LiveVideoRoomPage> {
  XFile? image;
  TextEditingController roomIDController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(),
        actions: [
          if (widget.showVideoButton)
            IconButton(
              onPressed: () {
                showMsg(context, 'Open Camera');
              },
              icon: Stack(
                alignment: Alignment.center,
                children: [
                  Image.asset('assets/refresh.png'),
                  Image.asset('assets/camera.png'),
                ],
              ),
            ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 40,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 100.sp,
              width: 100.sp,
              decoration: const BoxDecoration(
                shape: BoxShape.rectangle,
                border: Border.fromBorderSide(
                  BorderSide(width: 1),
                ),
              ),
              clipBehavior: Clip.hardEdge,
              margin: const EdgeInsets.all(8.0),
              child: image == null
                  ? (currentUser.photo.isEmpty
                      ? Image.asset(
                          'assets/dummy_person.png',
                          width: 100,
                          fit: BoxFit.fitWidth,
                        )
                      : Image.network(
                          currentUser.photo,
                          fit: BoxFit.cover,
                        ))
                  : Image.file(
                      File(image!.path),
                      width: 100,
                      fit: BoxFit.fitWidth,
                    ),
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  width: 160,
                  child: TextField(
                    controller: widget.controller,
                    decoration: InputDecoration(
                      hintText: 'Enter Room ID',
                      hintStyle: const TextStyle(color: Colors.black),
                      isDense: true,
                      filled: true,
                      fillColor: Colors.black12,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(3),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    style: const TextStyle(
                      decorationColor: Colors.black12,
                      color: Colors.black,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: 130,
                  child: TextField(
                    readOnly: true,
                    onTap: () async {
                      final picker = ImagePicker();
                      image =
                          await picker.pickImage(source: ImageSource.gallery);
                      widget
                          .onChanged(image == null ? null : File(image!.path));
                      setState(() {});
                    },
                    decoration: InputDecoration(
                      hintText: 'Change Cover',
                      hintStyle: const TextStyle(color: Colors.black),
                      isDense: true,
                      filled: true,
                      fillColor: Colors.black12,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    style: const TextStyle(
                      decorationColor: Colors.black12,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

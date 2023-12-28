import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:spinner_try/shivanshu/models/globals.dart';
import 'package:spinner_try/shivanshu/models/settings.dart';
import 'package:spinner_try/shivanshu/utils.dart';

class LiveVideoRoomPage extends StatefulWidget {
  final bool showVideoButton;
  final TextEditingController nameController;
  final Future<File?> Function(File? newImgUrl) onChanged;
  const LiveVideoRoomPage({
    super.key,
    this.showVideoButton = true,
    required this.onChanged,
    required this.nameController,
  });

  @override
  State<LiveVideoRoomPage> createState() => _LiveVideoRoomPageState();
}

class _LiveVideoRoomPageState extends State<LiveVideoRoomPage> {
  XFile? image;
  TextEditingController roomIDController = TextEditingController();
  File? img;
  final user = FirebaseAuth.instance.currentUser;



  @override
  Widget build(BuildContext context) {
    Widget imageWidget = image == null
        ? PrefStorage.myRoomUrl != null
            ? Image.network(
                PrefStorage.myRoomUrl!,
                fit: BoxFit.cover,
              )
            : (currentUser.photo.isEmpty
                ? Image.asset(
                    'assets/dummy_person.png',
                    width: 100,
                    fit: BoxFit.cover,
                  )
                : Image.network(
                    currentUser.photo,
                    fit: BoxFit.cover,
                  ))
        : Image.file(
            File(image!.path),
            width: 100,
            fit: BoxFit.cover,
          );
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
            GestureDetector(
              onTap: () async {
                final String? source = await askUser(
                    context, 'Where to take your photo from?',
                    custom: {
                      'gallery': const Icon(Icons.photo_rounded),
                      'camera': const Icon(Icons.photo_camera_rounded),
                    });
                if (source == null) return;
                ImagePicker()
                    .pickImage(
                  source: source == 'camera'
                      ? ImageSource.camera
                      : ImageSource.gallery,
                  preferredCameraDevice: CameraDevice.front,
                )
                    .then((value) async {
                  if (value == null) return;
                  final File? croppedImg =
                      await widget.onChanged(File(value.path));
                  image = croppedImg == null ? null : XFile(croppedImg.path);
                  setState(() {
                    img = File(value.path);
                  });
                });
              },
              child: Container(
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
                  child: Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      Positioned.fill(child: imageWidget),
                      const CircleAvatar(
                        backgroundColor: Colors.black54,
                        radius: 18,
                        child: Icon(
                          Icons.edit_rounded,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  )),
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  width: 160,
                  child: TextField(
                    // enabled: widget.nameController.text.isEmpty,
                    controller: widget.nameController,
                    decoration: InputDecoration(
                      hintText: 'Enter Room Name',
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
                // const SizedBox(height: 12),
                // SizedBox(
                //   width: 130,
                //   child: TextField(
                //     readOnly: true,
                //     onTap: () async {
                //       final picker = ImagePicker();
                //       image =
                //           await picker.pickImage(source: ImageSource.gallery);
                //       widget
                //           .onChanged(image == null ? null : File(image!.path));
                //       setState(() {});
                //     },
                //     decoration: InputDecoration(
                //       hintText: 'Change Cover',
                //       hintStyle: const TextStyle(color: Colors.black),
                //       isDense: true,
                //       filled: true,
                //       fillColor: Colors.black12,
                //       contentPadding: const EdgeInsets.symmetric(
                //         horizontal: 10,
                //         vertical: 5,
                //       ),
                //       border: OutlineInputBorder(
                //         borderRadius: BorderRadius.circular(20),
                //         borderSide: BorderSide.none,
                //       ),
                //     ),
                //     style: const TextStyle(
                //       decorationColor: Colors.black12,
                //       color: Colors.black,
                //     ),
                //   ),
                // ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

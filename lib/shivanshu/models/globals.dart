import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spinner_try/shivanshu/utils.dart';
import 'package:spinner_try/user_model.dart';
import 'package:spinner_try/wave/wave_painter.dart';

import 'package:gif/gif.dart';

/// Instead of creating multiple instances of the same object
/// I created then altogether here
final auth = FirebaseAuth.instance;
final firestore = FirebaseFirestore.instance;
final storage = FirebaseStorage.instance;
UserModel currentUser = UserModel(name: "", photo: "", email: "", country: "");

late final SharedPreferences prefs;

// KEEP ALL SERVER ADRESSES WITHOUT A TRAILING SLASH

// Chat Server -----------------------------------------------------
const String chatServer = "http://3.7.66.245:3001";
// const String chatServer = "https://v9nm4hsv-3007.asse.devtunnels.ms";
// const String chatServer = "https://rkncpgkx-3000.inc1.devtunnels.ms";

// Moments Server --------------------------------------------------
// const String momentsServer = "https://92v8xmgw-3007.inc1.devtunnels.ms";
// const String momentsServer = "https://v9nm4hsv-3007.asse.devtunnels.ms";
const String momentsServer = "http://3.7.66.245:3007";
// const String momentsServer = "https://92v8xmgw-3007.inc1.devtunnels.ms";
// const String momentsServer = "https://rkncpgkx-3007.inc1.devtunnels.ms";

// WebRTC Server --------------------------------------------------
const String websocketUrl = "http://3.7.66.245:8080";
// const String websocketUrl = "https://v9nm4hsv-8080.asse.devtunnels.ms";
// const String websocketUrl = "https://rkncpgkx-8080.inc1.devtunnels.ms";

OverlayEntry? entry;
Offset offset = Offset(220.sp, 600.sp);
void showOverlay(context, Widget widget) {
  entry = OverlayEntry(builder: (context) {
    return Positioned(
      left: offset.dx,
      top: offset.dy,
      child: GestureDetector(
        onDoubleTap: () {
          entry!.remove();
        },
        onTap: () {
          // entry!.remove();
          Navigator.of(context).pop();
        },
        child: Card(
          color: Colors.transparent,
          elevation: 0,
          child: Container(
            height: 100.sp,
            width: 100.sp,
            decoration: BoxDecoration(
              color: Colors.transparent,
              border: Border.all(
                color: Colors.transparent,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(50),
            ),
            child: EmptyEffect(
              borderColor: Colors.pink,
              outerMostCircleEndRadius: 100,
              outerMostCircleStartRadius: 20,
              numberOfCircles: 3,
              child: widget,
            ),
          ),
        ),
      ),
    );
  });
  final overlay = Overlay.of(context);
  overlay.insert(entry!);
}

OverlayEntry? entry1;

void showImages(
    String imageUrl, BuildContext context, GifController controller) {
  entry1 = OverlayEntry(builder: (context) {
    return GestureDetector(
      onDoubleTap: () {
        entry1!.remove();
      },
      onTap: () {
        entry1!.remove();
      },
      child: Card(
        color: Colors.transparent,
        elevation: 0,
        child: Container(
          height: 100.sp,
          width: 100.sp,
          decoration: BoxDecoration(
            color: Colors.transparent,
            border: Border.all(
              color: Colors.transparent,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(50),
          ),
          child: EmptyEffect(
            borderColor: Colors.pink,
            outerMostCircleEndRadius: 100,
            outerMostCircleStartRadius: 20,
            numberOfCircles: 3,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Image.asset(
                imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            // child: Gif(
            //   repeat: ImageRepeat.repeat,
            //   autostart: Autostart.loop,
            //   fps: 30,
            //   controller: controller,
            //   image: const AssetImage('assets/gifsticker/1.gif'),
            // ),
          ),
        ),
      ),
    );
  });

  final overlay1 = Overlay.of(context);
  overlay1.insert(entry1!);

  Future.delayed(const Duration(seconds: 2), () {
    entry1!.remove();
  });
}

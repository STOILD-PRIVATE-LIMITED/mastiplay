import 'dart:math';

import 'package:flutter/material.dart';
import 'package:spinner_try/shivanshu/models/globals.dart';
import 'package:spinner_try/shivanshu/models/room.dart';
import 'package:spinner_try/shivanshu/screens/audio_page.dart';
import 'package:spinner_try/shivanshu/screens/bottom_model.dart';
import 'package:spinner_try/user_model.dart';
import 'package:spinner_try/webRTC/web_rtc.dart';

class AudioRoom extends StatefulWidget {
  final Room room;
  final int maxParticipants;
  const AudioRoom({
    super.key,
    required this.room,
    this.maxParticipants = 8,
  });

  @override
  State<AudioRoom> createState() => _AudioRoomState();
}

final WebRtcController controller = WebRtcController(
  audio: true,
  video: false,
);

class _AudioRoomState extends State<AudioRoom> with TickerProviderStateMixin {
  // final WebRtcController controller = WebRtcController(
  //   audio: true,
  //   video: false,
  // );
  @override
  Widget build(BuildContext context) {
    return WebRTCWidget(
      onExit: () async {
        if (widget.room.admin == auth.currentUser!.email) {
          // if (await askUser(context, 'Do you want to delete the room as well?',
          //         no: true,
          //         custom: {
          //           "delete": const Icon(
          //             Icons.delete_forever_rounded,
          //             color: Colors.red,
          //           )
          //         }) ==
          //     'delete') {
          //   await widget.room.delete();
          // }
        }
      },
      controller: controller,
      userData: currentUser.toJson(),
      roomId: widget.room.id,
      builder: (context, roomId, usersData, videoViews, myUserData, myVideoView,
          controls) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: GridView.count(
            shrinkWrap: true,
            crossAxisCount: widget.maxParticipants ~/ 2,
            childAspectRatio: 1 / 1.3,
            children: [
              Container(
                child: AudioUserTile(
                  user: UserModel.fromJson(myUserData),
                  onTap: () {
                    showModalBottomSheet(
                      backgroundColor: const Color(0xFF011a51),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                      ),
                      context: context,
                      builder: ((context) {
                        return BottomModel(
                          user: UserModel.fromJson(myUserData),
                          roomId: myUserData["id"],
                        );
                      }),
                    );
                  },
                ),
              ),
              for (int i = 0; i < usersData.length; ++i)
                AudioUserTile(
                  user: UserModel.fromJson(usersData[i]),
                  onTap: () {
                    showModalBottomSheet(
                      backgroundColor: const Color(0xFF011a51),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                      ),
                      context: context,
                      builder: ((context) {
                        return BottomModel(
                          user: UserModel.fromJson(usersData[i]),
                          roomId: usersData[i]["id"],
                        );
                      }),
                    );
                  },
                ),
              for (int i = usersData.length + 1;
                  i < widget.maxParticipants;
                  ++i)
                AudioUserTile(
                  user: UserModel(),
                  index: i + 1,
                ),
            ],
          ),
        );
      },
      // meBuilder: (context,
      //     {required roomId, required userData, required videoView}) {
      //   return AudioUserTile(
      //     name: userData == null
      //         ? "You"
      //         : userData['name'] ?? userData['email'] ?? "Anonymous",
      //     onTap: () {
      //       controller.audio = !controller.audio;
      //       showMsg(context,
      //           controller.audio ? "You're unmuted" : 'You\'re now muted');
      //     },
      //   );
      // },
      // userTileBuilder: (context,
      //     {required roomId, required userData, required videoView}) {
      //   return AudioUserTile(
      //       name: userData == null
      //           ? "Error"
      //           : userData['name'] ?? userData['email'] ?? "Anonymous");
      // },
    );
  }
}

class WavePainter extends CustomPainter {
  final double animationValue;
  final double radius;

  WavePainter(this.animationValue, this.radius);

  @override
  void paint(Canvas canvas, Size size) {
    final Paint wavePaint = Paint()
      ..color = Colors.yellow
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    Color fadedBlue;

    if (radius <= radius / 2) {
      // Blue color turns to black when radius is half or less
      fadedBlue = Colors.black;
    } else {
      // Fade out the blue color based on animation value
      fadedBlue = Colors.blue.withOpacity(1.0 - animationValue);
    }

    final Paint circlePaint = Paint()
      ..color = fadedBlue
      ..style = PaintingStyle.fill;

    double waveHeight = 10.0;

    final Path path = Path();

    for (double i = 0; i <= 360; i += 10) {
      final double angle = i * (pi / 180.0);
      final double x = radius +
          (radius + waveHeight * sin(animationValue * 2 * pi)) * cos(angle);
      final double y = radius +
          (radius + waveHeight * sin(animationValue * 2 * pi)) * sin(angle);

      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }

    path.close();

    canvas.drawPath(path, wavePaint);
    canvas.drawCircle(Offset(radius, radius), radius, circlePaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:spinner_try/shivanshu/models/globals.dart';
import 'package:spinner_try/shivanshu/models/room.dart';
import 'package:spinner_try/shivanshu/screens/audio_page.dart';
import 'package:spinner_try/shivanshu/screens/bottom_model.dart';
import 'package:spinner_try/shivanshu/utils.dart';
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

class _AudioRoomState extends State<AudioRoom> {
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
        log("usersData: $usersData");
        return GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: widget.maxParticipants ~/ 2,
          childAspectRatio: 1,
          children: [
            AudioUserTile(
              imgUrl: myUserData['photo'],
              frame: myUserData['frame'],
              name: myUserData == null
                  ? "You"
                  : myUserData['name'] ?? myUserData['email'] ?? "Anonymous",
              onTap: () {
                setState(() {
                  controller.audio = !controller.audio;
                });
                showMsg(context,
                    controller.audio ? "You're unmuted" : 'You\'re now muted');
                showModalBottomSheet(
                  context: context,
                  builder: ((context) {
                    return BottomModel(
                      frame: myUserData['frame'],
                      imageUrl: myUserData['photo'],
                      name: myUserData == null
                          ? "You"
                          : myUserData['name'] ??
                              myUserData['email'] ??
                              "Anonymous",
                      roomId: roomId,
                    );
                  }),
                );
              },
            ),
            for (int i = 0; i < usersData.length; ++i)
              AudioUserTile(
                frame: usersData[i]['frame'],
                imgUrl: usersData[i]['photo'],
                name: usersData[i] == null
                    ? "You"
                    : usersData[i]['name'] ??
                        usersData[i]['email'] ??
                        "Anonymous",
                onTap: () {
                  setState(() {
                    controller.audio = !controller.audio;
                  });
                  showMsg(
                      context,
                      controller.audio
                          ? "You're unmuted"
                          : 'You\'re now muted');
                  showModalBottomSheet(
                    context: context,
                    builder: ((context) {
                      return BottomModel(
                        frame: usersData[i]['frame'],
                        imageUrl: usersData[i]['photo'],
                        name: usersData[i] == null
                            ? "You"
                            : usersData[i]['name'] ??
                                usersData[i]['email'] ??
                                "Anonymous",
                        roomId: roomId,
                      );
                    }),
                  );
                },
              ),
            for (int i = usersData.length + 1; i < widget.maxParticipants; ++i)
              const AudioUserTile(name: 'Empty'),
          ],
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

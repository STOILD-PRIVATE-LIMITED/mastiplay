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
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: widget.maxParticipants ~/ 2,
            childAspectRatio: 1 / 1.3,
            children: [
              SizedBox(
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
                          frame: myUserData['frame'],
                          imageUrl: myUserData['photo'],
                          name: myUserData == null
                              ? "You"
                              : myUserData['name'] ??
                                  myUserData['email'] ??
                                  "Anonymous",
                          roomId: myUserData["id"], user: null,
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
                AudioUserTile(user: UserModel()),
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

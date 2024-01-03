import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:spinner_try/shivanshu/models/room.dart';
import 'package:spinner_try/shivanshu/models/webRTC/webrtc.dart';
import 'package:spinner_try/shivanshu/screens/audio_page.dart';
import 'package:spinner_try/shivanshu/utils.dart';
import 'package:spinner_try/user_model.dart';

class NewAudioRoom extends StatefulWidget {
  final Room room;
  const NewAudioRoom({super.key, required this.room});

  @override
  State<NewAudioRoom> createState() => _NewAudioRoomState();
}

class _NewAudioRoomState extends State<NewAudioRoom> {
  late WebRTCRoom webRTCRoom;

  bool connected = false;

  @override
  void initState() {
    super.initState();
    webRTCRoom = WebRTCRoom(
      roomId: widget.room.id,
      onLocalStreamAdded: () => setState(() {
        log("onLocalStreamAdded called!");
      }),
      onRemoteRemoved: () => setState(() {
        log("onRemoteRemoved called!");
      }),
      onRemoteStreamAdded: () => setState(() {
        log("onRemoteStreamAdded called!");
      }),
      onConnect: () => setState(() {
        connected = true;
      }),
      onConnectError: () => showMsg(context, "Connect Error"),
      onDisconnect: () => showMsg(context, "Disconnected"),
      onExit: () => webRTCRoom.destroyRoom(),
      builder:
          (context, roomId, usersData, videoViews, myUserData, myVideoView) {
        final user = UserModel.fromJson(myUserData);
        final List<UserModel> remoteUsers =
            usersData.map<UserModel>((e) => UserModel.fromJson(e)).toList();
        return GridView.extent(
          maxCrossAxisExtent: 100,
          childAspectRatio: 1,
          children: [
            AudioUserTile(user: user),
            ...remoteUsers.map((e) => AudioUserTile(user: e)),
          ],
        );
      },
    );
    webRTCRoom.connectToServer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Audio Room'),
      ),
      body: connected
          ? webRTCRoom.build(context)
          : const Center(
              child: MyColumn(
                children: [
                  Text('Connecting to server'),
                  CircularProgressIndicatorRainbow(),
                ],
              ),
            ),
    );
  }
}

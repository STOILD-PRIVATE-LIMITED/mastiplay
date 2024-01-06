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
  bool connected = false;

  @override
  void initState() {
    super.initState();
    log("Initializing WebRTCRoom. This Should be called only once");
    WebRTCRoom.instance.roomId = widget.room.id;
    WebRTCRoom.instance.onLocalStreamAdded = () {
      log("SetState for function: onLocalStreamAdded");
      if (context.mounted) {
        setState(() {
          log("onLocalStreamAdded called!");
        });
      }
    };
    WebRTCRoom.instance.onRemoteRemoved = () {
      log("SetState for function: onRemoteRemoved");
      if (context.mounted) {
        setState(() {
          log("onRemoteRemoved called!");
        });
      }
    };
    WebRTCRoom.instance.onRemoteStreamAdded = () {
      log("SetState for function: onRemoteStreamAdded");
      if (context.mounted) {
        setState(() {
          log("onRemoteStreamAdded called!");
        });
      }
    };
    WebRTCRoom.instance.onConnect = () {
      log("SetState for function: onConnect");
      if (context.mounted) {
        setState(() {
          connected = true;
        });
      }
    };
    WebRTCRoom.instance.onConnectError = () {
      log("SetState for function: onConnectError");
      showMsg(context, "Connect Error");
    };
    WebRTCRoom.instance.onDisconnect = () {
      log("SetState for function: onDisconnect");
      if (context.mounted) {
        showMsg(context, "Disconnected");
      }
    };
    // WebRTCRoom.instance.onExit = () => showMsg(context, "You exited!");
    WebRTCRoom.instance.builder =
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
    };
    WebRTCRoom.instance.connectToServer(widget.room.id);
  }

  @override
  void dispose() {
    WebRTCRoom.instance.disconnect();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(widget.room.name),
      ),
      body: connected
          ? WebRTCRoom.instance.build(context)
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

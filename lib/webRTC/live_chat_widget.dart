import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:spinner_try/webRTC/web_rtc.dart';

void sendMessage(String msg, String roomId) {
  log("Sending msg: $msg with roomID: $roomId");
  assert(socket != null, "Socket is not yet initialized!");
  socket!.emit('message', {
    'channel': roomId,
    'message': msg,
  });
}

class LiveChatBuilder extends StatefulWidget {
  final Widget Function(
      BuildContext context, List<Map<String, dynamic>> messages) builder;
  const LiveChatBuilder({super.key, required this.builder});

  @override
  State<LiveChatBuilder> createState() => _LiveChatBuilderState();
}

class _LiveChatBuilderState extends State<LiveChatBuilder> {
  void broadCastMsg(data) {
    log("Received a broadcast msg: $data");
    if (context.mounted) {
      setState(() {
        messages.add(data);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    log("Setting up socket listeners for chat");
    socket!.on('broadcastMsg', broadCastMsg);
  }

  @override
  void dispose() {
    log("Removing socket listeners for chat");
    socket?.off('broadcastMsg', broadCastMsg);
    super.dispose();
  }

  List<Map<String, dynamic>> messages = [];

  @override
  Widget build(BuildContext context) {
    return widget.builder(context, messages);
  }
}

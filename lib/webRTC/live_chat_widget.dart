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
  final void Function(dynamic data)? onReceiveMsg;
  const LiveChatBuilder({super.key, required this.builder, this.onReceiveMsg});

  @override
  State<LiveChatBuilder> createState() => _LiveChatBuilderState();
}

class _LiveChatBuilderState extends State<LiveChatBuilder> {
  void broadCastMsg(data) {
    log("Received a broadcast msg: $data");
    widget.onReceiveMsg?.call(data);
    if (context.mounted && !(data['message'] as String).startsWith("\$#")) {
      setState(() {
        messages.add(data);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    log("Setting up socket listeners for chat");
    WidgetsBinding.instance.addPostFrameCallback((_) {
      socket!.on('broadcastMsg', broadCastMsg);
    });
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

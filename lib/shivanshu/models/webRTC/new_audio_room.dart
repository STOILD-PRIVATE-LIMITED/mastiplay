import 'package:flutter/material.dart';
import 'package:spinner_try/shivanshu/models/webRTC/webrtc.dart';

class NewAudioRoom extends StatefulWidget {
  const NewAudioRoom({super.key});

  @override
  State<NewAudioRoom> createState() => _NewAudioRoomState();
}

class _NewAudioRoomState extends State<NewAudioRoom> {
  late WebRTCRoom webRTCRoom;
  @override
  void initState() {
    super.initState();
    // webRTCRoom = WebRTCRoom(

    // );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Audio Room'),
      ),
      body: const Center(
        child: Text('New Audio Room'),
      ),
    );
  }
}

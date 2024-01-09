import 'dart:developer';

import 'package:dash_bubble/dash_bubble.dart';
import 'package:flutter/material.dart';
import 'package:spinner_try/main.dart';
import 'package:spinner_try/shivanshu/models/room.dart';
import 'package:spinner_try/shivanshu/models/webRTC/new_audio_room.dart';
import 'package:spinner_try/shivanshu/models/webRTC/webrtc.dart';
import 'package:spinner_try/shivanshu/utils.dart';
import 'package:spinner_try/webRTC/video_room.dart';

Future<void> showBubble(BuildContext context, Room room) async {
  if (!await DashBubble.instance.hasOverlayPermission()) {
    await DashBubble.instance.requestOverlayPermission();
  }
  if (!await DashBubble.instance.hasPostNotificationsPermission()) {
    await DashBubble.instance.requestPostNotificationsPermission();
  }
  if (context.mounted) {
    await _startBubble(
      context,
      bubbleOptions: BubbleOptions(
        bubbleIcon: 'github_bubble',
        startLocationX: 0,
        startLocationY: 100,
        bubbleSize: 60,
        opacity: 0.7,
        enableClose: true,
        closeBehavior: CloseBehavior.following,
        distanceToClose: 100,
        enableAnimateToEdge: true,
        enableBottomShadow: true,
        keepAliveWhenAppExit: false,
      ),
      notificationOptions: NotificationOptions(
        id: 1,
        title: 'You are still connected to your Masti Play Room',
        body: 'Click to go back to your meeting',
        channelId: 'dash_bubble_notification',
        channelName: 'Dash Bubble Notification',
      ),
      onTap: () {
        DashBubble.instance.stopBubble();
        if (newAuthPagecontext == null) {
          WebRTCRoom.instance.disconnect();
        } else if (room.roomType == RoomType.audio) {
          navigatorPush(
            newAuthPagecontext!,
            VideoRoom(
              room: room,
            ),
          );
        } else {
          navigatorPush(
            newAuthPagecontext!,
            NewAudioRoom(
              room: room,
              connected: true,
            ),
          );
        }
      },
      onTapDown: (x, y) => log(
        'Bubble Tapped Down on: ${_getRoundedCoordinatesAsString(x, y)}',
      ),
      onTapUp: (x, y) => log(
        'Bubble Tapped Up on: ${_getRoundedCoordinatesAsString(x, y)}',
      ),
      onMove: (x, y) => log(
        'Bubble Moved to: ${_getRoundedCoordinatesAsString(x, y)}',
      ),
    );
  }
}

String _getRoundedCoordinatesAsString(double x, double y) {
  return '${x.toStringAsFixed(2)}, ${y.toStringAsFixed(2)}';
}

Future<void> _startBubble(
  BuildContext context, {
  BubbleOptions? bubbleOptions,
  NotificationOptions? notificationOptions,
  VoidCallback? onTap,
  Function(double x, double y)? onTapDown,
  Function(double x, double y)? onTapUp,
  Function(double x, double y)? onMove,
}) async {
  final hasStarted = await DashBubble.instance.startBubble(
    bubbleOptions: bubbleOptions,
    notificationOptions: notificationOptions,
    onTap: onTap,
    onTapDown: onTapDown,
    onTapUp: onTapUp,
    onMove: onMove,
  );
  if (context.mounted) {
    showMsg(context, hasStarted ? 'Bubble Started' : 'Bubble has not Started');
  }
}

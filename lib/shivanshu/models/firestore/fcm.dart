import 'dart:convert';
import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;
import 'package:spinner_try/chat/models/chat.dart';
import 'package:spinner_try/shivanshu/models/globals.dart';
import 'package:spinner_try/shivanshu/models/settings.dart';

bool fcmInitialized = false;

Future<void> sendFCMToken(String fcmToken) async {
  http
      .post(
    Uri.parse("$chatServer/users/${currentUser.id}"),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode({"token": fcmToken}),
  )
      .then((response) {
    if (response.statusCode != 200) throw Exception(response.body);
    log("FCM token refresh success: ${response.body}");
    PrefStorage.fcmToken = fcmToken;
  });
}

Future<void> setupFCMTokenMangement() async {
  final notificationSettings =
      await FirebaseMessaging.instance.requestPermission(provisional: true);
  print(
      'User granted notification permission: ${notificationSettings.authorizationStatus}');
  if (notificationSettings.authorizationStatus == AuthorizationStatus.denied ||
      notificationSettings.authorizationStatus ==
          AuthorizationStatus.notDetermined) {
    log("Notification permission not granted!!! FCM will be disabled for this device.");
    return;
  }

  if (fcmInitialized) return;
  FirebaseMessaging.instance.onTokenRefresh.listen((fcmToken) async {
    log("FCM token refresh: $fcmToken");
    assert(currentUser.id != null);
    try {
      await sendFCMToken(fcmToken);
    } catch (e) {
      log("Cannot post the fcmToken for this device onto the server at $chatServer/users/${currentUser.id}");
    }
  }).onError((err) {
    log("FCM token refresh failed: $err", name: "FCM");
  });

  final fcmToken = await FirebaseMessaging.instance.getToken();
  log("This device fcm token: $fcmToken");
  if (fcmToken != null &&
      currentUser.id != null &&
      PrefStorage.fcmToken != fcmToken) {
    await sendFCMToken(fcmToken);
  }
  log("Setting up listeners for fcm");

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    log("FCM foreground message received: ${message.data}");
  });

  // onMessageOpenedApp is handled in NewAuth
  // FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
  //   log("FCM message opened: ${message.data}");
  // });

  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  fcmInitialized = true;
}

@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // await Firebase.initializeApp();
  log("Handling a background message: ${message.messageId}");
}

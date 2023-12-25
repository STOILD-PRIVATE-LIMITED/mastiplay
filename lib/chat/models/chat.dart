import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:spinner_try/chat/models/message.dart';
import 'package:spinner_try/chat/screens/chat_screen.dart';
import 'package:spinner_try/shivanshu/models/globals.dart';
import 'package:spinner_try/shivanshu/utils.dart';

String chatServer =
    // "http://3.7.66.245:3001";
    "http://192.168.9.64:3000";

// keep this without trailing slash

class ChatData {
  String id;
  String title;
  String description;
  List<String> participants;
  late DateTime createdAt;
  late DateTime updatedAt;
  List<String> admins;
  List<MessageData> messages = [];
  bool locked = false;

  ChatData({
    required this.admins,
    required this.participants,
    this.description = "",
    required this.title,
    required this.id,
    this.messages = const [],
    this.locked = false,
  });

  Map<String, dynamic> toJson() => {
        "title": title,
        "description": description,
        "participants": participants,
        "admins": admins,
        "locked": locked,
      };

  factory ChatData.fromJson(Map<String, dynamic> json) {
    return ChatData(
      id: json['_id'],
      title: json['title'],
      description: json['description'],
      participants: json['participants'].cast<String>(),
      admins: json['admins'].cast<String>(),
      locked: json['locked'],
    )
      ..createdAt = DateTime.parse(json['createdAt'])
      ..updatedAt = DateTime.parse(json['updatedAt']);
  }
}

Future<ChatData> fetchChatData(String id) async {
  assert(id.isNotEmpty, "Chat ID cannot be empty while fetching");
  final response = await http.get(Uri.parse("$chatServer/chats/$id"));
  if (response.statusCode == 200) {
    return ChatData.fromJson(json.decode(response.body));
  } else {
    throw Exception('Failed to load chat: ${response.body}');
  }
}

Future<ChatData> createChat(ChatData chat) async {
  final response = await http.post(
    Uri.parse("$chatServer/chats"),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(chat.toJson()),
  );
  if (response.statusCode == 200) {
    return ChatData.fromJson(json.decode(response.body));
  } else {
    throw Exception('Failed to create chat: ${response.body}');
  }
}

// Future<ChatData> updateChat(ChatData chat) async {
//   final response = await http.put(
//     Uri.parse("$chatServer/api/chats/${chat.id}"),
//     headers: <String, String>{
//       'Content-Type': 'application/json; charset=UTF-8',
//     },
//     body: jsonEncode(chat.toJson()),
//   );
//   if (response.statusCode == 200) {
//     return ChatData.fromJson(json.decode(response.body));
//   } else {
//     throw Exception('Failed to update chat: ${response.body}');
//   }
// }

showChat(
  BuildContext context, {
  required String chatId,
  required List<String> emails,
}) {
  return navigatorPush(
    context,
    ChatScreen(
      chat: ChatData(
        admins: [auth.currentUser!.email!],
        participants: emails,
        title: chatId,
        id: chatId,
      ),
    ),
  );
}

Future<List<ChatData>> fetchAllChats(String userID) async {
  final response = await http.get(Uri.parse("$chatServer/chats/all/$userID"));
  if (response.statusCode == 200) {
    return (json.decode(response.body) as List)
        .map((e) => ChatData.fromJson(e))
        .toList();
  } else {
    throw Exception('Failed to load chats: ${response.body}');
  }
}

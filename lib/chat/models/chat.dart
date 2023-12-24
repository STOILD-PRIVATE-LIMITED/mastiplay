import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:spinner_try/chat/models/message.dart';
import 'package:spinner_try/chat/screens/chat_screen.dart';
import 'package:spinner_try/shivanshu/models/globals.dart';
import 'package:spinner_try/shivanshu/utils.dart';

String chatServer =
    "http://3.7.66.245:3001"; // keep this without trailing slash

class ChatData {
  String id;
  String title;
  String? description;
  List<String> participants;
  List<String> admins;
  List<MessageData> messages = [];
  bool locked = false;

  ChatData({
    required this.admins,
    required this.participants,
    this.description,
    required this.title,
    required this.id,
    this.messages = const [],
    this.locked = false,
  });

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "receivers": participants,
        "owner": admins,
        // "messages": messages.map((e) => e.toJson()).toList(),
        "locked": locked,
      };

  factory ChatData.fromJson(Map<String, dynamic> json) {
    return ChatData(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      participants: json['receivers'].cast<String>(),
      admins: json['owner'].cast<String>(),
      messages: json['messages'].map((e) => MessageData.fromJson(e)).toList(),
      locked: json['locked'],
    );
  }
}

Future<ChatData> fetchChatData(String id) async {
  final response = await http.get(Uri.parse("$chatServer/api/chats/$id"));
  if (response.statusCode == 200) {
    return ChatData.fromJson(json.decode(response.body));
  } else {
    throw Exception('Failed to load chat: ${response.body}');
  }
}

Future<ChatData> createChat(ChatData chat) async {
  final response = await http.post(
    Uri.parse("$chatServer/chat"),
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

Future<List<ChatData>> fetchAllChats(
    String userID, String startID, int limit) async {
  final response = await http
      .get(Uri.parse("$chatServer/api/chats/$userID/$startID/$limit"));
  if (response.statusCode == 200) {
    return (json.decode(response.body) as List)
        .map((e) => ChatData.fromJson(e))
        .toList();
  } else {
    throw Exception('Failed to load chats: ${response.body}');
  }
}

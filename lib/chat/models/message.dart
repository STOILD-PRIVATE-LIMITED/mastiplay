import 'dart:convert';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;

import 'chat.dart';

class MessageData {
  /// The datetime object representing the
  late String id;

  /// The markdown text
  late String txt;

  /// Sender of the message
  late String from;

  /// CreatedAt
  late DateTime createdAt;

  /// Modified At
  DateTime? modifiedAt;

  /// Set of emails who have read this msg
  Set<String> readBy = {};

  /// These indicative messages are used to indicate
  /// that something has happened in the chat
  /// like the inclusion of someone in the chat
  /// can only be created but not deleted
  late bool indicative;

  /// This flag represents whether the msg is deleted or not?
  DateTime? deletedAt;

  MessageData({
    required this.id,
    required this.txt,
    required this.from,
    required this.createdAt,
    this.indicative = false,
    this.modifiedAt,
    this.deletedAt,
  });

  Map<String, dynamic> toJson() {
    return {
      "txt": txt,
      "from": from,
      "indicative": indicative,
      "createdAt": createdAt.millisecondsSinceEpoch,
      "deletedAt": deletedAt?.millisecondsSinceEpoch,
      if (modifiedAt != null) "modifiedAt": modifiedAt!.millisecondsSinceEpoch,
      "readBy": readBy.toList()
    };
  }

  factory MessageData.fromJson(Map<String, dynamic> json) {
    return MessageData(
      id: json['id'],
      txt: json['txt'],
      from: json['from'],
      indicative: json['indicative'],
      createdAt: DateTime.fromMillisecondsSinceEpoch(json['createdAt']),
      deletedAt: json['deletedAt'] == null
          ? null
          : DateTime.fromMillisecondsSinceEpoch(json['deletedAt']),
      modifiedAt: json['modifiedAt'] == null
          ? null
          : DateTime.fromMillisecondsSinceEpoch(json['modifiedAt']),
    );
  }

  MessageData.load(this.id, Map<String, dynamic> data) {
    txt = data["txt"];
    from = data["from"];
    createdAt = DateTime.fromMillisecondsSinceEpoch(data["createdAt"]);
    deletedAt = data["deletedAt"] == null
        ? null
        : DateTime.fromMillisecondsSinceEpoch(data["deletedAt"]!);
    indicative = data["indicative"] ?? false;
    modifiedAt = data["modifiedAt"] == null
        ? null
        : DateTime.fromMillisecondsSinceEpoch(data["modifiedAt"]);
    readBy = ((data['readBy'] ?? []) as List<dynamic>)
        .map((e) => e.toString())
        .toSet();
  }
}

Future<void> addMeInReadBy(ChatData chat, MessageData msg) async {
  log("TODO: addMeInReadBy is still pending!!!!!!");
  // final chatMessages = await http.get(Uri.parse('${chatServer}/api/chats/${chat.id}/chat/${msg.id}'));
  // await chatMessages
  //     .doc(msg.id)
  //     .update({'readBy': msg.readBy..add(auth.currentUser!.email!)});
}

Future<MessageData?> fetchLastMessage(String path, {Source? src}) async {
  log("This function is still pending.");
  // final response = await firestore
  //     .collection('$path/chat')
  //     .orderBy('createdAt', descending: true)
  //     .limit(1)
  //     .get(src == null ? null : GetOptions(source: src));
  // for (final doc in response.docs) {
  //   return MessageData.load(doc.id, doc.data());
  // }
  return null;
}

Future<void> addMessage(ChatData chat, MessageData msg) async {
  await http.post(Uri.parse('$chatServer/api/chats/${chat.id}/messages'),
      headers: {
        "Content-Type": "application/json",
      },
      body: json.encode(msg.toJson()));
}

Future<void> deleteMessage(ChatData chat, MessageData msg) async {
  await http.post(
    Uri.parse('$chatServer/api/chats/${chat.id}/messages/${msg.id}'),
    body: {"action": "delete"},
  );
}

Future<List<MessageData>> fetchMessages(
    String chatID, String start, int limit) async {
  log("This function for fetchMessages is still pending.");
  return [];
}

import 'dart:convert';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;

import 'chat.dart';

class MessageData {
  /// The datetime object representing the
  late String id;

  /// The chatID of this msg
  late String chatId;

  /// The markdown text
  late String txt;

  /// Sender of the message
  late String from;

  /// CreatedAt
  late DateTime createdAt;

  /// Modified At
  DateTime? updatedAt;

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
    required this.chatId,
    required this.txt,
    required this.from,
    required this.createdAt,
    this.indicative = false,
    this.updatedAt,
    this.deletedAt,
  });

  Map<String, dynamic> toJson() {
    return {
      "txt": txt,
      "from": from,
      "chatId": chatId,
      "indicative": indicative,
      "readBy": readBy.toList()
    };
  }

  factory MessageData.fromJson(Map<String, dynamic> json) {
    return MessageData(
      id: json['_id'],
      chatId: json['chatId'],
      txt: json['txt'],
      from: json['from'],
      indicative: json['indicative'],
      createdAt: DateTime.parse(json['createdAt']).toLocal(),
      deletedAt: json['deletedAt'] == null
          ? null
          : DateTime.parse(json['deletedAt']).toLocal(),
      updatedAt: DateTime.parse(json['updatedAt']).toLocal(),
    );
  }

  MessageData.load(this.id, Map<String, dynamic> data) {
    txt = data["txt"];
    from = data["from"];
    chatId = data["chatId"];
    createdAt = data["createdAt"];
    deletedAt = data["deletedAt"];
    indicative = data["indicative"] ?? false;
    updatedAt = data["updatedAt"];
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

Future<MessageData> addMessage(ChatData chat, MessageData msg) async {
  final response = await http.post(Uri.parse('$chatServer/messages/${chat.id}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(msg.toJson()));
  if (response.statusCode == 200) {
    return MessageData.fromJson(json.decode(response.body));
  } else {
    throw Exception('Failed to create chat: ${response.body}');
  }
}

Future<void> deleteMessage(ChatData chat, MessageData msg) async {
  throw UnimplementedError();
  // await http.post(
  //   Uri.parse('$chatServer/messages/:chatId/${chat.id}/messages/${msg.id}'),
  //   body: {"action": "delete"},
  // );
}

Future<List<MessageData>> fetchMessages(
    String chatID, String? start, int limit) async {
  final response = await http.get(Uri.parse(
      '$chatServer/messages/$chatID?${start != null ? "start=$start&" : ""}limit=$limit'));
  if (response.statusCode == 200) {
    if (response.body == "null") {
      return [];
    }
    return (json.decode(response.body) as List)
        .map((e) => MessageData.fromJson(e))
        .toList();
  } else {
    throw Exception('Failed to load messages: ${response.body}');
  }
}

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:spinner_try/shivanshu/models/globals.dart';

class Comment {
  String userId;
  String postId;
  String comment;
  Comment({
    required this.userId,
    required this.postId,
    required this.comment,
  });

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      userId: json['userId'] ?? "",
      postId: json['postId'] ?? "",
      comment: json['comment'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'postId': postId,
      'comment': comment,
    };
  }
}

Future<List<Comment>> fetchComments(String postId, int start, int limit) async {
  final response = await http.get(Uri.parse(
      '$momentsServer/api/comments?postId=$postId&start=$start&limit=$limit'));
  if (response.statusCode == 200) {
    final List<dynamic> comments = json.decode(response.body);
    return comments.map((e) => Comment.fromJson(e)).toList();
  } else {
    throw Exception('Failed to load comments');
  }
}

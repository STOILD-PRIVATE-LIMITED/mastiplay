import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:spinner_try/shivanshu/models/globals.dart';

class Tag {
  String tag;
  late DateTime createdAt;
  late DateTime updatedAt;
  Tag({
    required this.tag,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    this.createdAt = createdAt ?? DateTime.now();
    this.updatedAt = updatedAt ?? DateTime.now();
  }

  factory Tag.fromJson(Map<String, dynamic> json) {
    return Tag(
      tag: json['tag'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'tag': tag,
    };
  }
}

Future<List<Tag>> getTags(DateTime? start) async {
  start ??= DateTime.utc(1997);
  final response = await http.get(
    Uri.parse('$momentsServer/api/tags?date=${start.toIso8601String()}'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );
  if (response.statusCode == 200) {
    final List<dynamic> tags = json.decode(response.body);
    return tags.map((e) => Tag.fromJson(e as Map<String, dynamic>)).toList();
  } else {
    throw Exception('Failed to load tags');
  }
}

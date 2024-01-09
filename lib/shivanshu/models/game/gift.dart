import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:spinner_try/shivanshu/models/globals.dart';

Future<void> sendGift(String sentTo, String sentBy, double diamondsSent) async {
  final response = await http.put(Uri.parse('$momentsServer/api/send-gift'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'sentTo': sentTo,
        'sentBy': sentBy,
        'diamondsSent': diamondsSent,
      }));
  if (response.statusCode != 200) {
    throw Exception('Failed to send gift: ${response.body}');
  }
}

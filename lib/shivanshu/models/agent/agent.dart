import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:spinner_try/shivanshu/models/globals.dart';

class AgentData {
  String id = "";
  String? resellerOf;
  int beans = 0;
  int diamonds = 0;
  List<String> paymentMethods = [];
  String? status;

  AgentData({
    this.id = "",
    this.resellerOf,
    this.beans = 0,
    this.diamonds = 0,
    this.paymentMethods = const [],
    this.status,
  });

  factory AgentData.fromJson(Map<String, dynamic> json) {
    return AgentData(
      id: json['id'] ?? "",
      resellerOf: json['resellerOf'],
      beans: json['beans'] ?? 0,
      diamonds: json['diamonds'] ?? 0,
      paymentMethods: json['paymentMethods'] == null
          ? []
          : List<String>.from(json['paymentMethods']),
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'resellerOf': resellerOf,
      'beans': beans,
      'diamonds': diamonds,
      'paymentMethods': paymentMethods,
      'status': status,
    };
  }
}

Future<AgentData> postAgent(AgentData agentData) async {
  if (!agentData.id.startsWith('A')) {
    agentData.id = 'A${agentData.id}';
  }
  final response = await http.post(
    Uri.parse('$momentsServer/api/agent'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode({
      ...agentData.toJson(),
      'userId': agentData.id.substring(1),
    }),
  );
  if (response.statusCode == 200) {
    return AgentData.fromJson(json.decode(response.body));
  } else {
    throw 'Failed to create Agent: ${response.body}';
  }
}

Future<AgentData> fetchAgentData(String id) async {
  final response = await http.get(
    Uri.parse('$momentsServer/api/agent?userId=$id'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );
  log("response.body: ${response.body}");
  if (response.statusCode == 200) {
    return AgentData.fromJson(json.decode(response.body));
  } else {
    throw 'Failed to get Agent: ${response.body}';
  }
}

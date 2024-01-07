import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:spinner_try/shivanshu/models/globals.dart';
import 'package:spinner_try/user_model.dart';

class AgentData {
  String id = "";
  String? resellerOf;
  int diamonds = 0;
  List<String> paymentMethods = [];
  String? status;
  int monthlyDiamonds = 0;

  AgentData({
    this.id = "",
    this.resellerOf,
    this.diamonds = 0,
    this.paymentMethods = const [],
    this.status,
    this.monthlyDiamonds = 0,
  });

  factory AgentData.fromJson(Map<String, dynamic> json) {
    return AgentData(
      id: json['id'] ?? "",
      resellerOf: json['resellerOf'],
      diamonds: json['diamonds'] ?? 0,
      paymentMethods: json['paymentMethods'] == null
          ? []
          : List<String>.from(json['paymentMethods']),
      status: json['status'],
      monthlyDiamonds: json['monthlyDiamonds'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'resellerOf': resellerOf,
      'diamonds': diamonds,
      'paymentMethods': paymentMethods,
      'status': status,
      'monthlyDiamonds': monthlyDiamonds,
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
    throw 'Failed to create AgentData: ${response.body}';
  }
}

Future<UserModel> fetchAgentData(String id) async {
  final response = await http.get(
    Uri.parse('$momentsServer/api/agent?userId=$id'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );
  log("response.body: ${response.body}");
  if (response.statusCode == 200) {
    return UserModel.fromJson(json.decode(response.body));
  } else {
    throw 'Failed to get Agent: ${response.body}';
  }
}

Future<List<UserModel>> fetchAgentsAll(int start, int limit) async {
  final response = await http.get(
    Uri.parse('$momentsServer/api/agent/all?start=$start&limit=$limit'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );
  log("response.body: ${response.body}");
  if (response.statusCode == 200) {
    return List<UserModel>.from(
        json.decode(response.body).map((x) => UserModel.fromJson(x)));
  } else {
    throw 'Failed to get Agents: ${response.body}';
  }
}

// The userId should not start with a 'A'
Future<List<UserModel>> fetchResellersOf(
    String userId, int start, int limit) async {
  final response = await http.get(
    Uri.parse(
        '$momentsServer/api/agent/resellers?userId=$userId&limit=$limit&start=$start'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );
  log("response.body: ${response.body}");
  if (response.statusCode == 200) {
    return List<UserModel>.from(
        json.decode(response.body).map((x) => UserModel.fromJson(x)));
  } else {
    throw 'Failed to get Agents: ${response.body}';
  }
}

Future<void> transferDiamondsFromAgentToUser(
    String agentId, String userId, int diamonds) async {
  if (!agentId.startsWith('A')) {
    agentId = 'A$agentId';
  }
  final response = await http.put(
    Uri.parse('$momentsServer/api/agent-recharge'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode({
      "agentId": agentId,
      "userId": userId,
      "diamonds": diamonds,
    }),
  );
  if (response.statusCode == 200) {
    return;
  } else {
    throw 'Failed to transfer diamonds: ${response.body}';
  }
}

Future<void> agentBeansToDiamonds(String agentId, int beans) async {
  final response = await http.put(
    Uri.parse('$momentsServer/api/agent/convert'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode({
      "agentId": agentId,
      "beans": beans,
    }),
  );
  if (response.statusCode == 200) {
    return;
  } else {
    throw 'Failed to transfer diamonds: ${response.body}';
  }
}

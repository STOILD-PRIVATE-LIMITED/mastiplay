import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:spinner_try/shivanshu/models/globals.dart';
import 'package:spinner_try/user_model.dart';

class AgencyData {
  String? id;
  String name;
  int beansCount = 0;
  String owner;
  double totalBeansReceived;
  AgencyData({
    this.id,
    this.beansCount = 0,
    this.totalBeansReceived = 0,
    this.name = "",
    this.owner = "",
  });

  factory AgencyData.fromJson(Map<String, dynamic> json) {
    return AgencyData(
      id: json['id'] ?? json['agencyId'] ?? json['AgencyId'],
      beansCount: json['beansCount'],
      name: json['name'] ?? '',
      owner: json['ownerId'] ?? '',
      totalBeansReceived: json['totalBeansReceived'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'beansCount': beansCount,
        'name': name,
        'owner': owner,
        'totalBeansReceived': totalBeansReceived,
      };
}

Future<void> joinAgency(String agencyId) async {
  final response =
      await http.post(Uri.parse('$momentsServer/api/agency-joining'), body: {
    'userId': currentUser.id,
    'agencyId': agencyId,
  });
  if (response.statusCode != 200) {
    throw Exception('Failed to join agency');
  }
  currentUser.joinedAgencyData =
      AgencyData.fromJson(json.decode(response.body));
}

Future<AgencyData> getAgencyData({String? userId, String? agencyId}) async {
  assert(userId == null || agencyId == null);
  assert(userId != null || agencyId != null);
  final response = await http.get(
      Uri.parse(
          '$momentsServer/api/agency?${userId != null ? "userId=$userId" : "agencyId=$agencyId"}'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      });
  if (response.statusCode != 200) {
    throw Exception('Failed to get agency data');
  }
  return AgencyData.fromJson(json.decode(response.body));
}

Future<AgencyData> makeAgencyOwner(
    AgencyData? agencyData, String userId) async {
  final response = await http.post(
    Uri.parse('$momentsServer/api/make-agency-owner'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode({
      'agencyId': agencyData?.id,
      'name': agencyData?.name,
      'userId': userId,
    }),
  );
  if (response.statusCode != 200) {
    throw Exception('Failed to make agency owner: ${response.body}');
  }
  return AgencyData.fromJson(json.decode(response.body));
}

Future<void> changeRole(String userId, String role) async {
  final response = await http.post(
    Uri.parse('$momentsServer/api/change-role'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: {
      'userId': userId,
      'role': role,
    },
  );
  if (response.statusCode != 200) {
    throw Exception('Failed to change role');
  }
}

Future<void> addBeans(String userId, double beans) async {
  final response = await http.post(
    Uri.parse('$momentsServer/api/add-beans'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: {
      'userId': userId,
      'beans': beans,
    },
  );
  if (response.statusCode != 200) {
    throw Exception('Failed to add beans');
  }
}

Future<List<UserModel>> getAgencyParticipants(
    String agencyId, int start, int limit) async {
  final response = await http.get(
    Uri.parse(
        '$momentsServer/api/agency/participants?agencyId=$agencyId&start=$start&limit=$limit'),
  );
  if (response.statusCode != 200) {
    throw Exception('Failed to get agency participants: ${response.body}');
  }
  return (json.decode(response.body) as List)
      .map((e) => UserModel.fromJson(e))
      .toList();
}

Future<void> collectBeans(String agencyId) async {
  final response = await http.put(
    Uri.parse('$momentsServer/api/agency/collect?agencyId=$agencyId'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );
  if (response.statusCode != 200) {
    throw Exception('Failed to collect beans');
  }
}

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:spinner_try/shivanshu/models/globals.dart';
import 'package:spinner_try/shivanshu/models/momets/post.dart';

class AgencyData {
  String id;
  String name;
  double diamonds = 0;
  double beans = 0;
  AgencyData({
    this.id = "",
    this.diamonds = 0,
    this.beans = 0,
    this.name = "",
  });

  factory AgencyData.fromJson(Map<String, dynamic> json) {
    return AgencyData(
      id: json['id'],
      diamonds: json['diamonds'],
      beans: json['beans'],
      name: json['name'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'diamonds': diamonds,
        'beans': beans,
        'name': name,
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

Future<AgencyData> getAgencyData(String id) async {
  final response =
      await http.get(Uri.parse('$momentsServer/api/agency?id=$id'));
  if (response.statusCode != 200) {
    throw Exception('Failed to get agency data');
  }
  return AgencyData.fromJson(json.decode(response.body));
}

Future<AgencyData> makeAgencyOwner(String? agencyId, String userId) async {
  final response = await http.post(
    Uri.parse('$momentsServer/api/make-agency-owner'),
    body: jsonEncode({
      'agencyId': agencyId,
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
    body: {
      'userId': userId,
      'role': role,
    },
  );
  if (response.statusCode != 200) {
    throw Exception('Failed to change role');
  }
}

Future<void> addDiamonds(String userId, double diamonds) async {
  final response = await http.post(
    Uri.parse('$momentsServer/api/add-diamonds'),
    body: {
      'userId': userId,
      'diamonds': diamonds,
    },
  );
  if (response.statusCode != 200) {
    throw Exception('Failed to add diamonds');
  }
}

Future<void> addBeans(String userId, double beans) async {
  final response = await http.post(
    Uri.parse('$momentsServer/api/add-beans'),
    body: {
      'userId': userId,
      'beans': beans,
    },
  );
  if (response.statusCode != 200) {
    throw Exception('Failed to add beans');
  }
}

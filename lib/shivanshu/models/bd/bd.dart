import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:spinner_try/shivanshu/models/globals.dart';
import 'package:spinner_try/user_model.dart';

class BD {
  String id = "";
  double beans = 0;
  String owner = "";
  UserModel? ownerData;

  BD({this.id = "", this.beans = 0, this.owner = ""});

  BD.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? id;
    beans = json['beans'] ?? beans;
    owner = json['owner'] ?? owner;
    ownerData = json['ownerData'] == null
        ? ownerData
        : UserModel.fromJson(json['ownerData']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'beans': beans,
      'owner': owner,
    };
  }
}

Future<List<BD>> getAllBD([int start = 0, int limit = 20]) async {
  final response = await http.get(
    Uri.parse('$momentsServer/api/bd/all?start=$start&limit=$limit'),
    headers: {
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );
  if (response.statusCode != 200) {
    throw Exception(response.body);
  }
  List<BD> bds = [];
  for (var bd in json.decode(response.body)) {
    bds.add(BD.fromJson(bd));
  }
  return bds;
}

Future<BD> getBD(String? id, String? userId) async {
  assert(id == null || userId == null);
  assert(id != null || userId != null);
  final response = await http.get(
    Uri.parse(
        '$momentsServer/api/bd?${id != null ? "id=$id" : "userId=$userId"}'),
    headers: {
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );
  if (response.statusCode != 200) {
    throw Exception(response.body);
  }
  return BD.fromJson(json.decode(response.body));
}

Future<List<dynamic>> getParticipantAgencies(String bdId,
    [int start = 0, int limit = 20]) async {
  final response = await http.get(
    Uri.parse(
        '$momentsServer/api/bd/participants?bdId=$bdId&start=$start&limit=$limit'),
    headers: {
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );
  if (response.statusCode != 200) {
    throw Exception(response.body);
  }
  return json.decode(response.body);
}

Future<void> createBd(BD bd) async {
  final response = await http.post(
    Uri.parse('$momentsServer/api/bd'),
    headers: {
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(bd.toJson()),
  );
  if (response.statusCode != 200) {
    throw Exception(response.body);
  }
}

Future<void> updateBd(BD bd) async {
  final response = await http.post(
    Uri.parse('$momentsServer/api/bd/update'),
    headers: {
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(bd.toJson()),
  );
  if (response.statusCode != 200) {
    throw Exception(response.body);
  }
}

Future<void> addBeans(String bdId, double beans) async {
  final response = await http.post(
    Uri.parse('$momentsServer/api/bd/add-beans'),
    headers: {
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode({
      'bdId': bdId,
      'beans': beans,
    }),
  );
  if (response.statusCode != 200) {
    throw Exception(response.body);
  }
}

Future<void> addAgency(String bdId, String agencyId) async {
  final response = await http.post(
    Uri.parse('$momentsServer/api/bd/add-agency'),
    headers: {
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode({
      'bdId': bdId,
      'agencyId': agencyId,
    }),
  );
  if (response.statusCode != 200) {
    throw Exception(response.body);
  }
}

Future<void> removeAgency(String bdId, String agencyId) async {
  final response = await http.post(
    Uri.parse('$momentsServer/api/bd/remove-agency'),
    headers: {
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode({
      'bdId': bdId,
      'agencyId': agencyId,
    }),
  );
  if (response.statusCode != 200) {
    throw Exception(response.body);
  }
}

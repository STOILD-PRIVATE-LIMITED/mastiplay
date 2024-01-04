import 'dart:convert';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:spinner_try/chat/widgets/profile_preview.dart';
import 'package:spinner_try/shivanshu/models/agency/agency.dart';
import 'package:spinner_try/shivanshu/models/agent/agent.dart';
import 'package:spinner_try/shivanshu/models/globals.dart';
import 'package:spinner_try/shivanshu/models/momets/post.dart';
import 'package:spinner_try/shivanshu/utils.dart';

class UserModel {
  String? id = "-1";
  String? agentId;
  String name = "";
  String email = "";
  String photo = "";
  String? phoneNumber;
  int gender = -1;
  DateTime? dob;
  String country = "";
  String? frame;
  int followers = 0;
  int following = 0;
  int friends = 0;
  int diamonds = 0;
  int beans = 0;
  AgentData? agentData;
  AgencyData? ownedAgencyData;
  AgencyData? joinedAgencyData;
  String? role;

  UserModel({
    this.dob,
    this.phoneNumber,
    this.id,
    this.agentId,
    this.name = "",
    this.photo = "",
    this.gender = -1,
    this.email = "",
    this.country = "",
    this.frame,
    this.followers = 0,
    this.following = 0,
    this.friends = 0,
    this.diamonds = 0,
    this.beans = 0,
    this.agentData,
    this.ownedAgencyData,
    this.joinedAgencyData,
    this.role,
  });

  factory UserModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return UserModel.fromJson(data);
  }

  void load(Map<String, dynamic> data) {
    id = data['id'] ?? id;
    agentId = data['agentId'] ?? agentId;
    photo = data["photo"] ?? photo;
    name = data["name"] ?? name;
    phoneNumber = data["phoneNumber"] ?? phoneNumber;
    email = data["email"] ?? email;
    dob = data['dob'] == null
        ? dob
        : data['dob'] is String
            ? DateTime.parse(data['dob'])
            : DateTime.fromMillisecondsSinceEpoch(data['dob'] * 1000);
    gender = data['gender'] ?? gender;
    country = data['country'] ?? "";
    frame = data['frame'] ?? frame;
    followers = data['followersCount'] ?? followers;
    following = data['followingCount'] ?? following;
    diamonds = data['diamondsCount'] ?? diamonds;
    beans = data['beansCount'] ?? beans;
    friends = data['friends'] ?? friends;
    agentData = data['agentData'] == null
        ? agentData
        : AgentData.fromJson(data['agentData']);
    ownedAgencyData = data['ownedAgencyData'] == null
        ? ownedAgencyData
        : AgencyData.fromJson(data['ownedAgencyData']);
    joinedAgencyData = data['joinedAgencyData'] == null
        ? joinedAgencyData
        : AgencyData.fromJson(data['joinedAgencyData']);
    role = data['role'] ?? role;
  }

  factory UserModel.fromJson(Map<String, dynamic> data) {
    return UserModel()..load(data);
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "agentId": agentId,
      "name": name,
      "email": email,
      "photo": photo,
      "phoneNumber": phoneNumber,
      'dob': dob?.toJson(),
      'gender': gender,
      'country': country,
      'frame': frame,
      // 'agentData': agentData?.toJson(),
      // 'ownedAgencyData': ownedAgencyData?.toJson(),
      // 'joinedAgencyData': joinedAgencyData?.toJson(),
      // 'role': role,
      // 'diamondsCount': diamonds,
      // 'beansCount': beans,
      // 'followersCount': followers,
      // 'followingCount': following,
      // 'friends': friends,
    };
  }
}

Future<UserModel> fetchUserWithEmail(String email) async {
  final doc = (await firestore
          .collection('users')
          .where('email', isEqualTo: email)
          .get())
      .docs
      .single;
  final user = UserModel.fromJson(doc.data());
  try {
    final response = await http.get(
      Uri.parse('$momentsServer/api/users?userId=${user.id}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    user.load(json.decode(response.body));
  } catch (e) {
    log("Failed to load user: $e");
  }
  return user;
}

Future<UserModel> fetchUserWithId(String id) async {
  final doc =
      (await firestore.collection('users').where('id', isEqualTo: id).get())
          .docs
          .single;
  final user = UserModel.fromJson(doc.data());
  try {
    final response = await http.get(
      Uri.parse('$momentsServer/api/users?userId=$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    if (response.statusCode != 200) {
      throw response.body;
    }
    log("response.body = ${response.body}");
    user.load(json.decode(response.body));
  } catch (e) {
    log("Failed to load user: $e");
  }
  return user;
}

Future<List<UserModel>> fetchUsers(List<String> ids) async {
  final List<Future> futures = [];
  for (final id in ids) {
    futures.add(firestore.collection('users').where('id', isEqualTo: id).get());
  }
  final docs = await Future.wait(futures);
  final users =
      docs.map((e) => UserModel.fromJson(e.docs.single.data())).toList();
  return users;
}

Future<void> followUser(String userId) async {
  try {
    final response =
        await http.post(Uri.parse("$momentsServer/api/follow"), body: {
      "followerId": currentUser.id!,
      "followingId": userId,
    });
    if (response.statusCode != 200) {
      throw Exception('Failed to follow: ${response.body}');
    }
  } catch (e) {
    log("Failed to follow: $e");
  }
}

Future showUserPreview(BuildContext context, UserModel user) {
  return Navigator.of(context).push(
    DialogRoute(
      context: context,
      builder: (ctx) => AlertDialog(
        contentPadding: const EdgeInsets.only(
          top: 40,
          bottom: 20,
          right: 10,
          left: 10,
        ),
        content: ProfilePreview(user: user),
      ),
    ),
  );
}

Future<void> createUser(UserModel userData) async {
  try {
    final response = await http.post(
      Uri.parse('$momentsServer/api/user'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(userData.toJson()),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to create user: ${response.body}');
    }
  } catch (e) {
    log("Failed to create user: $e");
  }
}

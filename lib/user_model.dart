import 'dart:convert';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:spinner_try/chat/widgets/profile_preview.dart';
import 'package:spinner_try/shivanshu/models/globals.dart';
import 'package:spinner_try/shivanshu/models/momets/post.dart';
import 'package:spinner_try/shivanshu/utils.dart';

class UserModel {
  String? id = "-1";
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

  UserModel({
    this.dob,
    this.phoneNumber,
    this.id,
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
  });

  factory UserModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return UserModel.fromJson(data);
  }

  void load(Map<String, dynamic> data) {
    id = data['id'] ?? id;
    photo = data["photo"] ?? photo;
    name = data["name"] ?? name;
    phoneNumber = data["phoneNumber"] ?? phoneNumber;
    email = data["email"] ?? email;
    dob = data['dob'] == null
        ? dob
        : DateTime.fromMillisecondsSinceEpoch(data['dob'] * 1000);
    gender = data['gender'] ?? gender;
    country = data['country'] ?? "";
    frame = data['frame'] ?? frame;
    followers = data['followers'] ?? followers;
    following = data['following'] ?? following;
    diamonds = data['diamonds'] ?? diamonds;
    beans = data['beans'] ?? beans;
    friends = data['friends'] ?? friends;
  }

  factory UserModel.fromJson(Map<String, dynamic> data) {
    return UserModel()..load(data);
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "email": email,
      "photo": photo,
      "phoneNumber": phoneNumber,
      'dob': dob?.toJson(),
      'gender': gender,
      'country': country,
      'frame': frame,
      'diamonds': diamonds,
      'beans': beans,
      'followers': followers,
      'following': following,
      'friends': friends,
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
  return UserModel.fromJson(doc.data());
}

Future<UserModel> fetchUserWithId(String id) async {
  final doc =
      (await firestore.collection('users').where('id', isEqualTo: id).get())
          .docs
          .single;

  final user = UserModel.fromJson(doc.data());
  final response = await http.get(
    Uri.parse('$momentsServer/api/users'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );
  user.load(json.decode(response.body));
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
      "followerId": userId,
      "followingId": currentUser.id!,
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

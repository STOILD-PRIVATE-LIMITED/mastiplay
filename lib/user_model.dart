import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:spinner_try/chat/widgets/profile_preview.dart';
import 'package:spinner_try/shivanshu/utils.dart';

import 'shivanshu/models/firestore/firestore_document.dart';

class UserModel {
  String? id;
  String name;
  String email;
  String photo;
  String? phoneNumber;
  int gender;
  DateTime? dob;
  String country;
  String? frame;

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
  });

  factory UserModel.fromSnapahot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return UserModel.fromJson(data);
  }

  factory UserModel.fromJson(Map<String, dynamic> data) {
    return UserModel(
      id: data['id'] ?? (-1).toString(),
      photo: data["photo"] ?? "",
      name: data["name"],
      phoneNumber: data["phoneNumber"],
      email: data["email"],
      dob: DateTime.fromMillisecondsSinceEpoch(data['dob'] * 1000),
      gender: data['gender'] ?? -1,
      country: data['country'] ?? "",
      frame: data['frame'],
    );
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
      'frame': frame
    };
  }
}

Future<UserModel> fetchUser(String email) async {
  final doc = (await FirestoreDocument(id: email, path: "users").fetch());
  return UserModel.fromJson(doc.data);
}

Future<List<UserModel>> fetchUsers(List<String> emails) async {
  List<Future<UserModel>> futures = [];
  for (String email in emails) {
    futures.add(fetchUser(email));
  }
  List<UserModel> users = await Future.wait(futures);
  return users;
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

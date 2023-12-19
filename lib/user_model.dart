import 'package:cloud_firestore/cloud_firestore.dart';
import 'shivanshu/models/firestore/firestore_document.dart';

class UserModel {
  final String? id;
  final String name;
  final String email;
  final String photo;
  final int gender;
  final DateTime? dob;
  final String country;

  const UserModel({
    this.dob,
    this.id,
    required this.name,
    required this.photo,
    this.gender = 1,
    required this.email,
    required this.country
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
      email: data["email"],
      dob: data['dob'],
      gender: data['gender'],
      country: data['country'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "email": email,
      "photo": photo,
      'dob': dob,
      'gender': gender,
      'country': country,
    };
  }
}

Future<UserModel> fetchUser(String email) async {
  final doc = (await FirestoreDocument(id: email, path: "users").fetch());
  return UserModel.fromJson(doc.data);
}

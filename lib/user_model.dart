import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:spinner_try/shivanshu/models/firestore/firestore_document.dart';

class UserModel {
  final String? id;
  final String name;
  final String email;
  final String photo;

  const UserModel({
    this.id,
    required this.name,
    required this.photo,
    required this.email,
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
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "email": email,
      "photo": photo,
    };
  }
}

Future<UserModel> fetchUser(String email) async {
  final doc = (await FirestoreDocument(id: email, path: "users").fetch());
  return UserModel.fromJson(doc.data);
}

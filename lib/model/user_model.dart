// import 'package:cloud_firestore/cloud_firestore.dart';

// class UserModell {
//   final String email;
//   final String name;
//   final String userProfileImage;
//   const UserModell({
//     required this.email,
//     required this.name,
//     required this.userProfileImage,
//   });
//   factory UserModell.fromSnapahot(
//       DocumentSnapshot<Map<String, dynamic>> document) {
//     final data = document.data()!;
//     return UserModell(
//       email: data['email'],
//       name: data['name'],
//       userProfileImage: data['photo'],
//     );
//   }
// }

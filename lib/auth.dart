// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:spinner_try/screen/login.dart';
// import 'package:spinner_try/shivanshu/models/globals.dart';
// import 'package:spinner_try/user.dart';
// import 'package:spinner_try/user_model.dart';

// class MyAuth extends StatefulWidget {
//   const MyAuth({super.key});

//   @override
//   State<MyAuth> createState() => _MyAuthState();
// }

// class _MyAuthState extends State<MyAuth> {
//   final _db = FirebaseFirestore.instance;

//   Future<UserModel> getUser(email) async {
//     final snapshot = await _db.collection("users").doc(email).get();
//     if (!snapshot.exists) {
//       throw Exception("User not found");
//     }
//     final itemData = UserModel.fromSnapahot(snapshot);
//     return itemData;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: StreamBuilder<User?>(
//         stream: FirebaseAuth.instance.authStateChanges(),
//         builder: (context, AsyncSnapshot snapshot) {
//           if (snapshot.hasData) {
//             final FirebaseAuth auth = FirebaseAuth.instance;
//             final User? user = auth.currentUser;
//             final email = user!.email;
//             return FutureBuilder(
//               future: getUser(email),
//               builder: (context, snapshot1) {
//                 if (snapshot1.connectionState == ConnectionState.done) {
//                   if (snapshot1.hasData) {
//                     UserModel userdata = snapshot1.data as UserModel;
//                     currentUser = userdata;
//                     return UserHome(
//                         email: email,
//                         name: userdata.name,
//                         photo: userdata.photo);
//                   } else if (snapshot1.hasError) {
//                     return Center(
//                       child: Column(
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           Center(
//                               child: Text(
//                             snapshot1.error.toString(),
//                             style: const TextStyle(color: Colors.red),
//                           )),
//                           ElevatedButton(
//                             onPressed: () {
//                               Navigator.of(context).pushReplacement(
//                                 MaterialPageRoute(
//                                   builder: (context) => const Login(),
//                                 ),
//                               );
//                             },
//                             child: const Text('Login Again'),
//                           ),
//                         ],
//                       ),
//                     );
//                   } else {
//                     return Center(
//                       child: Column(
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           const Center(child: Text("Something wrong")),
//                           ElevatedButton(
//                             onPressed: () {
//                               Navigator.of(context).pushReplacement(
//                                 MaterialPageRoute(
//                                   builder: (context) => const Login(),
//                                 ),
//                               );
//                             },
//                             child: const Text('Login Again'),
//                           ),
//                         ],
//                       ),
//                     );
//                   }
//                 } else {
//                   return const Center(child: CircularProgressIndicator());
//                 }
//               },
//             );
//           } else {
//             return const Login();
//           }
//         },
//       ),
//     );
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spinner_try/user_model.dart';

/// Instead of creating multiple instances of the same object
/// I created then altogether here
final auth = FirebaseAuth.instance;
final firestore = FirebaseFirestore.instance;
final storage = FirebaseStorage.instance;
UserModel currentUser = UserModel(name: "", photo: "", email: "", country: "");

late final SharedPreferences prefs;

// Server Addresses
String chatServer = "https://v9nm4hsv-3000.asse.devtunnels.ms";
// String chatServer = "https://3.7.66.245:3000";
// keep this without trailing slash

// const String momentsServer = "https://v9nm4hsv-3007.asse.devtunnels.ms";
// const String momentsServer = "https://5306-103-137-198-236.ngrok-free.app";
const String momentsServer = "https://d808-103-137-198-235.ngrok-free.app";
// const String momentsServer = "https://3.7.66.245:3007";

// The below represents the server address of the server running the socket.io server
// const String websocketUrl = "https://3.7.66.245:8080";
// const String websocketUrl = "https://192.168.9.64:8080";
const String websocketUrl = "https://v9nm4hsv-8080.asse.devtunnels.ms";

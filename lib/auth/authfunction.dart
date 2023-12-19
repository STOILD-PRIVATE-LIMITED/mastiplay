import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:spinner_try/auth.dart';
import '../screen/home.dart';
import '../shivanshu/screens/home_live.dart';

Future<UserCredential> signInWithFacebook(context) async {
  try {
    LoginResult loginResult = await FacebookAuth.instance.login();

    if (loginResult.status == LoginStatus.success) {
      final AccessToken accessToken = loginResult.accessToken!;
      final OAuthCredential credential =
          FacebookAuthProvider.credential(accessToken.token);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const HomePage(),
        ),
      );
      return await FirebaseAuth.instance.signInWithCredential(credential);
    } else {
      throw FirebaseAuthException(
        code: '!!!!Facebook Login Failed!!!!',
        message: '!!!!The Facebook login was not successful.!!!!',
      );
    }
  } on FirebaseAuthException catch (e) {
    if (kDebugMode) {
      print('Firebase Auth Exception: ${e.message}');
    }
    rethrow; 
  } catch (e) {
    if (kDebugMode) {
      print('Other Exception: $e');
    }
    rethrow;
  }
}

class AuthServices {
  static signinUser(String email, String password, context) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('You are Logged in'),
        ),
      );
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const HomePage(),
        ),
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('No user Found with this Email'),
          ),
        );
      } else if (e.code == 'wrong-password') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Password did not match'),
          ),
        );
      }
    }
  }
}

Future<UserCredential?> signInWithGoogle(context) async {
  try {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    if (googleUser == null) {
      return null;
    }

    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final UserCredential userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const MyAuth(),
      ),
    );

    return userCredential;
  } catch (e) {
    if (kDebugMode) {
      print("Error signing in with Google: $e");
    }
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text("Error signing in with Google"),
    ));
    return null;
  }
}

  // static signupUser(String password, name, email, BuildContext context) async {
  //   try {
  //     UserCredential userCredential = await FirebaseAuth.instance
  //         .createUserWithEmailAndPassword(email: email, password: password);
  //     await FirebaseAuth.instance.currentUser!.updateDisplayName(email);
  //     await FirebaseAuth.instance.currentUser!.updateEmail(email);
  //     await FirestoreServices.saveUser(name, userCredential.user!.uid, email);
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(
  //         content: Text('Registration Successful'),
  //       ),
  //     );
  //     // Get.toNamed(NameRoutes.homeScreen);
  //   } on FirebaseAuthException catch (e) {
  //     if (e.code == 'weak-password') {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         const SnackBar(
  //           content: Text('Password Provided is too weak'),
  //         ),
  //       );
  //     } else if (e.code == 'email-already-in-use') {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         const SnackBar(
  //           content: Text('Email Provided already Exists'),
  //         ),
  //       );
  //     }
  //   } catch (e) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(
  //         content: Text(
  //           e.toString(),
  //         ),
  //       ),
  //     );
  //   }
  // }
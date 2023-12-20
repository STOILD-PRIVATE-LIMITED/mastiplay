import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:spinner_try/shivanshu/screens/gender_screen.dart';
import 'package:spinner_try/shivanshu/screens/home_live.dart';
import 'package:spinner_try/user_model.dart';

// Future<UserCredential> signInWithFacebook(context) async {
//   try {
//     LoginResult loginResult = await FacebookAuth.instance.login();

//     if (loginResult.status == LoginStatus.success) {
//       final AccessToken accessToken = loginResult.accessToken!;
//       final OAuthCredential credential =
//           FacebookAuthProvider.credential(accessToken.token);
//       Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (context) => const HomeLive(),
//         ),
//       );
//       return await FirebaseAuth.instance.signInWithCredential(credential);
//     } else {
//       throw FirebaseAuthException(
//         code: '!!!!Facebook Login Failed!!!!',
//         message: '!!!!The Facebook login was not successful.!!!!',
//       );
//     }
//   } on FirebaseAuthException catch (e) {
//     if (kDebugMode) {
//       print('Firebase Auth Exception: ${e.message}');
//     }
//     rethrow;
//   } catch (e) {
//     if (kDebugMode) {
//       print('Other Exception: $e');
//     }
//     rethrow;
//   }
// }

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
          builder: (context) => HomeLive(
            email: email,
          ),
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
    final user = FirebaseAuth.instance.currentUser;
    try {
      await fetchUser('${user!.email}');
      final variable = await fetchUser('${user.email}');
      if (variable.id == null || variable.id!.isEmpty) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => GenderScreen(
              username: '${user.displayName}',
              email: '${user.email}',
            ),
          ),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => HomeLive(
              email: '${user.email}',
            ),
          ),
        );
      }
    } catch (e) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomeLive(
            email: '${user!.email}',
          ),
        ),
      );
    }
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

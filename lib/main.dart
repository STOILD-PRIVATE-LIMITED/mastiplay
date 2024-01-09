import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spinner_try/chat/models/chat.dart';
import 'package:spinner_try/chat/models/message.dart';
import 'package:spinner_try/screen/login.dart';
import 'package:spinner_try/shivanshu/models/firestore/fcm.dart';
import 'package:spinner_try/shivanshu/models/globals.dart';
import 'package:spinner_try/shivanshu/screens/gender_screen.dart';
import 'package:spinner_try/shivanshu/screens/home_live.dart';
import 'package:spinner_try/shivanshu/utils.dart';
import 'package:spinner_try/shivanshu/widgets/highlight_wheel.dart';
import 'package:spinner_try/user_model.dart';

import 'firebase_options.dart';

class DevHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = DevHttpOverrides();

  // ByteData data =
  //     await PlatformAssetBundle().load('assets/ssl/server-cert.pem');
  // SecurityContext.defaultContext
  //     .setTrustedCertificatesBytes(data.buffer.asUint8List(),);

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  prefs = await SharedPreferences.getInstance();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
  // final query = await firestore.collection('users').get();
  // for (var e in query.docs) {
  //   final user = UserModel.fromJson(e.data());
  //   await createUser(user);
  // }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      title: 'Masti Play',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 224, 93, 211),
        ),
        useMaterial3: true,
        fontFamily: 'assets/fontsSofiaProRegular.ttf',
      ),
      home: const NewAuth(),
      // home: const SpinnerPage(),
    );
  }
}

class NewAuth extends StatefulWidget {
  const NewAuth({super.key});

  @override
  State<NewAuth> createState() => _NewAuthState();
}

BuildContext? newAuthPagecontext;

class _NewAuthState extends State<NewAuth> {
  @override
  void initState() {
    super.initState();
    newAuthPagecontext = context;
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      final messageData = message.data['message'];
      final msg = MessageData.fromJson(jsonDecode(messageData));
      showChat(context, chatId: msg.chatId);
    });
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (auth.currentUser != null) {
        _load();
      }
    });
  }

  @override
  void dispose() {
    newAuthPagecontext = null;
    super.dispose();
  }

  bool _loading = false;
  String? _err;

  void _load() async {
    if (context.mounted) {
      setState(() {
        _loading = true;
      });
    }
    try {
      await Future.wait([
        fetchUserWithEmail(auth.currentUser!.email!),
        setupFCMTokenMangement(),
      ]);
    } catch (e) {
      _err = e.toString();
    }
    if (context.mounted) {
      setState(() {
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      key: const ValueKey('newAuthStreamBuilder'),
      stream: auth.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          // Looged in
          if (_err != null) {
            log("_err is not null");
            return GenderScreen(
              email: auth.currentUser!.email!,
            );
          } else if (_loading) {
            return Scaffold(
              body: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      'assets/logo.png',
                      width: width / 2,
                      height: width / 2,
                      fit: BoxFit.contain,
                    ),
                    const SizedBox(
                      height: 16,
                      width: 16,
                      child: CircularProgressIndicatorRainbow(),
                    ),
                    const Text('Loading...'),
                  ],
                ),
              ),
            );
          }
          log("Current User: ${currentUser.toJson()}");
          if (currentUser.gender == -1 ||
              currentUser.dob == null ||
              currentUser.country.isEmpty ||
              currentUser.frame == null) {
            return GenderScreen(
              email: auth.currentUser!.email!,
            );
          } else {
            return HomeLive(
              email: auth.currentUser!.email!,
            );
          }
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            body: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    'assets/logo.png',
                    width: width / 2,
                    height: width / 2,
                    fit: BoxFit.contain,
                  ),
                  const Text("You're logged in"),
                ],
              ),
            ),
          );
        } else if (snapshot.hasError) {
          return Scaffold(
            body: Center(
              child: Text('Error: ${snapshot.error}'),
            ),
          );
        }
        return const Login();
      },
    );
  }
}

class SpinnerPage extends StatelessWidget {
  const SpinnerPage({super.key});

  @override
  Widget build(BuildContext context) {
    final animals = ['🐰', '🐱', '🐶', '🐵', '🐬', '🐼', '🦅', '🦁'];
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/bg_img.webp'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: HighlightWheel(
            childWidth: 40,
            childHeight: 40,
            minRotations: 0.5,
            duration: 10,
            highlightedItemBuilder: (index) {
              return CircleAvatar(
                backgroundColor: Colors.red,
                child: Text(
                  animals[index],
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              );
            },
            onComplete: (index) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('You got ${animals[index]}'),
                ),
              );
            },
            items: animals
                .map(
                  (e) => CircleAvatar(
                    child: Text(
                      e,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                )
                .toList(),
          ),
        ),
      ),
    );
  }
}

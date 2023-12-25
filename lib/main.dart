import 'dart:developer';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
  runApp(
    const MyApp(),
  );
}

class WrapperApp extends StatefulWidget {
  const WrapperApp({super.key});

  @override
  State<WrapperApp> createState() => _WrapperAppState();
}

class _WrapperAppState extends State<WrapperApp> {
  @override
  void initState() {
    super.initState();

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      log("FCM message received: ${message.data}");
      showMsg(context, message.data);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      log("FCM message opened: ${message.data}");
      showMsg(context, message.data);
    });

    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  }

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Masti Play',
      home: Scaffold(
        body: MyApp(),
      ),
    );
  }
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
        home: const NewAuth()
        // home: const ProfileEdit(),
        // home: HomeScreennn(),
        // home: const HomeLive()
        // home: VideoCallApp(),
        // home: const NobelCenter(),
        // home: const AnotherNodelCenter(),
        // home: JackpotScreen(
        //   items: animals.map((e) => Text(e),).toList(),
        //   itemHeight: 30,
        // ),
        );
  }
}

class NewAuth extends StatelessWidget {
  const NewAuth({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      key: const ValueKey('newAuthStreamBuilder'),
      stream: auth.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return FutureBuilder(
            key: const ValueKey('newAuthFutureBuilder'),
            future: fetchUser(auth.currentUser!.email!),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return GenderScreen(
                  email: auth.currentUser!.email!,
                );
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
                        const CircularProgressIndicatorRainbow(),
                        const Text('Loading...'),
                      ],
                    ),
                  ),
                );
              } else if (snapshot.hasData) {
                currentUser = snapshot.data!;
                setupFCMTokenMangement();
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
              }
              return const Login();
            },
          );
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
                  const CircularProgressIndicatorRainbow(),
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
            minRotations: 1,
            duration: 4,
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

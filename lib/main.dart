import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:spinner_try/auth.dart';
import 'package:spinner_try/shivanshu/screens/home_live.dart';
import 'package:spinner_try/shivanshu/utils.dart';
import 'package:spinner_try/shivanshu/widgets/highlight_wheel.dart';

import 'firebase_options.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

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
  //     .setTrustedCertificatesBytes(data.buffer.asUint8List());

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
        title: 'Spinner Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 224, 93, 211),
          ),
          useMaterial3: true,
          fontFamily: 'assets/fontsSofiaProRegular.ttf',
        ),

        home: const MyAuth(),
        // home: const ProfileEdit(),
        // home: HomeScreennn(),
        // home: const HomeLive()
        // home: VideoCallApp(),
        // home: const NobelCenter(),
        // home: const AnotherNodelCenter(),
        // home: JackpotScreen(
        //   items: animals.map((e) => Text(e)).toList(),
        //   itemHeight: 30,
        // ),
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
                  ));
            },
            onComplete: (index) {
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('You got ${animals[index]}')));
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

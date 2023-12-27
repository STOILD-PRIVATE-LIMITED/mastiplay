import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:spinner_try/main.dart';
import 'package:spinner_try/screen/login.dart';
import 'package:spinner_try/shivanshu/utils/loading_elevated_button.dart';

class Setting extends StatefulWidget {
  const Setting({super.key});

  @override
  State<Setting> createState() => SettingState();
}

class SettingState extends State<Setting> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xFFf7f8fc),
      appBar: AppBar(
        backgroundColor: const Color(0xFFf7f8fc),
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios,
            size: height / 40,
          ),
        ),
        title: Text(
          "Help Form",
          style: TextStyle(fontSize: height / 40),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: width / 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ListTile(
              title: Text(
                'Current Version',
                style: TextStyle(
                    fontSize: height / 50, fontWeight: FontWeight.bold),
              ),
              trailing: Text(
                'V 1.0.0',
                style: TextStyle(
                  fontSize: height / 40,
                ),
              ),
            ),
            ListTile(
              title: Text(
                'Language Version',
                style: TextStyle(
                  fontSize: height / 50,
                  fontWeight: FontWeight.bold,
                ),
              ),
              trailing: Icon(
                Icons.arrow_forward_ios,
                size: height / 40,
              ),
            ),
            ListTile(
              title: Text(
                'Delete Account',
                style: TextStyle(
                  fontSize: height / 50,
                  fontWeight: FontWeight.bold,
                ),
              ),
              trailing: Icon(
                Icons.arrow_forward_ios,
                size: height / 40,
              ),
            ),
            SizedBox(height: height / 30),
            LoadingElevatedButton(
              icon: const Icon(Icons.logout_rounded),
              label: const Text('Logout'),
              onPressed: () async {
                while (Navigator.of(context).canPop()) {
                  Navigator.of(context).pop();
                }
                await FirebaseAuth.instance.signOut();
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => const NewAuth()));
              },
            ),
          ],
        ),
      ),
    );
  }
}

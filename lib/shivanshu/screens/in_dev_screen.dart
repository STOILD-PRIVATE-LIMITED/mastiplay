import 'package:flutter/material.dart';
import 'package:spinner_try/shivanshu/screens/family_room_page.dart';
import 'package:spinner_try/shivanshu/utils.dart';

class InDevScreen extends StatelessWidget {
  const InDevScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const ElevatedBackButton(),
      ),
      body: Center(
        child: MyColumn(
          children: [
            const Text('This part of the app is in development'),
            const SizedBox(height: 20),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Go Back'))
          ],
        ),
      ),
    );
  }
}

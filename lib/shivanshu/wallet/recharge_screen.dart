import 'package:flutter/material.dart';
import 'package:spinner_try/shivanshu/utils.dart';

class RechargeScreen extends StatelessWidget {
  const RechargeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) => ListTile(
        title: const Text('UPI'),
        subtitle: const Text('2023-12-05 22:59:20'),
        trailing: MyRow(
          children: [
            const Text('+1000'),
            Image.asset(
              'assets/diamond.png',
              width: 14,
            ),
          ],
        ),
      ),
    );
  }
}

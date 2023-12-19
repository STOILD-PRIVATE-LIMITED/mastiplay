import 'package:flutter/material.dart';
import 'package:spinner_try/shivanshu/utils.dart';

class BeanExchangeScreen extends StatelessWidget {
  const BeanExchangeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) => ListTile(
        title: MyRow(
          children: [
            const Text('100'),
            Image.asset(
              'assets/diamond.png',
              width: 14,
            ),
            const SizedBox(width: 10),
            const Icon(Icons.arrow_right_alt_rounded),
            const SizedBox(width: 10),
            const Text('100'),
            Image.asset(
              'assets/bean.png',
              width: 14,
            ),
          ],
        ),
        subtitle: Text(
          DateTime.now()
              .toIso8601String()
              .replaceRange(19, null, '')
              .replaceFirst('T', ' '),
          style: const TextStyle(
            color: Colors.black38,
            fontSize: 12,
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:spinner_try/shivanshu/utils.dart';

class OutcomeScreen extends StatelessWidget {
  const OutcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) => ListTile(
        title: const Text('Krazy jungle bet'),
        subtitle: const Text('2023-12-05 22:59:20'),
        trailing: MyRow(
          children: [
            const Text('-1000'),
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

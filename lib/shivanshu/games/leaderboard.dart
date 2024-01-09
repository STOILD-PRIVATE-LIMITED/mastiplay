import 'package:flutter/material.dart';
import 'package:spinner_try/shivanshu/widgets/scroll_builder.dart';

class LeaderBoard extends StatelessWidget {
  final Future<List<dynamic>> Function(int start, dynamic lastItem) loader;
  const LeaderBoard({super.key, required this.loader});

  @override
  Widget build(BuildContext context) {
    return ScrollBuilder2(
      loader: loader,
      itemBuilder: (context, item) {
        return ListTile(
          leading: Text(item['rank'].toString()),
          title: Text(item['name']),
          trailing: Text(item['score'].toString()),
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:spinner_try/shivanshu/models/momets/post.dart';
import 'package:spinner_try/shivanshu/utils.dart';
import 'package:spinner_try/shivanshu/widgets/post_widget.dart';
import 'package:spinner_try/shivanshu/widgets/scroll_builder.dart';

class UserPosts extends StatelessWidget {
  final String userId;
  const UserPosts({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ScrollBuilder2<Post>(
          lastItem: Text(
            'No More Posts Left for You 😢',
            style: TextStyle(
                fontSize: height / 40,
                fontStyle: FontStyle.italic,
                color: Colors.black),
          ),
          loader: (start, lastPost) async {
            return await searchPost(null, 20, start, userId: userId);
          },
          separatorBuilder: (context, index) {
            return const Divider();
          },
          itemBuilder: (context, item) {
            // return Text(item.title);
            return PostWidget(
              post: item,
            );
          },
        ),
      ),
    );
  }
}

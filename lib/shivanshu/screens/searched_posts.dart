import 'package:flutter/material.dart';
import 'package:spinner_try/shivanshu/models/momets/post.dart';
import 'package:spinner_try/shivanshu/screens/family_room_page.dart';
import 'package:spinner_try/shivanshu/widgets/post_widget.dart';
import 'package:spinner_try/shivanshu/widgets/scroll_builder.dart';

class SearchedPosts extends StatelessWidget {
  final List<String> chosenTags;
  const SearchedPosts({super.key, required this.chosenTags});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const ElevatedBackButton(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: ScrollBuilder2(
          loader: (start, lastItem) async {
            return await searchPost(chosenTags, 20, start);
          },
          itemBuilder: (context, post) {
            return PostWidget(
              post: post,
              showTags: false,
            );
          },
        ),
      ),
    );
  }
}

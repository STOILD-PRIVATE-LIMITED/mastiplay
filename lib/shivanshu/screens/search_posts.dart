import 'package:flutter/material.dart';
import 'package:spinner_try/shivanshu/models/globals.dart';
import 'package:spinner_try/shivanshu/models/momets/post.dart';
import 'package:spinner_try/shivanshu/screens/family_room_page.dart';
import 'package:spinner_try/shivanshu/widgets/post_widget.dart';
import 'package:spinner_try/shivanshu/widgets/scroll_builder.dart';

class SearchPosts extends StatefulWidget {
  const SearchPosts({super.key});

  @override
  State<SearchPosts> createState() => _SearchPostsState();
}

class _SearchPostsState extends State<SearchPosts> {
  final TextEditingController _controller = TextEditingController();

  List<String> chosenTags = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const ElevatedBackButton(),
        // title: SearchBar(
        //   controller: _controller,
        //   onSubmitted: (value){

        //   },

        // ),
      ),
      body: Column(
        children: [
          // SelectMany(allOptions: allOptions, onChange: onChange),
          if (chosenTags.isEmpty)
            const Text('Start typing in the search box to search')
          else
            Expanded(
              child: ScrollBuilder2(
                loader: (start, lastItem) async {
                  return await searchPost(
                      currentUser.id, chosenTags, 20, start);
                },
                itemBuilder: (context, post) {
                  return PostWidget(post: post);
                },
              ),
            ),
        ],
      ),
    );
  }
}

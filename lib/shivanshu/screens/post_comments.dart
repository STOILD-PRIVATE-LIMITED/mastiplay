import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:spinner_try/shivanshu/models/momets/comment.dart';
import 'package:spinner_try/shivanshu/models/momets/post.dart';
import 'package:spinner_try/shivanshu/screens/family_room_page.dart';
import 'package:spinner_try/shivanshu/utils.dart';
import 'package:spinner_try/shivanshu/utils/loading_icon_button.dart';
import 'package:spinner_try/shivanshu/utils/profile_image.dart';
import 'package:spinner_try/shivanshu/widgets/scroll_builder.dart';
import 'package:spinner_try/user_model.dart';

class CommentsScreen extends StatefulWidget {
  const CommentsScreen({super.key, required this.post});

  final Post post;

  @override
  State<CommentsScreen> createState() => _CommentsScreenState();
}

class _CommentsScreenState extends State<CommentsScreen> {
  final _commentController = TextEditingController();

  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const ElevatedBackButton(),
        title: widget.post.description.isEmpty
            ? const Text('Post')
            : Text(
                widget.post.description,
                maxLines: 1,
                overflow: TextOverflow.fade,
              ),
      ),
      body: ScrollBuilder2(
        loader: (start, lastItem) async {
          log("Start: $start");
          final comments = await fetchComments(widget.post.postId, start, 10);
          return comments;
        },
        itemBuilder: (context, comment) {
          return FutureBuilder(
            future: fetchUserWithId(comment.userId),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(child: Text(snapshot.error.toString()));
              }
              if (snapshot.connectionState != ConnectionState.done) {
                return const Center(child: CircularProgressIndicatorRainbow());
              }
              final UserModel? user = snapshot.data;
              return ListTile(
                leading: SizedBox(
                  height: 50,
                  width: 50,
                  child: user == null
                      ? const Icon(Icons.person_rounded)
                      : ProfileImage(user: user),
                ),
                title: Text(comment.comment),
              );
            },
          );
        },
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom + 8,
          left: 8,
          right: 8,
        ),
        child: TextField(
          onSubmitted: _postComment,
          controller: _commentController,
          onChanged: (value) {
            setState(() {});
          },
          decoration: InputDecoration(
            suffixIcon: LoadingIconButton(
                loading: _loading == true ? true : null,
                enabled: _commentController.text.trim().isNotEmpty,
                onPressed: () async => _postComment(_commentController.text),
                icon: const Icon(Icons.send_rounded)),
            labelText: 'Enter Your Comment Here',
            hintText: "Awesome 🤘",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(100),
              borderSide: BorderSide(
                color: colorScheme(context).primary,
                width: 2,
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _postComment(String value) async {
    value = value.trim();
    if (value.isEmpty) return;
    setState(() {
      _loading = true;
    });
    try {
      await commentPost(widget.post, value);
    } catch (e) {
      if (context.mounted) {
        showMsg(context, e.toString());
      }
    }
    if (context.mounted) {
      setState(() {
        _loading = false;
      });
      Navigator.of(context).pop();
    }
  }
}

import 'package:flutter/material.dart';
import 'package:spinner_try/shivanshu/models/globals.dart';
import 'package:spinner_try/shivanshu/screens/family_room_page.dart';
import 'package:spinner_try/shivanshu/utils/profile_image.dart';
import 'package:spinner_try/shivanshu/widgets/scroll_builder.dart';
import 'package:spinner_try/user_model.dart';

class FollowingScreen extends StatelessWidget {
  const FollowingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const ElevatedBackButton(),
        title: const Text('Followers'),
      ),
      body: ScrollBuilder2(
        loader: (start, lastItem) {
          return fetchFollowingUsers(currentUser.id!, start, 20);
        },
        itemBuilder: (context, user) {
          return ListTile(
            onTap: () {
              showProfile(context, user);
            },
            leading: SizedBox(
              width: 56,
              height: 56,
              child: ProfileImage(user: user),
            ),
            title: Text(user.name),
            subtitle: Text(user.id.toString()),
          );
        },
      ),
    );
  }
}

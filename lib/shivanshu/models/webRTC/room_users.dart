import 'package:flutter/material.dart';
import 'package:spinner_try/shivanshu/models/globals.dart';
import 'package:spinner_try/shivanshu/utils/profile_image.dart';
import 'package:spinner_try/shivanshu/widgets/scroll_builder.dart';
import 'package:spinner_try/user_model.dart';

class RoomUsers extends StatelessWidget {
  final Future<List<UserModel>> Function(int start, UserModel? lastUser) loader;
  final void Function(UserModel user) onSelect;

  const RoomUsers({super.key, required this.loader, required this.onSelect});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lobby'),
      ),
      body: ScrollBuilder2(
        loader: loader,
        itemBuilder: (context, user) {
          return ListTile(
            onTap: () {
              onSelect(user);
              Navigator.pop(context);
            },
            leading: SizedBox(
              height: 50,
              width: 50,
              child: ProfileImage(user: user),
            ),
            title: Text(user.name),
            subtitle: Text(user.id ?? "No ID"),
            trailing: currentUser.id == user.id
                ? const Chip(
                    padding: EdgeInsets.zero,
                    label: Text(
                      'You',
                      style: TextStyle(color: Colors.black),
                    ),
                  )
                : null,
          );
        },
      ),
    );
  }
}

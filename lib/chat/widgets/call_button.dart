import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:spinner_try/chat/widgets/call_choser.dart';
import 'package:spinner_try/shivanshu/utils.dart';
import 'package:spinner_try/user_model.dart';
import 'package:url_launcher/url_launcher.dart';

class CallButton extends StatelessWidget {
  final List<String> ids;
  final Source? src;
  const CallButton({super.key, required this.ids, this.src});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: fetchUsers(ids),
      builder: (ctx, snapshot) {
        if (snapshot.hasError) {
          showMsg(context, snapshot.error.toString());
          return Container();
        }
        if (!snapshot.hasData) {
          Source anotherMethod = Source.cache;
          if (src != anotherMethod) {
            return CallButton(
              ids: ids,
              src: anotherMethod,
            );
          } else {
            return Container(); // Show Nothing
          }
        }
        List<UserModel> users = snapshot.data!;
        users.removeWhere((element) =>
            element.phoneNumber == null || element.phoneNumber!.isEmpty);
        if (users.isEmpty) {
          return Container();
        }
        return IconButton(
          icon: const Icon(Icons.call_rounded),
          onPressed: () async {
            if (users.length == 1) {
              final String url = "tel:${users[0].phoneNumber}";
              if (await askUser(context,
                      'Do you want to call ${users[0].name} (${users[0].phoneNumber})?',
                      yes: true, cancel: true) ==
                  'yes') {
                if (context.mounted) {
                  showMsg(context,
                      'Calling ${users[0].name} (${users[0].phoneNumber})');
                }
                await launchUrl(Uri.parse(url));
              }
            } else {
              await Navigator.of(context).push(
                DialogRoute(
                  context: context,
                  builder: (ctx) => CallChoser(users: users),
                ),
              );
            }
          },
        );
      },
    );
  }
}

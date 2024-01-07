import 'package:flutter/material.dart';
import 'package:spinner_try/chat/models/chat.dart';
import 'package:spinner_try/shivanshu/models/agency/agency.dart';
import 'package:spinner_try/shivanshu/screens/family_room_page.dart';
import 'package:spinner_try/shivanshu/utils/profile_image.dart';
import 'package:spinner_try/shivanshu/widgets/scroll_builder.dart';
import 'package:spinner_try/user_model.dart';

class CreatorsList extends StatelessWidget {
  final UserModel user;
  const CreatorsList({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const ElevatedBackButton(),
        title: const Text('Your Creators '),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: ScrollBuilder2(
          separatorBuilder: (context, index) => const SizedBox(height: 10),
          loader: (start, lastItem) {
            return getAgencyParticipants(user.ownedAgencyData!.id!, start, 20);
          },
          itemBuilder: (context, user) => CreatorTile(user: user),
        ),
      ),
    );
  }
}

class CreatorTile extends StatelessWidget {
  final UserModel user;
  const CreatorTile({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 3.0,
            offset: Offset(0, 0),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            contentPadding: const EdgeInsets.all(0),
            trailing: IconButton.filled(
              onPressed: () async {
                await showChatWithUserId(user.id!, context);
              },
              style: IconButton.styleFrom(
                backgroundColor: Colors.amber,
                foregroundColor: Colors.white,
                iconSize: 15,
              ),
              icon: const Icon(Icons.chat_rounded),
            ),
            leading: SizedBox(
              width: 56,
              height: 56,
              child: ProfileImage(user: user),
            ),
            title: Text(user.name),
            isThreeLine: true,
            subtitle: const Wrap(
              children: [
                Icon(
                  Icons.attach_money_outlined,
                  size: 14,
                  color: Colors.amber,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:spinner_try/chat/models/chat.dart';
import 'package:spinner_try/chat/screens/chat_screen.dart';
import 'package:spinner_try/chat/screens/image_preview.dart';
import 'package:spinner_try/shivanshu/models/globals.dart';
import 'package:spinner_try/shivanshu/utils.dart';
import 'package:spinner_try/shivanshu/utils/loading_icon_button.dart';
import 'package:spinner_try/user_model.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfilePreview extends StatelessWidget {
  final UserModel user;
  final bool showChatButton, showCallButton, showMailButton, showDetailsPage;
  const ProfilePreview({
    super.key,
    required this.user,
    this.showChatButton = true,
    this.showCallButton = true,
    this.showMailButton = true,
    this.showDetailsPage = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
            if (user.photo.isNotEmpty) {
              navigatorPush(
                context,
                ImagePreview(
                  image: Hero(
                    tag: 'profile-image',
                    child: CachedNetworkImage(imageUrl: user.photo),
                  ),
                ),
              );
            }
          },
          child: Hero(
            tag: 'profile-image',
            child: CircleAvatar(
              backgroundImage: user.photo.isEmpty
                  ? null
                  : CachedNetworkImageProvider(user.photo),
              radius: 50,
              child: user.photo.isNotEmpty
                  ? null
                  : const Icon(
                      Icons.person_rounded,
                      size: 50,
                    ),
            ),
          ),
        ),
        InkWell(
          onTap: showDetailsPage
              ? () => showMsg(context, "TODO: Profile Details Screen")
              // navigatorPush(context, ProfileDetailsScreen(user: user))
              : null,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    shaderText(
                      context,
                      title: user.name.isNotEmpty
                          ? user.name
                          : user.email.split('@')[0],
                      colors: [
                        Colors.deepPurpleAccent,
                        Colors.indigo,
                        Colors.blue,
                      ],
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    Text(
                      user.email,
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        Wrap(
          alignment: WrapAlignment.spaceAround,
          children: [
            if (showChatButton)
              LoadingIconButton(
                onPressed: () async {
                  final chat = await createChat(
                    ChatData(
                      id: "-1",
                      admins: [currentUser.id!, user.id!],
                      participants: [currentUser.id!, user.id!],
                      title: "New Chat",
                    ),
                  );
                  if (context.mounted) {
                    navigatorPush(
                      context,
                      ChatScreen(chat: chat),
                    );
                  }
                },
                icon: const Icon(Icons.chat_rounded),
              ),
            if (showCallButton)
              if (user.phoneNumber != null)
                IconButton(
                  onPressed: () {
                    launchUrl(Uri.parse('tel:${user.phoneNumber}'));
                  },
                  icon: const Icon(Icons.call_rounded),
                ),
            if (showMailButton)
              IconButton(
                onPressed: () {
                  launchUrl(Uri.parse('mailto:${user.email}'));
                },
                icon: const Icon(Icons.mail_rounded),
              ),
          ],
        ),
      ],
    );
  }
}

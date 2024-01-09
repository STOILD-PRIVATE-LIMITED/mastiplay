import 'dart:math';

import 'package:flutter/material.dart';
import 'package:spinner_try/chat/models/chat.dart';
import 'package:spinner_try/chat/screens/chat_screen.dart';
import 'package:spinner_try/shivanshu/models/globals.dart';
import 'package:spinner_try/shivanshu/utils.dart';
import 'package:spinner_try/shivanshu/utils/loading_icon_button.dart';
import 'package:spinner_try/shivanshu/utils/profile_image.dart';
import 'package:spinner_try/shivanshu/widgets/imgae_preview.dart';
import 'package:spinner_try/user_model.dart';

class MessageScreen extends StatelessWidget {
  const MessageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Messages'),
        centerTitle: true,
      ),
      body: FutureBuilder(
          future: fetchAllChats(currentUser.id!),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicatorRainbow(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text(
                  snapshot.error.toString(),
                  style: textTheme(context).bodyLarge!.copyWith(
                        color: colorScheme(context).error,
                      ),
                ),
              );
            }
            List<ChatData> chats = snapshot.data!;
            chats = chats.reversed.toList();
            return ListView.builder(
              itemCount: chats.length,
              itemBuilder: (context, index) {
                final chatData = chats[index];
                return ListTile(
                  onTap: () {
                    navigatorPush(
                        context,
                        ChatScreen(
                          chat: chatData,
                        ));
                  },
                  title: Text(
                    chatData.title,
                    style: textTheme(context).bodyLarge!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  subtitle: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (chatData.description.isNotEmpty)
                        Text(chatData.description),
                      Text(chatData.participants.join(", ")),
                    ],
                  ),
                  leading: FutureBuilder(
                    future: fetchUserWithId(chatData.participants[0]),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicatorRainbow();
                      } else if (snapshot.hasError) {
                        return const Icon(Icons.error_outline_rounded);
                      }
                      return SizedBox(
                        width: 40,
                        height: 40,
                        child: ProfileImage(
                          user: snapshot.data!,
                          onTap: (user) {
                            navigatorPush(
                              context,
                              ImagePreview(
                                image: ProfileImage(
                                  user: snapshot.data!,
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
                  trailing: [
                    const Icon(
                      Icons.heart_broken,
                      color: Colors.red,
                      size: 14,
                    ),
                    CircleAvatar(
                      radius: 7,
                      backgroundColor: Colors.red,
                      child: Text(
                        Random().nextInt(10).toString(),
                        style: textTheme(context).bodySmall!.copyWith(
                              fontSize: 7,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ),
                    const CircleAvatar(
                      radius: 4,
                      backgroundColor: Colors.red,
                    ),
                  ][index % 3],
                );
              },
            );
          }),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 200.0),
        child: LoadingIconButton(
          style: IconButton.styleFrom(
            backgroundColor: colorScheme(context).primaryContainer,
            foregroundColor: colorScheme(context).onPrimaryContainer,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            minimumSize: const Size(40, 40),
          ),
          onPressed: () async {
            String? id = await promptUser(context,
                question: "Enter the id of the recepient");
            id = id?.trim();
            if (id == null || id.isEmpty) {
              return;
            }
            final chatData = await createChat(ChatData(
              id: "-1",
              admins: [currentUser.id!, id],
              participants: [currentUser.id!, id],
              title: "New Chat",
            ));
            if (context.mounted) {
              navigatorPush(
                context,
                ChatScreen(
                  chat: chatData,
                ),
              );
            }
          },
          icon: const Icon(Icons.add_rounded),
        ),
      ),
    );
  }
}

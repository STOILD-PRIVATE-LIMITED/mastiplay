import 'dart:math';

import 'package:flutter/material.dart';
import 'package:spinner_try/chat/models/chat.dart';
import 'package:spinner_try/shivanshu/models/globals.dart';
import 'package:spinner_try/shivanshu/utils.dart';
import 'package:spinner_try/shivanshu/widgets/imgae_preview.dart';

class MessageScreen extends StatelessWidget {
  const MessageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final imgUrls = [
      'https://static.vecteezy.com/system/resources/previews/028/853/913/non_2x/young-indian-man-black-white-cartoon-avatar-icon-brunette-short-hair-editable-2d-character-user-portrait-linear-flat-illustration-face-profile-outline-person-head-and-shoulders-vector.jpg',
      'https://static.vecteezy.com/system/resources/previews/028/595/343/non_2x/brunette-asian-woman-black-white-cartoon-avatar-icon-long-hair-pretty-face-editable-2d-character-user-portrait-linear-flat-illustration-face-profile-outline-person-head-and-shoulders-vector.jpg',
      'https://static.vecteezy.com/system/resources/previews/029/773/746/non_2x/low-bun-hairstyle-elderly-woman-smirking-black-and-white-2d-avatar-illustration-senior-indian-woman-outline-cartoon-character-face-isolated-flat-user-profile-image-portrait-female-vector.jpg',
      'https://static.vecteezy.com/system/resources/previews/023/558/341/non_2x/phone-user-disconnected-from-network-bw-spot-illustration-girl-with-phone-problem-2d-cartoon-flat-line-monochromatic-character-on-white-for-web-ui-design-editable-isolated-outline-hero-image-vector.jpg',
    ];
    return Scaffold(
      appBar: AppBar(
        title: const Text('Messages'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return ListTile(
            onTap: () {
              showMsg(context, index.toString());
            },
            title: Text(
              'Stranger Messages',
              style: textTheme(context).bodyLarge!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            subtitle: const Text('Hehe, bfdkc dsjk kj'),
            leading: Stack(
              alignment: Alignment.bottomRight,
              children: [
                InkWell(
                  onTap: () {
                    navigatorPush(
                        context,
                        ImagePreview(
                            image: Hero(
                          tag: imgUrls[index % imgUrls.length] +
                              index.toString(),
                          child: Image.network(imgUrls[index % imgUrls.length]),
                        )));
                  },
                  child: Hero(
                    tag: imgUrls[index % imgUrls.length] + index.toString(),
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(
                        imgUrls[index % imgUrls.length],
                      ),
                    ),
                  ),
                ),
                const CircleAvatar(
                  radius: 8,
                  backgroundColor: Color.fromARGB(255, 252, 239, 22),
                  child: Icon(
                    Icons.network_cell_rounded,
                    size: 10,
                  ),
                ),
              ],
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
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 200.0),
        child: FloatingActionButton(
          onPressed: () async {
            String? email = await promptUser(context,
                question: "Enter the email address of recepient");
            email = email?.trim();
            if (email == null || email.isEmpty) {
              return;
            }
            createChat(ChatData(
              admins: [],
              receivers: [currentUser.email, email],
              title: "Chat1",
              id: "0",
            ));
          },
          child: const Icon(Icons.add_rounded),
        ),
      ),
    );
  }
}

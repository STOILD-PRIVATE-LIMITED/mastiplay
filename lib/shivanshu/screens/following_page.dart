import 'dart:math';

import 'package:flutter/material.dart';
import 'package:spinner_try/shivanshu/utils.dart';
import 'package:spinner_try/shivanshu/widgets/imgae_preview.dart';

class FollowingPage extends StatelessWidget {
  const FollowingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final imgUrls = [
      'https://stoild.in/wp-content/uploads/2023/05/re2.png',
      'https://stoild.in/wp-content/uploads/2023/05/reviews1-e1683543553269-300x291-1.png',
      'https://stoild.in/wp-content/uploads/2023/05/reviews.png',
    ];
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(55.0),
        child: AppBar(
          centerTitle: true,
          title: Text(
            "Following",
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
          ),
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            style: IconButton.styleFrom(
                elevation: 5,
                shadowColor: Colors.black,
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                )),
            icon: const Icon(Icons.keyboard_arrow_left_rounded),
          ),
        ),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) => ListTile(
          onTap: () {
            showMsg(context, index.toString());
          },
          title: const Text('Hehe'),
          subtitle: const Text('Hehe'),
          leading: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Stack(
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
                            child:
                                Image.network(imgUrls[index % imgUrls.length]),
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
              const SizedBox(
                width: 10,
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Friend',
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 5),
                  InkWell(
                    onTap: () {
                      showMsg(context, 'CHAT');
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.chat,
                          size: 15,
                        ),
                        const SizedBox(width: 2),
                        Text(
                          'Chat',
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(
                                color: const Color.fromARGB(255, 12, 140, 233),
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.person_rounded,
                color: Colors.black38,
                size: 14,
              ),
              const SizedBox(width: 3),
              Text(
                Random().nextInt(100).toString(),
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: Colors.black38,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_octicons/flutter_octicons.dart';
import 'package:spinner_try/chat/screens/image_preview.dart';
import 'package:spinner_try/chat/widgets/message.dart';
import 'package:spinner_try/shivanshu/models/globals.dart';
import 'package:spinner_try/shivanshu/models/momets/post.dart';
import 'package:spinner_try/shivanshu/utils.dart';
import 'package:spinner_try/shivanshu/utils/loading_icon_button.dart';
import 'package:spinner_try/shivanshu/utils/profile_image.dart';
import 'package:spinner_try/user_model.dart';
import 'package:url_launcher/url_launcher.dart';

class PostWidget extends StatelessWidget {
  final Post post;
  const PostWidget({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        FutureBuilder(
            future: fetchUserWithId(post.postedBy),
            builder: (context, snapshot) {
              final UserModel? user = snapshot.data;
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        (snapshot.connectionState == ConnectionState.waiting)
                            ? const CircularProgressIndicatorRainbow()
                            : SizedBox(
                                height: 56,
                                width: 56,
                                child: snapshot.hasError || !snapshot.hasData
                                    ? const Icon(Icons.error, color: Colors.red)
                                    : ProfileImage(user: snapshot.data!),
                              ),
                        SizedBox(
                          width: width / 30,
                        ),
                        Expanded(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                post.title.isNotEmpty
                                    ? post.title
                                    : (user?.name ?? "Error"),
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: height / 45, color: Colors.black),
                              ),
                              Text(
                                ddmmyyyy(post.updatedAt.toLocal()),
                                style: TextStyle(
                                    fontSize: height / 55, color: Colors.grey),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (user != null && user.id! != currentUser.id)
                        OutlinedButton.icon(
                          onPressed: () async {
                            await followUser(user.id!);
                          },
                          icon: const Icon(Icons.person_add_rounded),
                          label: const Text('Follow'),
                        ),
                      // Container(
                      //   height: height / 20,
                      //   width: width / 5,
                      //   decoration: BoxDecoration(
                      //     borderRadius: BorderRadius.circular(30),
                      //     border: Border.all(color: Colors.yellow),
                      //   ),
                      //   alignment: Alignment.center,
                      //   child: Row(
                      //     mainAxisAlignment: MainAxisAlignment.center,
                      //     children: [
                      //       Icon(
                      //         Icons.person_add,
                      //         color: Colors.yellow,
                      //         size: height / 50,
                      //       ),
                      //       Text(
                      //         'Follow',
                      //         style: TextStyle(
                      //             fontSize: height / 60, color: Colors.yellow),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      SizedBox(
                        width: width / 30,
                      ),
                      const Icon(
                        Icons.more_vert,
                        color: Colors.grey,
                      )
                    ],
                  ),
                ],
              );
            }
            //  CircleAvatar(
            //   radius: height / 30,
            //   backgroundImage:
            //       snapshot.hasData && snapshot.data!.photo.isNotEmpty
            //           ? NetworkImage(
            //               snapshot.data!.photo,
            //             )
            //           : const AssetImage('assets/dummy_person.png')
            //               as ImageProvider,
            //   child: snapshot.hasError
            //       ? const Icon(Icons.error, color: Colors.red)
            //       : null,
            // ),
            ),
        if (post.imgUrl != null)
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ImagePreview(
                    image: Hero(
                      tag: post.postId.toString(),
                      child: Image.network(
                        post.imgUrl!,
                      ),
                    ),
                  ),
                ),
              );
            },
            child: Container(
              height: height / 2.8,
              width: width,
              // alignment: Alignment.center,
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: const Color(0xFFE2FBF5),
              ),
              child: Hero(
                tag: post.postId.toString(),
                child: Image.network(
                  post.imgUrl!,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        const SizedBox(height: 15),
        MarkdownBody(
          fitContent: true,
          data: post.description,
          selectable: true,
          onTapLink: (text, href, title) {
            if (href != null) launchUrl(Uri.parse(href));
          },
          imageBuilder: (uri, title, alt) =>
              ImageBuilder(uri: uri, id: post.postId),
        ),
        // Align(
        //   alignment: Alignment.centerLeft,
        //   child: Container(
        //     height: height / 40,
        //     width: width / 5,
        //     padding: EdgeInsets.only(left: width / 30),
        //     decoration: BoxDecoration(
        //       color: const Color(0xFFf0f9fc),
        //       borderRadius: BorderRadius.circular(40),
        //     ),
        //     alignment: Alignment.center,
        //     child: Row(
        //       children: [
        //         Icon(
        //           Icons.ac_unit,
        //           color: Colors.yellow,
        //           size: height / 50,
        //         ),
        //         SizedBox(
        //           width: width / 60,
        //         ),
        //         Text(
        //           'HOT',
        //           style: TextStyle(fontSize: height / 60, color: Colors.grey),
        //         ),
        //       ],
        //     ),
        //   ),
        // ),
        // SizedBox(
        //   height: height / 40,
        // ),
        Row(
          children: [
            TextButton.icon(
              icon: const Icon(OctIcons.thumbsup_16),
              label: const Text("1.5k"),
              onPressed: () {},
            ),
            SizedBox(
              width: width / 40,
            ),
            const SizedBox(
              width: 10,
            ),
            TextButton.icon(
              icon: const Icon(Icons.comment),
              label: const Text("1.5k"),
              onPressed: () {},
            ),
            SizedBox(
              width: width / 40,
            ),
            SizedBox(
              width: width / 40,
            ),
            LoadingIconButton(
              icon: const Icon(Icons.share),
              onPressed: () async {
                await shareLink(
                    "https://mastiplay.com/posts/${post.postId.toString()}",
                    "See my wonderful post 👇");
                await sharePost(post.postId);
              },
            ),
          ],
        )
      ],
    );
  }
}

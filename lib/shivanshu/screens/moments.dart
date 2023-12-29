import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:spinner_try/screen/share_moments.dart';
import 'package:spinner_try/shivanshu/models/globals.dart';
import 'package:spinner_try/shivanshu/models/momets/post.dart';
import 'package:spinner_try/shivanshu/utils.dart';
import 'package:spinner_try/shivanshu/widgets/post_widget.dart';
import 'package:spinner_try/shivanshu/widgets/scroll_builder.dart';

class Moments extends StatefulWidget {
  const Moments({super.key});

  @override
  State<Moments> createState() => _MomentsState();
}

class _MomentsState extends State<Moments> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      floatingActionButton: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(bottom: 100.sp),
            child: FloatingActionButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditPost(
                      post: Post(
                        postedBy: currentUser.id!,
                      ),
                      onPost: (post) async {
                        await postPost(post);
                      },
                    ),
                  ),
                );
              },
              child: const Icon(
                Icons.camera,
                color: Colors.black,
              ),
            ),
          ),
        ),
      ),
      body: Padding(
        padding:
            EdgeInsets.symmetric(vertical: height / 20, horizontal: width / 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Text(
                      'Moments',
                      style: TextStyle(
                          fontSize: height / 30,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: height / 25),
                      height: height / 200,
                      width: width / 4,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: const Color(0xFFE05DD3),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: height / 30,
                  child: Row(
                    children: [
                      Image.asset('assets/Tick-Square.png'),
                      SizedBox(
                        width: width / 30,
                      ),
                      Image.asset('assets/Notifications.png'),
                    ],
                  ),
                )
              ],
            ),
            SizedBox(
              height: height / 40,
            ),
            Container(
              width: width,
              height: height / 15,
              decoration: const BoxDecoration(
                color: Color(0xFFE2FBF5),
              ),
              padding: EdgeInsets.only(left: width / 30),
              alignment: Alignment.centerLeft,
              child: Text("#mastiplay official",
                  style: TextStyle(
                      fontSize: height / 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.black)),
            ),
            SizedBox(
              height: height / 40,
            ),
            Row(
              children: [
                Container(
                  height: height / 20,
                  width: width / 3,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: const Color(0xFFE05DD3),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '🔥Hot',
                        style: TextStyle(
                            fontSize: height / 45,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: width / 30,
                ),
                Container(
                  height: height / 20,
                  width: width / 3,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: const Color(0xFFE7E4E0),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '⌛Recent',
                        style: TextStyle(
                            fontSize: height / 45,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: height / 40,
            ),
            Expanded(
              child: ScrollBuilder2<Post>(
                footer: Text(
                  'No More Posts Left for You 😢',
                  style: TextStyle(
                      fontSize: height / 40,
                      fontStyle: FontStyle.italic,
                      color: Colors.black),
                ),
                loader: (start, lastPost) async {
                  log("$start");
                  return await getHotPosts(20, start);
                },
                itemBuilder: (context, item) {
                  // return Text(item.title);
                  return PostWidget(
                    post: item,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

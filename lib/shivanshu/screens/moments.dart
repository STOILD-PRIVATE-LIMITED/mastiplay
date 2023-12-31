import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:spinner_try/screen/share_moments.dart';
import 'package:spinner_try/shivanshu/models/globals.dart';
import 'package:spinner_try/shivanshu/models/momets/post.dart';
import 'package:spinner_try/shivanshu/screens/search_posts.dart';
import 'package:spinner_try/shivanshu/utils.dart';
import 'package:spinner_try/shivanshu/widgets/post_widget.dart';
import 'package:spinner_try/shivanshu/widgets/scroll_builder.dart';
import 'package:spinner_try/shivanshu/widgets/tab_view.dart';

class Moments extends StatefulWidget {
  const Moments({super.key});

  @override
  State<Moments> createState() => _MomentsState();
}

class _MomentsState extends State<Moments> {
  bool recent = false;

  final _pageView = PageController();

  int _selectedPage = 0;
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
            SizedBox(
              height: 56,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TabView(
                    defaultSelected: _selectedPage,
                    key: UniqueKey(),
                    items: [
                      Text(
                        'Moments',
                        style: TextStyle(
                          fontSize: height / 50,
                          fontWeight: FontWeight.bold,
                          // letterSpacing: 2,
                          color: Colors.grey,
                        ),
                      ),
                      Text(
                        'Following',
                        style: TextStyle(
                          fontSize: height / 50,
                          fontWeight: FontWeight.bold,
                          // letterSpacing: 2,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                    selectedItems: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Moments',
                            style: TextStyle(
                                fontSize: height / 30,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 2),
                          ),
                        ],
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Following',
                            style: TextStyle(
                                fontSize: height / 30,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 2),
                          ),
                        ],
                      ),
                    ],
                    onTap: (index) {
                      _pageView.animateToPage(
                        index,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    },
                  ),
                  SizedBox(
                    height: height / 30,
                    child: Row(
                      children: [
                        InkWell(
                          child: Image.asset('assets/Tick-Square.png'),
                          onTap: () {
                            navigatorPush(context, const SearchPosts());
                          },
                        ),
                        SizedBox(
                          width: width / 30,
                        ),
                        Image.asset('assets/Notifications.png'),
                      ],
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: height / 40,
            ),
            Expanded(
              child: PageView(
                controller: _pageView,
                onPageChanged: (value) {
                  setState(() {
                    _selectedPage = value;
                  });
                },
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
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
                            clipBehavior: Clip.hardEdge,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: Color(recent ? 0xFFE7E4E0 : 0xFFE05DD3),
                            ),
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  recent = false;
                                });
                              },
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
                          ),
                          SizedBox(
                            width: width / 30,
                          ),
                          Container(
                            height: height / 20,
                            width: width / 3,
                            clipBehavior: Clip.hardEdge,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: Color(!recent ? 0xFFE7E4E0 : 0xFFE05DD3),
                            ),
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  recent = true;
                                });
                              },
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
                          ),
                        ],
                      ),
                      SizedBox(
                        height: height / 40,
                      ),
                      Expanded(
                        child: ScrollBuilder2<Post>(
                          key: ValueKey("ScrollBuilder2$recent"),
                          lastItem: Text(
                            'No More Posts Left for You 😢',
                            style: TextStyle(
                                fontSize: height / 40,
                                fontStyle: FontStyle.italic,
                                color: Colors.black),
                          ),
                          loader: (start, lastPost) async {
                            log("$start");
                            if (recent) {
                              return await getRecentPost(20, start);
                            } else {
                              return await getHotPosts(20, start);
                            }
                          },
                          separatorBuilder: (context, index) {
                            return const Divider();
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
                  ScrollBuilder2<Post>(
                    lastItem: Text(
                      'No More Posts Left for You 😢',
                      style: TextStyle(
                          fontSize: height / 40,
                          fontStyle: FontStyle.italic,
                          color: Colors.black),
                    ),
                    loader: (start, lastPost) async {
                      log("Following: $start");
                      return await getFollowingPost(20, start);
                    },
                    separatorBuilder: (context, index) {
                      return const Divider();
                    },
                    itemBuilder: (context, item) => PostWidget(post: item),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

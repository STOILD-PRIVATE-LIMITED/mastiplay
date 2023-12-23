import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:spinner_try/shivanshu/models/firestore/firestore_document.dart';
import 'package:spinner_try/shivanshu/models/globals.dart';
import 'package:spinner_try/shivanshu/models/room.dart';
import 'package:spinner_try/shivanshu/screens/audio_page.dart';
import 'package:spinner_try/shivanshu/screens/home_page.dart';
import 'package:spinner_try/shivanshu/utils.dart';
import 'package:spinner_try/shivanshu/widgets/scroll_builder.dart';
import 'package:spinner_try/webRTC/video_room.dart';

class AudioLive extends StatefulWidget {
  const AudioLive({
    super.key,
    required this.tabs,
    required this.widget,
    required this.mediaQuery,
    required this.height,
    required this.width,
  });

  final List<String> tabs;
  final HomePage widget;
  final MediaQueryData mediaQuery;
  final double height;
  final double width;

  @override
  State<AudioLive> createState() => _AudioLiveState();
}

class _AudioLiveState extends State<AudioLive> {
  String? lastUpdatedAt;

  @override
  Widget build(BuildContext context) {
    /*return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: () {
                // navigatorPush(context, CameraScreen());
              },
              child: Card(
                color: const Color.fromARGB(255, 224, 93, 211),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(right: 1.0),
                        child: Icon(
                          Icons.star_rounded,
                          color: Colors.amber,
                          size: 12,
                        ),
                      ),
                      Text(
                        tabs[widget.selectedTab],
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              color: Theme.of(context).colorScheme.onPrimary,
                              fontSize: 10,
                            ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                showMsg(context, 'Hehe');
              },
              child: Container(
                width: mediaQuery.size.width,
                height: 100,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 192, 105, 105),
                  borderRadius: BorderRadius.circular(10),
                  image: const DecorationImage(
                    image: AssetImage('assets/banner.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: height / 2.3,
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 2,
                  mainAxisSpacing: 2,
                ),
                itemCount: 4,
                itemBuilder: (context, index) {
                  return Container(
                    decoration: BoxDecoration(boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(.1),
                        blurRadius: 2,
                      ),
                    ]),
                    child: Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.black12,
                                width: 1,
                              ),
                              color: Colors.white),
                          child: Image.asset(
                            "assets/mohtarma.png",
                            filterQuality: FilterQuality.high,
                            fit: BoxFit.cover,
                            height: height / 5,
                          ),
                        ),
                        Positioned(
                          left: width / 3.3,
                          top: height / 80,
                          child: Text(
                            "00:00",
                            style: TextStyle(
                              fontSize: height / 75,
                              color: const Color(0xFFE05DD3),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: height / 18,
                          left: width / 50,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 5,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              gradient: LinearGradient(
                                begin: AlignmentDirectional.centerStart,
                                end: AlignmentDirectional.centerEnd,
                                colors: [
                                  const Color(0xFFE05DD3).withOpacity(.7),
                                  const Color(0xFFE05DD3).withOpacity(.7),
                                ],
                              ),
                            ),
                            child: Text(
                              "Live",
                              style: TextStyle(
                                fontSize: height / 80,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: height / 25,
                          left: width / 6,
                          child: Text(
                            "Name",
                            style: TextStyle(
                              fontSize: height / 70,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: height / 50,
                          left: width / 30,
                          child: Row(
                            children: [
                              Image.asset(
                                'assets/Home_white.png',
                                height: height / 80,
                              ),
                              SizedBox(
                                width: width / 40,
                              ),
                              Text(
                                "Agent",
                                style: TextStyle(
                                    fontSize: height / 80, color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                        // Positioned(child: child),
                      ],
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 10),
            InkWell(
              onTap: () {
                showMsg(context, 'Hehe');
              },
              child: Container(
                width: mediaQuery.size.width,
                height: 100,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 192, 105, 105),
                  borderRadius: BorderRadius.circular(10),
                  image: const DecorationImage(
                    image: AssetImage('assets/banner.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 150,
            ),
          ],
        ),
      ),
    );
  */
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          if (context.mounted) {
            setState(() {});
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ScrollBuilder(
            key: UniqueKey(),
            interval: 4,
            automaticLoading: true,
            loader: (context, start, interval) async {
              Query<Map<String, dynamic>> query =
                  firestore.collection("rooms/");
              query = query.orderBy('updatedAt', descending: true);
              query = query.where('roomType', isEqualTo: RoomType.audio.index);
              if (lastUpdatedAt != null) {
                query = query.startAfter([lastUpdatedAt]);
              }
              query = query.limit(4);

              final value = await query.get();
              final docs = value.docs
                  .map((e) => FirestoreDocument(
                      id: e.id,
                      data: e.data(),
                      path: "rooms/${e.id}",
                      updatedAt: DateTime.tryParse(
                        e.data()['updatedAt'],
                      )))
                  .toList();
              log("lastDoc=$lastUpdatedAt");
              final List<Room> rooms = docs
                  .map((e) => Room(roomType: RoomType.audio)
                    ..loadFromJson(e.data..addAll({'id': e.id.toString()})))
                  .toList();
              if (docs.isNotEmpty) {
                lastUpdatedAt = rooms.last.updatedAt.toIso8601String();
              } else {
                lastUpdatedAt = null;
              }
              return [
                InkWell(
                  onTap: () {
                    showMsg(context, 'Hehe');
                  },
                  child: Container(
                    width: widget.mediaQuery.size.width,
                    height: 100,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 192, 105, 105),
                      borderRadius: BorderRadius.circular(10),
                      image: const DecorationImage(
                        image: AssetImage('assets/banner.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                if (rooms.isNotEmpty)
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 2,
                      mainAxisSpacing: 2,
                    ),
                    itemCount: rooms.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          navigatorPush(
                              context,
                              rooms[index].roomType == RoomType.audio
                                  ? AudioPage(
                                      room: rooms[index],
                                    )
                                  : VideoRoom(
                                      room: rooms[index],
                                    ));
                        },
                        child: Stack(
                          children: [
                            Positioned.fill(
                              child: Container(
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(.1),
                                      blurRadius: 2,
                                    ),
                                  ],
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                clipBehavior: Clip.hardEdge,
                                child: rooms[index].imgUrl == null
                                    ? Image.asset(
                                        'assets/dummy_person.png',
                                        fit: BoxFit.cover,
                                      )
                                    : Image.network(
                                        rooms[index].imgUrl!,
                                        fit: BoxFit.cover,
                                      ),
                              ),
                            ),
                            Positioned(
                              right: 10.sp,
                              top: widget.height / 80,
                              child: Timer(
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                                startTime: rooms[index].updatedAt,
                              ),
                            ),
                            Positioned(
                              bottom: widget.height / 18,
                              left: widget.width / 50,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 5,
                                ),
                                clipBehavior: Clip.hardEdge,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  gradient: LinearGradient(
                                    begin: AlignmentDirectional.centerStart,
                                    end: AlignmentDirectional.centerEnd,
                                    colors: [
                                      const Color(0xFFE05DD3).withOpacity(.7),
                                      const Color(0xFFE05DD3).withOpacity(.7),
                                    ],
                                  ),
                                ),
                                child: Text(
                                  "Live",
                                  style: TextStyle(
                                    fontSize: widget.height / 80,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            // Positioned(
                            //   bottom: widget.height / 25,
                            //   left: widget.width / 6,
                            //   child: Text(
                            //     rooms[index].admin!,
                            //     style: TextStyle(
                            //       fontSize: widget.height / 70,
                            //       color: Colors.black,
                            //       fontWeight: FontWeight.bold,
                            //     ),
                            //   ),
                            // ),
                            Positioned(
                              bottom: widget.height / 50,
                              left: widget.width / 30,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 5,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.black38,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Row(
                                  children: [
                                    Image.asset(
                                      'assets/Home_white.png',
                                      height: widget.height / 70,
                                    ),
                                    SizedBox(
                                      width: widget.width / 40,
                                    ),
                                    Text(
                                      rooms[index].name.toPascalCase(),
                                      overflow: TextOverflow.fade,
                                      style: TextStyle(
                                          fontSize: widget.height / 80,
                                          color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                const SizedBox(height: 10),
              ];
            },
          ),
        ),
      ),
    );
  }
}

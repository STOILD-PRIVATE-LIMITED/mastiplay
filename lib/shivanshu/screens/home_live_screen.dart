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

class HomeLive extends StatefulWidget {
  const HomeLive({
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
  State<HomeLive> createState() => _HomeLiveState();
}

class _HomeLiveState extends State<HomeLive> {
  String? lastUpdatedAt;
  int refreshCount = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          if (context.mounted) {
            setState(() {
              refreshCount++;
            });
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ScrollBuilder(
            key: ValueKey('home_live$refreshCount'),
            interval: 4,
            automaticLoading: true,
            loader: (context, start, interval) async {
              Query<Map<String, dynamic>> query =
                  firestore.collection("rooms/");
              query = query.orderBy('updatedAt', descending: true);
              query = query.where('roomType', isEqualTo: RoomType.video.index);
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
              final List<Room> rooms = docs
                  .map((e) => Room(roomType: RoomType.video)
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
                    height: 100.sp,
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
              ];
            },
          ),
        ),
      ),
    );
  }
}

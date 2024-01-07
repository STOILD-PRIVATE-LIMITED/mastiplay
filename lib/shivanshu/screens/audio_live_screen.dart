import 'package:flutter/material.dart';
import 'package:spinner_try/shivanshu/models/room.dart';
import 'package:spinner_try/shivanshu/models/webRTC/new_audio_room.dart';
import 'package:spinner_try/shivanshu/screens/home_page.dart';
import 'package:spinner_try/shivanshu/utils.dart';
import 'package:spinner_try/shivanshu/widgets/scroll_builder.dart';
import 'package:spinner_try/webRTC/video_room.dart';

import 'audio_page.dart';

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
          child: ScrollBuilder2<List<Room>>(
            key: ValueKey("audioLive$refreshCount"),
            loader: (start, lastRoom) async {
              final rooms = await getAllRooms(4, start);
              return rooms.isEmpty ? [] : [rooms];
            },
            itemBuilder: (context, rooms) {
              return Column(mainAxisSize: MainAxisSize.min, children: [
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
              ]);
            },
          ),
        ),
      ),
    );
  }
}

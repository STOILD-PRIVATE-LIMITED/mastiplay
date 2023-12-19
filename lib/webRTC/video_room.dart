import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:spinner_try/screen/audio_go.dart';
import 'package:spinner_try/shivanshu/models/globals.dart';
import 'package:spinner_try/shivanshu/models/room.dart';
import 'package:spinner_try/shivanshu/screens/audio_page.dart';
import 'package:spinner_try/shivanshu/utils.dart';
import 'package:spinner_try/webRTC/web_rtc.dart';

class VideoRoom extends StatelessWidget {
  final Room room;
  final String? url;
  const VideoRoom({super.key, required this.room, this.url});

  @override
  Widget build(BuildContext context) {
    final iAmAdmin = room.admin == auth.currentUser!.email!;
    return WebRTCWidget(
      onExit: () async {
        if (room.admin == auth.currentUser!.email) {
          if (await askUser(context, 'Do you want to delete the room as well?',
                  no: true,
                  custom: {
                    "delete": const Icon(
                      Icons.delete_forever_rounded,
                      color: Colors.red,
                    )
                  }) ==
              'yes') {
            await room.delete();
          }
        }
      },
      controller: WebRtcController(
        video: iAmAdmin,
        audio: true,
      ),
      userData: currentUser.toJson()
        ..addAll({'photo': url ?? currentUser.photo}),
      roomId: room.id,
      builder: (context, roomId, usersData, videoViews, myUserData, myVideoView,
          controls) {
        int? adminIndex = iAmAdmin
            ? null
            : usersData.indexWhere((element) => element['email'] == room.admin);
        log("adminIndex=$adminIndex");
        return Scaffold(
          backgroundColor: Colors.transparent,
          body: SizedBox(
            height: height,
            width: width,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Positioned.fill(
                  child: iAmAdmin
                      ? myVideoView
                      : (adminIndex == -1
                          ? Center(
                              child: Container(
                                child: const GlassWidget(
                                  blur: 0,
                                  child: Text(
                                    'Admin has left the meeting',
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            )
                          : Center(
                              child: Container(
                                child: videoViews[adminIndex!],
                              ),
                            )),
                ),
                Scaffold(
                  appBar: AppBar(
                    // leading: const ElevatedBackButton(),
                    backgroundColor: Colors.transparent,
                    automaticallyImplyLeading: false,
                    title: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.black12,
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: 8.sp,
                        vertical: 3.sp,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CircleAvatar(
                            radius: 20,
                            backgroundImage: currentUser.photo.isNotEmpty
                                ? NetworkImage(currentUser.photo)
                                : const AssetImage('assets/dummy_person.png')
                                    as ImageProvider,
                            backgroundColor: Colors.transparent,
                          ),
                          Expanded(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  room.admin ?? "Error",
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                  overflow: TextOverflow.fade,
                                ),
                                Text(
                                  "id: ${room.id}",
                                  style: const TextStyle(
                                    fontSize: 10,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.white,
                            ),
                            padding: EdgeInsets.symmetric(
                              horizontal: 8.sp,
                              vertical: 2.sp,
                            ),
                            child: const Text(
                              'Follow',
                              style: TextStyle(
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    actions: [
                      // CircleAvatar(
                      //   radius: 15,
                      //   backgroundImage: currentUser.photo.isNotEmpty
                      //       ? NetworkImage(currentUser.photo)
                      //       : const AssetImage('assets/dummy_person.png')
                      //           as ImageProvider,
                      // ),
                      // Stack(
                      //   alignment: Alignment.center,
                      //   children: [
                      //     Image.asset(
                      //       'assets/m_bg.png',
                      //       width: width / 7,
                      //     ),
                      //     const Text(
                      //       "7.1M",
                      //       style: TextStyle(
                      //         fontSize: 8,
                      //         fontWeight: FontWeight.bold,
                      //       ),
                      //     ),
                      //   ],
                      // ),
                      IconButton(
                        onPressed: () {
                          showAlertDialog(context);
                        },
                        icon: Image.asset(
                          'assets/close-square.png',
                          color: Colors.white,
                        ),
                      )
                    ],
                  //   bottom: PreferredSize(
                  //     preferredSize: Size(width, 40),
                  //     child: Row(
                  //       children: [
                  //         // Image.asset(
                  //         //   'assets/Group 18118.png',
                  //         //   height: 25,
                  //         // ),
                  //         Container(
                  //           decoration: const ShapeDecoration(
                  //             color: Color(0xFFDFDFDF),
                  //             shape: RoundedRectangleBorder(
                  //               borderRadius: BorderRadius.only(
                  //                 topRight: Radius.circular(8),
                  //                 bottomRight: Radius.circular(8),
                  //               ),
                  //             ),
                  //           ),
                  //           padding: EdgeInsets.symmetric(
                  //             horizontal: 8.sp,
                  //             vertical: 2.sp,
                  //           ),
                  //           child: Row(
                  //             children: [
                  //               Container(
                  //                 alignment: Alignment.center,
                  //                 padding: EdgeInsets.symmetric(
                  //                   horizontal: 2.sp,
                  //                   vertical: 1.sp,
                  //                 ),
                  //                 decoration: const ShapeDecoration(
                  //                   color: Colors.pink,
                  //                   shape: StarBorder.polygon(
                  //                     sides: 5,
                  //                   ),
                  //                 ),
                  //                 child: Text("10",
                  //                     style: TextStyle(
                  //                         fontSize: 8.sp, color: Colors.white)),
                  //               ),
                  //               const Text(
                  //                 'Follow',
                  //                 style: TextStyle(
                  //                   fontSize: 12,
                  //                 ),
                  //               ),
                  //             ],
                  //           ),
                  //         ),
                  //         SizedBox(width: 10.sp),
                  //         Container(
                  //           padding: const EdgeInsets.only(
                  //               top: 7, left: 23, right: 4, bottom: 5),
                  //           clipBehavior: Clip.antiAlias,
                  //           decoration: const ShapeDecoration(
                  //             color: Color(0xFFDFDFDF),
                  //             shape: RoundedRectangleBorder(
                  //               borderRadius: BorderRadius.only(
                  //                 topRight: Radius.circular(8),
                  //                 bottomRight: Radius.circular(8),
                  //               ),
                  //             ),
                  //           ),
                  //           child: Row(
                  //             mainAxisSize: MainAxisSize.min,
                  //             mainAxisAlignment: MainAxisAlignment.end,
                  //             crossAxisAlignment: CrossAxisAlignment.center,
                  //             children: [
                  //               Text(
                  //                 'No. 2 Bronze',
                  //                 style: TextStyle(
                  //                   color: Colors.black,
                  //                   fontSize: 11.sp,
                  //                   fontWeight: FontWeight.w400,
                  //                   height: 0,
                  //                   letterSpacing: 0.55,
                  //                 ),
                  //               ),
                  //             ],
                  //           ),
                  //         ),
                  //         SizedBox(width: 10.sp),
                  //         Stack(
                  //           alignment: Alignment.center,
                  //           children: [
                  //             Image.asset(
                  //               'assets/family_bg.png',
                  //               // width: width / 7,
                  //             ),
                  //             const Text(
                  //               "Family",
                  //               style: TextStyle(
                  //                 fontSize: 8,
                  //                 fontWeight: FontWeight.bold,
                  //               ),
                  //             ),
                  //           ],
                  //         ),
                  //         Container(
                  //           width: 84,
                  //           height: 22,
                  //           clipBehavior: Clip.antiAlias,
                  //           decoration: ShapeDecoration(
                  //             color: const Color(0xFFDFDFDF),
                  //             shape: RoundedRectangleBorder(
                  //               borderRadius: BorderRadius.circular(37),
                  //             ),
                  //           ),
                  //           child: Stack(
                  //             children: [
                  //               Positioned(
                  //                 left: 1,
                  //                 top: 4.25,
                  //                 child: SizedBox(
                  //                   width: 14.77,
                  //                   height: 14.77,
                  //                   child: Stack(
                  //                     children: [
                  //                       Positioned(
                  //                         left: 0,
                  //                         top: 0,
                  //                         child: Container(
                  //                           width: 14.77,
                  //                           height: 14.77,
                  //                           decoration: const ShapeDecoration(
                  //                             image: DecorationImage(
                  //                               image: NetworkImage(
                  //                                   "https://via.placeholder.com/15x15"),
                  //                               fit: BoxFit.cover,
                  //                             ),
                  //                             shape: OvalBorder(),
                  //                           ),
                  //                         ),
                  //                       ),
                  //                     ],
                  //                   ),
                  //                 ),
                  //               ),
                  //               Positioned(
                  //                 left: 12.53,
                  //                 top: 4.25,
                  //                 child: SizedBox(
                  //                   width: 14.77,
                  //                   height: 14.77,
                  //                   child: Stack(
                  //                     children: [
                  //                       Positioned(
                  //                         left: 0,
                  //                         top: 0,
                  //                         child: Container(
                  //                           width: 14.77,
                  //                           height: 14.77,
                  //                           decoration: const ShapeDecoration(
                  //                             image: DecorationImage(
                  //                               image: NetworkImage(
                  //                                   "https://via.placeholder.com/15x15"),
                  //                               fit: BoxFit.cover,
                  //                             ),
                  //                             shape: OvalBorder(),
                  //                           ),
                  //                         ),
                  //                       ),
                  //                     ],
                  //                   ),
                  //                 ),
                  //               ),
                  //               Positioned(
                  //                 left: 21.81,
                  //                 top: 2.84,
                  //                 child: SizedBox(
                  //                   width: 17.23,
                  //                   height: 17.23,
                  //                   child: Stack(
                  //                     children: [
                  //                       Positioned(
                  //                         left: 0,
                  //                         top: 0,
                  //                         child: Container(
                  //                           width: 17.23,
                  //                           height: 17.23,
                  //                           decoration: const ShapeDecoration(
                  //                             color: Colors.white,
                  //                             shape: OvalBorder(
                  //                               side: BorderSide(
                  //                                   width: 2,
                  //                                   color: Color(0xFFF27121)),
                  //                             ),
                  //                           ),
                  //                         ),
                  //                       ),
                  //                       Positioned(
                  //                         left: 1.23,
                  //                         top: 1.23,
                  //                         child: Container(
                  //                           width: 14.77,
                  //                           height: 14.77,
                  //                           decoration: ShapeDecoration(
                  //                             image: const DecorationImage(
                  //                               image: NetworkImage(
                  //                                   "https://via.placeholder.com/15x15"),
                  //                               fit: BoxFit.cover,
                  //                             ),
                  //                             shape: RoundedRectangleBorder(
                  //                               borderRadius:
                  //                                   BorderRadius.circular(100),
                  //                             ),
                  //                           ),
                  //                         ),
                  //                       ),
                  //                     ],
                  //                   ),
                  //                 ),
                  //               ),
                  //               Positioned(
                  //                 left: 31.65,
                  //                 top: 3.97,
                  //                 child: SizedBox(
                  //                   width: 14.77,
                  //                   height: 14.77,
                  //                   child: Stack(
                  //                     children: [
                  //                       Positioned(
                  //                         left: 0,
                  //                         top: 0,
                  //                         child: Container(
                  //                           width: 14.77,
                  //                           height: 14.77,
                  //                           decoration: const ShapeDecoration(
                  //                             image: DecorationImage(
                  //                               image: NetworkImage(
                  //                                   "https://via.placeholder.com/15x15"),
                  //                               fit: BoxFit.cover,
                  //                             ),
                  //                             shape: OvalBorder(),
                  //                           ),
                  //                         ),
                  //                       ),
                  //                     ],
                  //                   ),
                  //                 ),
                  //               ),
                  //               Positioned(
                  //                 left: 41.77,
                  //                 top: 2,
                  //                 child: SizedBox(
                  //                   width: 17.23,
                  //                   height: 17.23,
                  //                   child: Stack(
                  //                     children: [
                  //                       Positioned(
                  //                         left: 0,
                  //                         top: 0,
                  //                         child: Container(
                  //                           width: 17.23,
                  //                           height: 17.23,
                  //                           decoration: const ShapeDecoration(
                  //                             color: Colors.white,
                  //                             shape: OvalBorder(
                  //                               side: BorderSide(
                  //                                   width: 2,
                  //                                   color: Color(0xFFF27121)),
                  //                             ),
                  //                           ),
                  //                         ),
                  //                       ),
                  //                       Positioned(
                  //                         left: 1.23,
                  //                         top: 1.23,
                  //                         child: Container(
                  //                           width: 14.77,
                  //                           height: 14.77,
                  //                           decoration: const ShapeDecoration(
                  //                             image: DecorationImage(
                  //                               image: NetworkImage(
                  //                                   "https://via.placeholder.com/15x15"),
                  //                               fit: BoxFit.cover,
                  //                             ),
                  //                             shape: OvalBorder(),
                  //                           ),
                  //                         ),
                  //                       ),
                  //                     ],
                  //                   ),
                  //                 ),
                  //               ),
                  //               const Positioned(
                  //                 left: 60,
                  //                 top: 6,
                  //                 child: Text(
                  //                   '250',
                  //                   style: TextStyle(
                  //                     color: Colors.black,
                  //                     fontSize: 10,
                  //                     fontFamily: 'Sofia Pro',
                  //                     fontWeight: FontWeight.w400,
                  //                     height: 0,
                  //                     letterSpacing: 0.50,
                  //                   ),
                  //                 ),
                  //               ),
                  //             ],
                  //           ),
                  //         )
                  //       ],
                  //     ),
                  //   ),
                  ),
                  backgroundColor: Colors.transparent,
                  floatingActionButton: GlassWidget(
                    radius: 50,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        for (int i = 0; i < usersData.length; ++i)
                          AudioUserTile(
                            imgUrl: usersData[i]['photo'],
                            name: usersData[i].isEmpty
                                ? "Error"
                                : (usersData[i]['name'] ??
                                    usersData[i]['email'] ??
                                    "Anonymous"),
                          ),
                      ],
                    ),
                  ),
                  bottomNavigationBar: Padding(
                    padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom,
                    ),
                    child: Row(
                      children: [
                        IconButton(
                            style: IconButton.styleFrom(
                              backgroundColor: Colors.black12,
                            ),
                            onPressed: () {
                              showMsg(context, "In Developement");
                            },
                            icon: Image.asset('assets/smile.png')),
                        Expanded(
                          child: Container(
                            width: width,
                            height: height / 15,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: TextFormField(
                              decoration: InputDecoration(
                                // fillColor: Colors.black12,
                                filled: true,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: const BorderSide(
                                    width: 1,
                                    color: Colors.transparent,
                                  ),
                                ),
                                hintText: "Hii...",
                                hintStyle: TextStyle(
                                  fontSize: height / 50,
                                  color: Colors.black45,
                                ),
                                suffixIcon: Image.asset('assets/Voice.png'),
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: width / 30,
                                  vertical: height / 100,
                                ),
                              ),
                            ),
                          ),
                        ),

                        IconButton(
                          style: IconButton.styleFrom(
                            backgroundColor: Colors.black12,
                          ),
                          onPressed: () {
                            shareRoomLink(room.id);
                          },
                          icon: Image.asset('assets/Send1.png'),
                        ),
                        // IconButton(
                        //   style: IconButton.styleFrom(
                        //     backgroundColor: Colors.black12,
                        //   ),
                        //   onPressed: () {
                        //     showModalBottomSheet(
                        //         backgroundColor: const Color(0xFF21242D),
                        //         context: context,
                        //         builder: (context) {
                        //           return AudioGo(
                        //             roomID: room.id,
                        //           );
                        //         });
                        //   },
                        //   icon: Image.asset('assets/apps.png'),
                        // ),
                        IconButton(
                          style: IconButton.styleFrom(
                            backgroundColor: Colors.black12,
                          ),
                          onPressed: () {
                            showMsg(context, "In Developement");
                          },
                          icon: Image.asset('assets/PK.png'),
                        ),
                        IconButton(
                          style: IconButton.styleFrom(
                            backgroundColor: Colors.black12,
                          ),
                          onPressed: () {
                            showMsg(context, "In Developement");
                          },
                          icon: Image.asset('assets/game_logo.png'),
                        ),
                        IconButton(
                          style: IconButton.styleFrom(
                            backgroundColor: Colors.black12,
                          ),
                          onPressed: () {
                            showMsg(context, "In Developement");
                          },
                          icon: Image.asset('assets/gift.png'),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

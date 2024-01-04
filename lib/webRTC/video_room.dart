import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:audioplayers/audioplayers.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:spinner_try/shivanshu/models/globals.dart';
import 'package:spinner_try/shivanshu/models/room.dart';
import 'package:spinner_try/shivanshu/screens/audio_page.dart';
import 'package:spinner_try/shivanshu/utils.dart';
import 'package:spinner_try/user_model.dart';
import 'package:spinner_try/webRTC/live_chat_widget.dart';
import 'package:spinner_try/webRTC/web_rtc.dart';

import '../shivanshu/utils/loading_icon_button.dart';
import 'audio_room.dart';

class VideoRoom extends StatefulWidget {
  final Room room;

  const VideoRoom({super.key, required this.room});

  @override
  State<VideoRoom> createState() => _VideoRoomState();
}

class _VideoRoomState extends State<VideoRoom> {
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final iAmAdmin = widget.room.admin == auth.currentUser!.email!;
    AudioPlayer audioPlayer = AudioPlayer();
    Future<void> playAudio() async {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['mp3'],
        allowCompression: true,
      );
      if (result != null) {
        final file = File(result.files.single.path!);
        Uint8List mp3Data = await file.readAsBytes();
        MediaStream mediaStream = await navigator.mediaDevices.getUserMedia({
          'audio': {
            'audioData': mp3Data,
          },
        });
        await audioPlayer.play(DeviceFileSource(file.path));
      }
    }

    return WebRTCWidget(
      onExit: () async {
        if (widget.room.admin == auth.currentUser!.email) {
          // if (await askUser(context, 'Do you want to delete the room as well?',
          //         no: true,
          //         custom: {
          //           "delete": const Icon(
          //             Icons.delete_forever_rounded,
          //             color: Colors.red,
          //           )
          //         }) ==
          //     'yes') {
          //   await room.delete();
          // }
        }
      },
      controller: WebRtcController(
        video: iAmAdmin,
        audio: true,
      ),
      userData: currentUser.toJson(),
      roomId: widget.room.id,
      builder: (context, roomId, usersData, videoViews, myUserData, myVideoView,
          controls) {
        int? adminIndex = iAmAdmin
            ? null
            : usersData
                .indexWhere((element) => element['email'] == widget.room.admin);
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
                          ? const Center(
                              child: GlassWidget(
                                blur: 0,
                                child: Text(
                                  'Admin has left the meeting',
                                  style: TextStyle(
                                    color: Colors.white,
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
                  // appBar: AppBar(
                  //   // leading: const ElevatedBackButton(),
                  //   backgroundColor: Colors.transparent,
                  //   automaticallyImplyLeading: false,
                  //   title: Container(
                  //     decoration: BoxDecoration(
                  //       borderRadius: BorderRadius.circular(20),
                  //       color: Colors.black12,
                  //     ),
                  //     padding: EdgeInsets.symmetric(
                  //       horizontal: 8.sp,
                  //       vertical: 3.sp,
                  //     ),
                  //     child: Row(
                  //       mainAxisSize: MainAxisSize.min,
                  //       children: [
                  //         CircleAvatar(
                  //           radius: 20,
                  //           backgroundImage: currentUser.photo.isNotEmpty
                  //               ? NetworkImage(currentUser.photo)
                  //               : const AssetImage('assets/dummy_person.png')
                  //                   as ImageProvider,
                  //           backgroundColor: Colors.transparent,
                  //         ),
                  //         const SizedBox(width: 5),
                  //         Expanded(
                  //           child: Column(
                  //             mainAxisSize: MainAxisSize.min,
                  //             crossAxisAlignment: CrossAxisAlignment.start,
                  //             children: [
                  //               Text(
                  //                 widget.room.name,
                  //                 style: const TextStyle(
                  //                   fontSize: 12,
                  //                   fontWeight: FontWeight.bold,
                  //                   color: Colors.white,
                  //                 ),
                  //                 overflow: TextOverflow.fade,
                  //               ),
                  //               Text(
                  //                 "id: ${widget.room.id}",
                  //                 style: const TextStyle(
                  //                   fontSize: 10,
                  //                   color: Colors.grey,
                  //                 ),
                  //               ),
                  //             ],
                  //           ),
                  //         ),
                  //         Container(
                  //           decoration: BoxDecoration(
                  //             borderRadius: BorderRadius.circular(20),
                  //             color: Colors.white,
                  //           ),
                  //           padding: EdgeInsets.symmetric(
                  //             horizontal: 8.sp,
                  //             vertical: 2.sp,
                  //           ),
                  //           child: const Text(
                  //             'Follow',
                  //             style: TextStyle(
                  //               fontSize: 12,
                  //             ),
                  //           ),
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  //   actions: [
                  //     // CircleAvatar(
                  //     //   radius: 15,
                  //     //   backgroundImage: currentUser.photo.isNotEmpty
                  //     //       ? NetworkImage(currentUser.photo)
                  //     //       : const AssetImage('assets/dummy_person.png')
                  //     //           as ImageProvider,
                  //     // ),
                  //     // Stack(
                  //     //   alignment: Alignment.center,
                  //     //   children: [
                  //     //     Image.asset(
                  //     //       'assets/m_bg.png',
                  //     //       width: width / 7,
                  //     //     ),
                  //     //     const Text(
                  //     //       "7.1M",
                  //     //       style: TextStyle(
                  //     //         fontSize: 8,
                  //     //         fontWeight: FontWeight.bold,
                  //     //       ),
                  //     //     ),
                  //     //   ],
                  //     // ),
                  //     IconButton(
                  //       onPressed: () {
                  //         showAlertDialog(context);
                  //       },
                  //       icon: Image.asset(
                  //         'assets/close-square.png',
                  //         color: Colors.white,
                  //       ),
                  //     )
                  //   ],
                  //   //   bottom: PreferredSize(
                  //   //     preferredSize: Size(width, 40),
                  //   //     child: Row(
                  //   //       children: [
                  //   //         // Image.asset(
                  //   //         //   'assets/Group 18118.png',
                  //   //         //   height: 25,
                  //   //         // ),
                  //   //         Container(
                  //   //           decoration: const ShapeDecoration(
                  //   //             color: Color(0xFFDFDFDF),
                  //   //             shape: RoundedRectangleBorder(
                  //   //               borderRadius: BorderRadius.only(
                  //   //                 topRight: Radius.circular(8),
                  //   //                 bottomRight: Radius.circular(8),
                  //   //               ),
                  //   //             ),
                  //   //           ),
                  //   //           padding: EdgeInsets.symmetric(
                  //   //             horizontal: 8.sp,
                  //   //             vertical: 2.sp,
                  //   //           ),
                  //   //           child: Row(
                  //   //             children: [
                  //   //               Container(
                  //   //                 alignment: Alignment.center,
                  //   //                 padding: EdgeInsets.symmetric(
                  //   //                   horizontal: 2.sp,
                  //   //                   vertical: 1.sp,
                  //   //                 ),
                  //   //                 decoration: const ShapeDecoration(
                  //   //                   color: Colors.pink,
                  //   //                   shape: StarBorder.polygon(
                  //   //                     sides: 5,
                  //   //                   ),
                  //   //                 ),
                  //   //                 child: Text("10",
                  //   //                     style: TextStyle(
                  //   //                         fontSize: 8.sp, color: Colors.white)),
                  //   //               ),
                  //   //               const Text(
                  //   //                 'Follow',
                  //   //                 style: TextStyle(
                  //   //                   fontSize: 12,
                  //   //                 ),
                  //   //               ),
                  //   //             ],
                  //   //           ),
                  //   //         ),
                  //   //         SizedBox(width: 10.sp),
                  //   //         Container(
                  //   //           padding: const EdgeInsets.only(
                  //   //               top: 7, left: 23, right: 4, bottom: 5),
                  //   //           clipBehavior: Clip.antiAlias,
                  //   //           decoration: const ShapeDecoration(
                  //   //             color: Color(0xFFDFDFDF),
                  //   //             shape: RoundedRectangleBorder(
                  //   //               borderRadius: BorderRadius.only(
                  //   //                 topRight: Radius.circular(8),
                  //   //                 bottomRight: Radius.circular(8),
                  //   //               ),
                  //   //             ),
                  //   //           ),
                  //   //           child: Row(
                  //   //             mainAxisSize: MainAxisSize.min,
                  //   //             mainAxisAlignment: MainAxisAlignment.end,
                  //   //             crossAxisAlignment: CrossAxisAlignment.center,
                  //   //             children: [
                  //   //               Text(
                  //   //                 'No. 2 Bronze',
                  //   //                 style: TextStyle(
                  //   //                   color: Colors.black,
                  //   //                   fontSize: 11.sp,
                  //   //                   fontWeight: FontWeight.w400,
                  //   //                   height: 0,
                  //   //                   letterSpacing: 0.55,
                  //   //                 ),
                  //   //               ),
                  //   //             ],
                  //   //           ),
                  //   //         ),
                  //   //         SizedBox(width: 10.sp),
                  //   //         Stack(
                  //   //           alignment: Alignment.center,
                  //   //           children: [
                  //   //             Image.asset(
                  //   //               'assets/family_bg.png',
                  //   //               // width: width / 7,
                  //   //             ),
                  //   //             const Text(
                  //   //               "Family",
                  //   //               style: TextStyle(
                  //   //                 fontSize: 8,
                  //   //                 fontWeight: FontWeight.bold,
                  //   //               ),
                  //   //             ),
                  //   //           ],
                  //   //         ),
                  //   //         Container(
                  //   //           width: 84,
                  //   //           height: 22,
                  //   //           clipBehavior: Clip.antiAlias,
                  //   //           decoration: ShapeDecoration(
                  //   //             color: const Color(0xFFDFDFDF),
                  //   //             shape: RoundedRectangleBorder(
                  //   //               borderRadius: BorderRadius.circular(37),
                  //   //             ),
                  //   //           ),
                  //   //           child: Stack(
                  //   //             children: [
                  //   //               Positioned(
                  //   //                 left: 1,
                  //   //                 top: 4.25,
                  //   //                 child: SizedBox(
                  //   //                   width: 14.77,
                  //   //                   height: 14.77,
                  //   //                   child: Stack(
                  //   //                     children: [
                  //   //                       Positioned(
                  //   //                         left: 0,
                  //   //                         top: 0,
                  //   //                         child: Container(
                  //   //                           width: 14.77,
                  //   //                           height: 14.77,
                  //   //                           decoration: const ShapeDecoration(
                  //   //                             image: DecorationImage(
                  //   //                               image: NetworkImage(
                  //   //                                   "https://via.placeholder.com/15x15"),
                  //   //                               fit: BoxFit.cover,
                  //   //                             ),
                  //   //                             shape: OvalBorder(),
                  //   //                           ),
                  //   //                         ),
                  //   //                       ),
                  //   //                     ],
                  //   //                   ),
                  //   //                 ),
                  //   //               ),
                  //   //               Positioned(
                  //   //                 left: 12.53,
                  //   //                 top: 4.25,
                  //   //                 child: SizedBox(
                  //   //                   width: 14.77,
                  //   //                   height: 14.77,
                  //   //                   child: Stack(
                  //   //                     children: [
                  //   //                       Positioned(
                  //   //                         left: 0,
                  //   //                         top: 0,
                  //   //                         child: Container(
                  //   //                           width: 14.77,
                  //   //                           height: 14.77,
                  //   //                           decoration: const ShapeDecoration(
                  //   //                             image: DecorationImage(
                  //   //                               image: NetworkImage(
                  //   //                                   "https://via.placeholder.com/15x15"),
                  //   //                               fit: BoxFit.cover,
                  //   //                             ),
                  //   //                             shape: OvalBorder(),
                  //   //                           ),
                  //   //                         ),
                  //   //                       ),
                  //   //                     ],
                  //   //                   ),
                  //   //                 ),
                  //   //               ),
                  //   //               Positioned(
                  //   //                 left: 21.81,
                  //   //                 top: 2.84,
                  //   //                 child: SizedBox(
                  //   //                   width: 17.23,
                  //   //                   height: 17.23,
                  //   //                   child: Stack(
                  //   //                     children: [
                  //   //                       Positioned(
                  //   //                         left: 0,
                  //   //                         top: 0,
                  //   //                         child: Container(
                  //   //                           width: 17.23,
                  //   //                           height: 17.23,
                  //   //                           decoration: const ShapeDecoration(
                  //   //                             color: Colors.white,
                  //   //                             shape: OvalBorder(
                  //   //                               side: BorderSide(
                  //   //                                   width: 2,
                  //   //                                   color: Color(0xFFF27121)),
                  //   //                             ),
                  //   //                           ),
                  //   //                         ),
                  //   //                       ),
                  //   //                       Positioned(
                  //   //                         left: 1.23,
                  //   //                         top: 1.23,
                  //   //                         child: Container(
                  //   //                           width: 14.77,
                  //   //                           height: 14.77,
                  //   //                           decoration: ShapeDecoration(
                  //   //                             image: const DecorationImage(
                  //   //                               image: NetworkImage(
                  //   //                                   "https://via.placeholder.com/15x15"),
                  //   //                               fit: BoxFit.cover,
                  //   //                             ),
                  //   //                             shape: RoundedRectangleBorder(
                  //   //                               borderRadius:
                  //   //                                   BorderRadius.circular(100),
                  //   //                             ),
                  //   //                           ),
                  //   //                         ),
                  //   //                       ),
                  //   //                     ],
                  //   //                   ),
                  //   //                 ),
                  //   //               ),
                  //   //               Positioned(
                  //   //                 left: 31.65,
                  //   //                 top: 3.97,
                  //   //                 child: SizedBox(
                  //   //                   width: 14.77,
                  //   //                   height: 14.77,
                  //   //                   child: Stack(
                  //   //                     children: [
                  //   //                       Positioned(
                  //   //                         left: 0,
                  //   //                         top: 0,
                  //   //                         child: Container(
                  //   //                           width: 14.77,
                  //   //                           height: 14.77,
                  //   //                           decoration: const ShapeDecoration(
                  //   //                             image: DecorationImage(
                  //   //                               image: NetworkImage(
                  //   //                                   "https://via.placeholder.com/15x15"),
                  //   //                               fit: BoxFit.cover,
                  //   //                             ),
                  //   //                             shape: OvalBorder(),
                  //   //                           ),
                  //   //                         ),
                  //   //                       ),
                  //   //                     ],
                  //   //                   ),
                  //   //                 ),
                  //   //               ),
                  //   //               Positioned(
                  //   //                 left: 41.77,
                  //   //                 top: 2,
                  //   //                 child: SizedBox(
                  //   //                   width: 17.23,
                  //   //                   height: 17.23,
                  //   //                   child: Stack(
                  //   //                     children: [
                  //   //                       Positioned(
                  //   //                         left: 0,
                  //   //                         top: 0,
                  //   //                         child: Container(
                  //   //                           width: 17.23,
                  //   //                           height: 17.23,
                  //   //                           decoration: const ShapeDecoration(
                  //   //                             color: Colors.white,
                  //   //                             shape: OvalBorder(
                  //   //                               side: BorderSide(
                  //   //                                   width: 2,
                  //   //                                   color: Color(0xFFF27121)),
                  //   //                             ),
                  //   //                           ),
                  //   //                         ),
                  //   //                       ),
                  //   //                       Positioned(
                  //   //                         left: 1.23,
                  //   //                         top: 1.23,
                  //   //                         child: Container(
                  //   //                           width: 14.77,
                  //   //                           height: 14.77,
                  //   //                           decoration: const ShapeDecoration(
                  //   //                             image: DecorationImage(
                  //   //                               image: NetworkImage(
                  //   //                                   "https://via.placeholder.com/15x15"),
                  //   //                               fit: BoxFit.cover,
                  //   //                             ),
                  //   //                             shape: OvalBorder(),
                  //   //                           ),
                  //   //                         ),
                  //   //                       ),
                  //   //                     ],
                  //   //                   ),
                  //   //                 ),
                  //   //               ),
                  //   //               const Positioned(
                  //   //                 left: 60,
                  //   //                 top: 6,
                  //   //                 child: Text(
                  //   //                   '250',
                  //   //                   style: TextStyle(
                  //   //                     color: Colors.black,
                  //   //                     fontSize: 10,
                  //   //                     fontFamily: 'Sofia Pro',
                  //   //                     fontWeight: FontWeight.w400,
                  //   //                     height: 0,
                  //   //                     letterSpacing: 0.50,
                  //   //                   ),
                  //   //                 ),
                  //   //               ),
                  //   //             ],
                  //   //           ),
                  //   //         )
                  //   //       ],
                  //   //     ),
                  //   //   ),
                  // ),
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
                          if (widget.room.imgUrl != null)
                            CircleAvatar(
                              radius: 20,
                              backgroundImage:
                                  NetworkImage(widget.room.imgUrl!),
                              backgroundColor: Colors.transparent,
                            )
                          else
                            Container(
                              clipBehavior: Clip.hardEdge,
                              width: 40,
                              height: 40,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                              ),
                              child: FutureBuilder(
                                future: fetchUserWithEmail(widget.room.admin!),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    final user = snapshot.data!;
                                    return (user.photo.isNotEmpty
                                        ? Image.network(
                                            user.photo,
                                            fit: BoxFit.cover,
                                          )
                                        : Image.asset(
                                            'assets/dummy_person.png',
                                            fit: BoxFit.cover,
                                          ));
                                  } else if (snapshot.hasError) {
                                    return const Icon(Icons.info,
                                        color: Colors.red);
                                  }
                                  return Image.asset(
                                    'assets/dummy_person.png',
                                    fit: BoxFit.cover,
                                  );
                                },
                              ),
                            ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.room.name,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                  overflow: TextOverflow.fade,
                                ),
                                Text(
                                  "id: ${widget.room.id}",
                                  style: const TextStyle(
                                    fontSize: 10,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              if (widget.room.admin != currentUser.email) {
                                followUser(widget.room.admin!);
                              } else {
                                showMsg(context, "You can't follow yourself");
                              }
                            },
                            child: Container(
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
                          ),
                        ],
                      ),
                    ),
                    actions: [
                      Container(
                        width: 31,
                        height: 31,
                        decoration: const ShapeDecoration(
                          image: DecorationImage(
                            image: NetworkImage(
                                "https://via.placeholder.com/31x31"),
                            fit: BoxFit.cover,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(15),
                              topRight: Radius.circular(15),
                              bottomLeft: Radius.circular(15),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Container(
                        width: 40.sp,
                        height: 22,
                        alignment: Alignment.center,
                        clipBehavior: Clip.antiAlias,
                        decoration: ShapeDecoration(
                          color: const Color(0xFFDFDFDF),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(37),
                          ),
                        ),
                        child: const Text(
                          '250',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 10,
                            fontFamily: 'Sofia Pro',
                            fontWeight: FontWeight.w400,
                            height: 0,
                            letterSpacing: 0.50,
                          ),
                        ),
                      )

                      // if (currentUser.email == widget.room.admin)
                      //   LoadingIconButton(
                      //     onPressed: () async {
                      //       final announcement = await promptUser(context,
                      //           question: "What to announce?",
                      //           defaultAns: widget.room.announcement);
                      //       if (announcement != widget.room.announcement) {
                      //         setState(() {
                      //           widget.room.announcement = announcement;
                      //         });
                      //         await widget.room.update();
                      //       } else {
                      //         log("Nothing Changed");
                      //       }
                      //     },
                      //     icon: const Icon(
                      //       Icons.announcement_rounded,
                      //       color: Colors.white,
                      //     ),
                      //   ),
                      ,
                      IconButton(
                        onPressed: () {
                          // showAlertDialog(context);
                        },
                        icon: Image.asset(
                          'assets/close-square.png',
                          color: Colors.white,
                        ),
                      )
                    ],
                    bottom: PreferredSize(
                      preferredSize: Size(width, 40),
                      child: Row(
                        children: [
                          // Image.asset(
                          //   'assets/Group 18118.png',
                          //   height: 25,
                          // ),
                          Container(
                            decoration: const ShapeDecoration(
                              color: Color(0xFFDFDFDF),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(8),
                                  bottomRight: Radius.circular(8),
                                ),
                              ),
                            ),
                            padding: EdgeInsets.symmetric(
                              horizontal: 8.sp,
                              vertical: 2.sp,
                            ),
                            child: Row(
                              children: [
                                Container(
                                  alignment: Alignment.center,
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 2.sp,
                                    vertical: 1.sp,
                                  ),
                                  decoration: const ShapeDecoration(
                                    color: Colors.pink,
                                    shape: StarBorder.polygon(
                                      sides: 5,
                                    ),
                                  ),
                                  child: Text("10",
                                      style: TextStyle(
                                          fontSize: 8.sp, color: Colors.white)),
                                ),
                                const Text(
                                  'No. 10',
                                  style: TextStyle(
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 10.sp),
                          Container(
                            padding: const EdgeInsets.only(
                                top: 7, left: 23, right: 4, bottom: 5),
                            clipBehavior: Clip.antiAlias,
                            decoration: const ShapeDecoration(
                              color: Color(0xFFDFDFDF),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(8),
                                  bottomRight: Radius.circular(8),
                                ),
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  'No. 2 Bronze',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 11.sp,
                                    fontWeight: FontWeight.w400,
                                    height: 0,
                                    letterSpacing: 0.55,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 10.sp),
                          if (currentUser.email == widget.room.admin)
                            SizedBox(
                              height: 45.sp,
                              width: 45.sp,
                              child: LoadingIconButton(
                                onPressed: () async {
                                  final announcement = await promptUser(context,
                                      question: "What to announce?",
                                      defaultAns: widget.room.announcement);
                                  if (announcement !=
                                      widget.room.announcement) {
                                    widget.room.announcement = announcement;
                                    await widget.room.update();
                                  } else {
                                    log("Nothing Changed");
                                  }
                                },
                                icon: const Icon(
                                  Icons.announcement_rounded,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          SizedBox(
                            height: 45.sp,
                            width: 45.sp,
                            child: IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.share,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          // SizedBox(width: 10.sp),
                          // Stack(
                          //   alignment: Alignment.center,
                          //   children: [
                          //     Image.asset(
                          //       'assets/family_bg.png',
                          //       // width: width / 7,
                          //     ),
                          //     const Text(
                          //       "Family",
                          //       style: TextStyle(
                          //         fontSize: 8,
                          //         fontWeight: FontWeight.bold,
                          //       ),
                          //     ),
                          //   ],
                          // ),
                          Container(
                            width: 84,
                            height: 22,
                            clipBehavior: Clip.antiAlias,
                            decoration: ShapeDecoration(
                              color: const Color(0xFFDFDFDF),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(37),
                              ),
                            ),
                            child: Stack(
                              children: [
                                Positioned(
                                  left: 1,
                                  top: 4.25,
                                  child: SizedBox(
                                    width: 14.77,
                                    height: 14.77,
                                    child: Stack(
                                      children: [
                                        Positioned(
                                          left: 0,
                                          top: 0,
                                          child: Container(
                                            width: 14.77,
                                            height: 14.77,
                                            decoration: const ShapeDecoration(
                                              image: DecorationImage(
                                                image: NetworkImage(
                                                    "https://via.placeholder.com/15x15"),
                                                fit: BoxFit.cover,
                                              ),
                                              shape: OvalBorder(),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Positioned(
                                  left: 12.53,
                                  top: 4.25,
                                  child: SizedBox(
                                    width: 14.77,
                                    height: 14.77,
                                    child: Stack(
                                      children: [
                                        Positioned(
                                          left: 0,
                                          top: 0,
                                          child: Container(
                                            width: 14.77,
                                            height: 14.77,
                                            decoration: const ShapeDecoration(
                                              image: DecorationImage(
                                                image: NetworkImage(
                                                    "https://via.placeholder.com/15x15"),
                                                fit: BoxFit.cover,
                                              ),
                                              shape: OvalBorder(),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Positioned(
                                  left: 21.81,
                                  top: 2.84,
                                  child: SizedBox(
                                    width: 17.23,
                                    height: 17.23,
                                    child: Stack(
                                      children: [
                                        Positioned(
                                          left: 0,
                                          top: 0,
                                          child: Container(
                                            width: 17.23,
                                            height: 17.23,
                                            decoration: const ShapeDecoration(
                                              color: Colors.white,
                                              shape: OvalBorder(
                                                side: BorderSide(
                                                    width: 2,
                                                    color: Color(0xFFF27121)),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          left: 1.23,
                                          top: 1.23,
                                          child: Container(
                                            width: 14.77,
                                            height: 14.77,
                                            decoration: ShapeDecoration(
                                              image: const DecorationImage(
                                                image: NetworkImage(
                                                    "https://via.placeholder.com/15x15"),
                                                fit: BoxFit.cover,
                                              ),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(100),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Positioned(
                                  left: 31.65,
                                  top: 3.97,
                                  child: SizedBox(
                                    width: 14.77,
                                    height: 14.77,
                                    child: Stack(
                                      children: [
                                        Positioned(
                                          left: 0,
                                          top: 0,
                                          child: Container(
                                            width: 14.77,
                                            height: 14.77,
                                            decoration: const ShapeDecoration(
                                              image: DecorationImage(
                                                image: NetworkImage(
                                                    "https://via.placeholder.com/15x15"),
                                                fit: BoxFit.cover,
                                              ),
                                              shape: OvalBorder(),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Positioned(
                                  left: 41.77,
                                  top: 2,
                                  child: SizedBox(
                                    width: 17.23,
                                    height: 17.23,
                                    child: Stack(
                                      children: [
                                        Positioned(
                                          left: 0,
                                          top: 0,
                                          child: Container(
                                            width: 17.23,
                                            height: 17.23,
                                            decoration: const ShapeDecoration(
                                              color: Colors.white,
                                              shape: OvalBorder(
                                                side: BorderSide(
                                                    width: 2,
                                                    color: Color(0xFFF27121)),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          left: 1.23,
                                          top: 1.23,
                                          child: Container(
                                            width: 14.77,
                                            height: 14.77,
                                            decoration: const ShapeDecoration(
                                              image: DecorationImage(
                                                image: NetworkImage(
                                                    "https://via.placeholder.com/15x15"),
                                                fit: BoxFit.cover,
                                              ),
                                              shape: OvalBorder(),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const Positioned(
                                  left: 60,
                                  top: 6,
                                  child: Text(
                                    '250',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 10,
                                      fontFamily: 'Sofia Pro',
                                      fontWeight: FontWeight.w400,
                                      height: 0,
                                      letterSpacing: 0.50,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  backgroundColor: Colors.transparent,
                  body: LayoutBuilder(
                    builder: (context, constraints) {
                      return LiveChatBuilder(
                        builder: (ctx, messages) {
                          messages = messages.reversed.toList();
                          return SizedBox(
                            height: constraints.maxHeight,
                            width: constraints.maxWidth * 4 / 5,
                            child: ListView.builder(
                              reverse: true,
                              itemCount: messages.length,
                              itemBuilder: (ctx, index) {
                                final String message =
                                    messages[index]['message'] ?? "Error";
                                final userData = messages[index]['userData'];
                                final photo = userData['photo'];
                                return ListTile(
                                  contentPadding: const EdgeInsets.only(
                                      left: 10, right: 10),
                                  dense: true,
                                  horizontalTitleGap: 0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                  minVerticalPadding: 5,
                                  tileColor: Colors.black38,
                                  leading: CircleAvatar(
                                    backgroundImage: photo.isEmpty
                                        ? null
                                        : NetworkImage(photo),
                                    radius: 10,
                                    child: photo.isNotEmpty
                                        ? null
                                        : const Icon(
                                            Icons.person_rounded,
                                            size: 15,
                                          ),
                                  ),
                                  title: RichText(
                                    text: TextSpan(children: [
                                      TextSpan(
                                        text: "${userData['name']}: ",
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12,
                                        ),
                                      ),
                                      TextSpan(
                                        text: message,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                          // fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ]),
                                  ),
                                );
                              },
                            ),
                          );
                        },
                      );
                    },
                  ),
                  floatingActionButton: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      for (int i = 0; i < usersData.length; ++i)
                        SizedBox(
                          height: 90,
                          width: 90,
                          child: AudioUserTile(
                            user: UserModel.fromJson(usersData[i]),
                          ),
                        ),
                    ],
                    // showMsg(context, "In Developement");
                  ),
                  bottomNavigationBar: Card(
                    // elevation: 0,
                    color: Colors.black26,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40)),
                    child: Row(
                      children: [
                        IconButton(
                          style: IconButton.styleFrom(
                            backgroundColor: Colors.black12,
                          ),
                          onPressed: () {
                            setState(() {
                              controller.audio = !controller.audio;
                            });
                          },
                          icon: controller.audio
                              ? Image.asset(
                                  'assets/Voice.png',
                                  height: 18.sp,
                                )
                              : Image.asset(
                                  "assets/Frame 29.png",
                                  height: 18.sp,
                                ),
                        ),
                        Expanded(
                          child: TextFormField(
                            controller: _controller,
                            onFieldSubmitted: (value) {
                              if (value.isNotEmpty) {
                                sendMessage(
                                  value,
                                  widget.room.id,
                                );
                                _controller.clear();
                              }
                            },
                            decoration: InputDecoration(
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
                              suffixIcon: GestureDetector(
                                  child: Image.asset('assets/smile.png')),
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: width / 30,
                                vertical: height / 100,
                              ),
                            ),
                          ),
                        ),

                        // IconButton(
                        //   style: IconButton.styleFrom(
                        //     backgroundColor: Colors.black12,
                        //   ),
                        //   onPressed: () {
                        //     shareRoomLink(widget.room.id);
                        //   },
                        //   icon: Image.asset(
                        //     'assets/Send1.png',
                        //     height: 20.sp,
                        //   ),
                        // ),
                        GestureDetector(
                          onTap: () {
                            playAudio();
                          },
                          onDoubleTap: () async {
                            await audioPlayer.pause();
                          },
                          onLongPress: () async {
                            await audioPlayer.stop();
                          },
                          child: Padding(
                            padding: EdgeInsets.only(left: 8.0.sp),
                            child: Image.asset(
                              'assets/Discovery1.png',
                              height: 24.sp,
                            ),
                          ),
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

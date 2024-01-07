// import 'dart:developer';
// import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
// import 'package:flutter/foundation.dart' as foundation;
import 'dart:developer';
import 'dart:io';
// import 'dart:math';
import 'dart:typed_data';
import 'dart:ui';

import 'package:audioplayers/audioplayers.dart';
// import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:gif/gif.dart';
import 'package:spinner_try/shivanshu/models/globals.dart';
import 'package:spinner_try/shivanshu/models/room.dart';
import 'package:spinner_try/shivanshu/screens/bottom_model.dart';
import 'package:spinner_try/shivanshu/utils.dart';
import 'package:spinner_try/shivanshu/utils/loading_icon_button.dart';
import 'package:spinner_try/shivanshu/utils/profile_image.dart';
import 'package:spinner_try/user_model.dart';
import 'package:spinner_try/wave/wave_painter.dart';
import 'package:spinner_try/webRTC/audio_room.dart';
import 'package:spinner_try/webRTC/live_chat_widget.dart';
import 'package:spinner_try/webRTC/web_rtc.dart';
import 'package:video_player/video_player.dart';
// import 'package:flutter_web_rtc/flutter_web_rtc.dart';

List<String> gifList = [
  "assets/gif/155.gif",
  "assets/gif/232.gif",
  "assets/gif/512 (1).gif",
  "assets/gif/512 (2).gif",
  "assets/gif/512 (3).gif",
  "assets/gif/512 (4).gif",
  "assets/gif/512 (5).gif",
  "assets/gif/512 (6).gif",
  "assets/gif/512 (7).gif",
  "assets/gif/512 (8).gif",
  "assets/gif/5656 (1).gif",
  "assets/gif/5656 (2).gif",
  "assets/gif/ad (1).gif",
  "assets/gif/ad (2).gif",
  "assets/gif/ad (3).gif",
  "assets/gif/ad (4).gif",
  "assets/gif/ad (6).gif",
  "assets/gif/ad (7).gif",
  "assets/gif/asd (1).gif",
  "assets/gif/asd (2).gif",
  "assets/gif/asd (3).gif",
  "assets/gif/asd (4).gif",
  "assets/gif/asd (5).gif",
  "assets/gif/asd (6).gif",
  "assets/gif/asd (8).gif",
  "assets/gif/asd (9).gif",
  "assets/gif/asd (10).gif",
];

class AudioPage extends StatefulWidget {
  final Room room;
  const AudioPage({super.key, required this.room});

  @override
  State<AudioPage> createState() => _AudioPageState();
}

class _AudioPageState extends State<AudioPage> with TickerProviderStateMixin {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    _controllerr.dispose();
    socket?.off('broadcastMsg', gifReceive);
    super.dispose();
  }

  void gifReceive(dynamic data) {
    log("Received a broadcast msg: $data");
    Map<String, dynamic> gifData = data;
    final String msg = gifData['message'];
    if (!msg.startsWith("\$#")) return;
    String txt = msg.split('\$#').last;
    final userId = txt.split('_').first;
    final gifIndex = txt.split('_').last;
    log("userId = $userId");
    log("gifIndex = $gifIndex");
    showGif(userId, gifIndex);
  }

  late VideoPlayerController _controllerr;

  final controllerr = PageController(initialPage: 0);

  List<Widget> items = [];
  itemss() {
    items = [
      const Icon(Icons.star),
      const Icon(Icons.favorite),
      const Icon(Icons.thumb_up),
      const Icon(Icons.thumb_down),
    ];
  }

  @override
  void initState() {
    super.initState();
    _controllerr = VideoPlayerController.asset('assets/videoo.mp4')
      ..initialize().then((_) {
        print("video initialized");
        _controllerr.play();
        _controllerr.setLooping(true);
        setState(() {});
      }).catchError((error) {
        print("Error in video initialization: $error");
      });
    itemss();
    autoScroll(2000);
    log("Setting up socket listeners for chat");
  }

  String filePath = '';
  // bool emojiShowing = false;
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
  //  bool _isPlaying = true;

  // final WebRtcController controller = WebRtcController(
  //   audio: true,
  //   video: false,
  // );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            bottom: -MediaQuery.of(context).viewInsets.bottom,
            child: SizedBox(
              height: height,
              width: width,
              child: _controllerr.value.isInitialized
                  ? AspectRatio(
                      aspectRatio: _controllerr.value.aspectRatio,
                      child: VideoPlayer(_controllerr),
                    )
                  // : const CircularProgressIndicator(),
                  : Image.asset(
                      'assets/1.png',
                      fit: BoxFit.cover,
                    ),
            ),
          ),
          Scaffold(
            backgroundColor: Colors.transparent,
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
                        backgroundImage: NetworkImage(widget.room.imgUrl!),
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
                              return const Icon(Icons.info, color: Colors.red);
                            }
                            return Image.asset(
                              'assets/dummy_person.png',
                              fit: BoxFit.cover,
                            );
                          },
                        ),
                      ),
                    SizedBox(width: 10.sp),
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.room.name,
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                            overflow: TextOverflow.fade,
                          ),
                          Text(
                            "id: ${widget.room.id}",
                            style: TextStyle(
                              fontSize: 10.sp,
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
                        child: Text(
                          'Follow',
                          style: TextStyle(
                            fontSize: 12.sp,
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
                      image: NetworkImage("https://via.placeholder.com/31x31"),
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
                    showAlertDialog(context);
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
                            if (announcement != widget.room.announcement) {
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
            body: Padding(
              padding: const EdgeInsets.only(
                top: 10.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  WebRTCWidget(
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
                        //     'delete') {
                        //   await widget.room.delete();
                        // }
                      }
                    },
                    controller: controller,
                    userData: currentUser.toJson(),
                    roomId: widget.room.id,
                    builder: (context, roomId, usersData, videoViews,
                        myUserData, myVideoView, controls) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GridView.count(
                          shrinkWrap: true,
                          crossAxisCount: 8 ~/ 2,
                          childAspectRatio: 1 / 1.3,
                          children: [
                            !controller.audio
                                ? Stack(
                                    children: [
                                      AudioUserTile(
                                        gifIndex: gifIndex == null
                                            ? null
                                            : int.parse('$gifIndex'),
                                        user: UserModel.fromJson(myUserData),
                                        onTap: () {
                                          showModalBottomSheet(
                                            backgroundColor:
                                                const Color(0xFF011a51),
                                            shape: const RoundedRectangleBorder(
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(20),
                                                topRight: Radius.circular(20),
                                              ),
                                            ),
                                            context: context,
                                            builder: ((context) {
                                              return BottomModel(
                                                user: UserModel.fromJson(
                                                    myUserData),
                                              );
                                            }),
                                          );
                                        },
                                      ),
                                      const Positioned(
                                        bottom: 35,
                                        right: 20,
                                        child: Icon(
                                          Icons.mic_off_rounded,
                                          size: 20,
                                          color: Colors.white,
                                        ),
                                      )
                                    ],
                                  )
                                : EmptyEffect(
                                    borderColor: Colors.white,
                                    outerMostCircleEndRadius: 100,
                                    outerMostCircleStartRadius: 20,
                                    child: Stack(
                                      children: [
                                        AudioUserTile(
                                          gifIndex: gifIndex == null
                                              ? null
                                              : int.parse('$gifIndex'),
                                          user: UserModel.fromJson(myUserData),
                                          onTap: () {
                                            showModalBottomSheet(
                                              backgroundColor:
                                                  const Color(0xFF011a51),
                                              shape:
                                                  const RoundedRectangleBorder(
                                                borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(20),
                                                  topRight: Radius.circular(20),
                                                ),
                                              ),
                                              context: context,
                                              builder: ((context) {
                                                return BottomModel(
                                                  user: UserModel.fromJson(
                                                      myUserData),
                                                );
                                              }),
                                            );
                                          },
                                        ),
                                        const Positioned(
                                          bottom: 35,
                                          right: 20,
                                          child: Icon(
                                            Icons.mic_rounded,
                                            size: 20,
                                            color: Colors.white,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                            for (int i = 0; i < usersData.length; ++i)
                              Stack(
                                children: [
                                  AudioUserTile(
                                    user: UserModel.fromJson(usersData[i]),
                                    onTap: () {
                                      showModalBottomSheet(
                                        backgroundColor:
                                            const Color(0xFF011a51),
                                        shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(20),
                                            topRight: Radius.circular(20),
                                          ),
                                        ),
                                        context: context,
                                        builder: ((context) {
                                          return BottomModel(
                                            user: UserModel.fromJson(
                                              usersData[i],
                                            ),
                                          );
                                        }),
                                      );
                                    },
                                  ),
                                  // Positioned(child: child)
                                ],
                              ),
                            for (int i = usersData.length + 1; i < 8; ++i)
                              AudioUserTile(
                                user: UserModel(),
                                index: i + 1,
                              ),
                          ],
                        ),
                      );
                    },
                    // meBuilder: (context,
                    //     {required roomId, required userData, required videoView}) {
                    //   return AudioUserTile(
                    //     name: userData == null
                    //         ? "You"
                    //         : userData['name'] ?? userData['email'] ?? "Anonymous",
                    //     onTap: () {
                    //       controller.audio = !controller.audio;
                    //       showMsg(context,
                    //           controller.audio ? "You're unmuted" : 'You\'re now muted');
                    //     },
                    //   );
                    // },
                    // userTileBuilder: (context,
                    //     {required roomId, required userData, required videoView}) {
                    //   return AudioUserTile(
                    //       name: userData == null
                    //           ? "Error"
                    //           : userData['name'] ?? userData['email'] ?? "Anonymous");
                    // },
                  ),
                  Expanded(
                    // height: 350.sp,
                    child: LiveChatBuilder(
                      onReceiveMsg: gifReceive,
                      builder: (ctx, messages) {
                        messages = messages.reversed.toList();
                        return SizedBox(
                          height: 410.sp,
                          width: 300.sp,
                          child: ListView.separated(
                            separatorBuilder: (ctx, index) =>
                                const SizedBox(height: 3),
                            reverse: true,
                            itemCount: messages.length +
                                (widget.room.announcement == null ||
                                        widget.room.announcement!.isEmpty
                                    ? 0
                                    : 1),
                            itemBuilder: (ctx, index) {
                              if (index == 0 &&
                                  widget.room.announcement != null &&
                                  widget.room.announcement!.isNotEmpty) {
                                return Card(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const Text(
                                          "Announcement",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(widget.room.announcement!),
                                      ],
                                    ),
                                  ),
                                );
                              } else {
                                index++;
                              }
                              final String message =
                                  messages[index - 1]['message'] ?? "Error";
                              final userData = messages[index - 1]['userData'];
                              final photo = userData['photo'];
                              return Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 0,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color: Colors.black38,
                                ),
                                child: ListTile(
                                  dense: true,
                                  contentPadding: EdgeInsets.zero,
                                  leading: CircleAvatar(
                                    backgroundImage: photo.isEmpty
                                        ? null
                                        : NetworkImage(photo),
                                    radius: 14,
                                    child: photo.isNotEmpty
                                        ? null
                                        : const Icon(
                                            Icons.person_rounded,
                                            size: 15,
                                          ),
                                  ),
                                  title: RichText(
                                    text: TextSpan(
                                      children: [
                                        TextSpan(
                                          text: "${userData['name']}: ",
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        // message == "asdf"
                                        message.contains("@${userData['name']}")
                                            ? TextSpan(
                                                text: message,
                                                style: const TextStyle(
                                                  color: Colors.pink,
                                                  // fontWeight: FontWeight.bold,
                                                ),
                                              )
                                            : TextSpan(
                                                text: message,
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  // fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      },
                    ),
                  ),
                  // Offstage(
                  //   offstage: !emojiShowing,
                  //   child: SizedBox(
                  //     height: 250,
                  //     child: EmojiPicker(
                  //       onEmojiSelected: (category, emoji) {
                  //         _controller.text += emoji.emoji;
                  //       },
                  //       onBackspacePressed: () {
                  //         // Close the emojiPicker on backspace press
                  //         setState(() {
                  //           emojiShowing = false;
                  //         });
                  //       },
                  //       config: const Config(
                  //         columns: 7,
                  //         initCategory: Category.SMILEYS,
                  //         // bgColor: Color(0xFF21242D),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
            // floatingActionButton: Container(
            //   height: 100.sp,
            //   width: 100.sp,
            //   decoration: BoxDecoration(
            //     // color: Colors.green[100],
            //     color: Colors.transparent,
            //     border: Border.all(
            //       color: Colors.transparent,
            //       width: 2,
            //     ),
            //     borderRadius: BorderRadius.circular(10),
            //   ),
            //   child: Stack(
            //     alignment: Alignment.center,
            //     children: [
            //       PageView(
            //         controller: controllerr,
            //         children: items,
            //       ),
            //       Positioned(
            //         bottom: 10,
            //         child: SmoothPageIndicator(
            //           controller: controllerr,
            //           count: items.length,
            //           effect: const ExpandingDotsEffect(
            //             dotHeight: 10,
            //             dotWidth: 10,
            //             dotColor: Colors.grey,
            //             activeDotColor: Colors.white,
            //           ),
            //           onDotClicked: (index) {
            //             controllerr.animateToPage(
            //               index,
            //               duration: const Duration(milliseconds: 800),
            //               curve: Curves.fastOutSlowIn,
            //             );
            //           },
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            bottomNavigationBar: Card(
              color: Colors.black26,
              child: Row(
                // setState(() {
                //   showEmojiKeyboard = !showEmojiKeyboard;
                //   if (showEmojiKeyboard) {
                //     EmojiPicker(
                //       textEditingController: controller,
                //       config: Config(
                //         columns: 7,
                //         initCategory: Category.SMILEYS,
                //         bgColor: const Color(0xFF21242D),
                //       ),
                //     );
                //   }
                // });
                // onTap: () {
                //   setState(() {
                //     if (showEmojiKeyboard) {
                //     setState(() {
                //       showEmojiKeyboard = false;
                //     });
                //     }
                //   });
                // },
                // showMsg(context, "In Developement");
                // showMsg(
                //     context,
                //     controller.audio
                //         ? "You're unmuted"
                //         : 'You\'re now muted');
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
                            onTap: () {
                              gifBottom(context);
                            },
                            child: Image.asset('assets/smile.png')),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: width / 30,
                          vertical: height / 100,
                        ),
                      ),
                    ),
                  ),
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
                  IconButton(
                    style: IconButton.styleFrom(
                      backgroundColor: Colors.black12,
                    ),
                    onPressed: () async {
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
          )
        ],
      ),
    );
  }

  // body: Padding(
  //   padding: const EdgeInsets.symmetric(horizontal: 8.0),
  //   child: GridView.builder(
  //     scrollDirection: Axis.vertical,
  //     shrinkWrap: true,
  //     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
  //       crossAxisCount: 4,
  //       crossAxisSpacing: 8.0,
  //       mainAxisSpacing: 8.0,
  //     ),
  //     itemCount: gifList.length, // Replace with your item count
  //     itemBuilder: (BuildContext context, int index) {
  //       return GestureDetector(
  //         onTap: () {
  //           Navigator.of(context).pop();
  //           sendMessage(
  //             "\$#${currentUser.id.toString()}_$index",
  //             widget.room.id,
  //           );
  //         },
  //         child: Gif(
  //           controller: GifController(
  //             vsync: this,
  //           ),
  //           repeat: ImageRepeat.repeat,
  //           autostart: Autostart.loop,
  //           image: AssetImage(
  //             gifList[index],
  //           ),
  //         ),
  //       );
  //     },
  //   ),
  // ),

  gifBottom(BuildContext context) {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          IconData selectedIcon = Icons.animation_rounded;
          return Scaffold(
              bottomNavigationBar: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  // GestureDetector(
                  //     onTap: () {
                  //       setState(() {
                  //         Navigator.pop(context);
                  //         emojiShowing = !emojiShowing;
                  //       });
                  //     },
                  //     child: const Icon(Icons.emoji_emotions)),
                  GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedIcon = Icons.animation_rounded;
                        });
                      },
                      child: const Icon(Icons.animation_rounded)),
                  // GestureDetector(
                  //     onTap: () {
                  //       setState(() {
                  //         selectedIcon = Icons.gif;
                  //       });
                  //     },
                  //     child: const Icon(Icons.gif)),
                  // GestureDetector(
                  //     onTap: () {
                  //       setState(() {
                  //         selectedIcon = Icons.gif_box;
                  //       });
                  //     },
                  //     child: const Icon(Icons.gif_box)),
                  // GestureDetector(
                  //     onTap: () {
                  //       setState(() {
                  //         selectedIcon = Icons.gif_box_sharp;
                  //       });
                  //     },
                  //     child: const Icon(Icons.gif_box_sharp)),
                  // GestureDetector(
                  //     onTap: () {
                  //       setState(() {
                  //         selectedIcon = Icons.gif_outlined;
                  //       });
                  //     },
                  //     child: const Icon(Icons.gif_outlined)),
                ],
              ),
              appBar: AppBar(
                title: const Text(
                  'Choose an option:',
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
              ),
              body: buildBody(selectedIcon));
        });
  }

  buildBody(IconData selectedIcon) {
    // if (selectedIcon == Icons.gif) {
    //   return const Center(
    //     child: Text(
    //       'Hello World for GIF',
    //       style: TextStyle(fontSize: 20.0),
    //     ),
    //   );
    // } else if (selectedIcon == Icons.gif_box) {
    //   return const Center(
    //     child: Text(
    //       'Hello World for GIF Box',
    //       style: TextStyle(fontSize: 20.0),
    //     ),
    //   );
    // } else if (selectedIcon == Icons.gif_box_sharp) {
    //   return const Center(
    //     child: Text(
    //       'Hello World for GIF Box Sharp',
    //       style: TextStyle(fontSize: 20.0),
    //     ),
    //   );
    // } else if (selectedIcon == Icons.gif_outlined) {
    //   return const Center(
    //     child: Text(
    //       'Hello World for GIF Outlined',
    //       style: TextStyle(fontSize: 20.0),
    //     ),
    //   );
    // } else {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: GridView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
        ),
        itemCount: gifList.length, // Replace with your item count
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              sendMessage(
                "\$#${currentUser.id.toString()}_$index",
                widget.room.id,
              );
              print(gifList[index]);
              Navigator.of(context).pop();
            },
            child: Gif(
              fps: 30,
              controller: GifController(
                vsync: this,
              ),
              repeat: ImageRepeat.repeat,
              autostart: Autostart.loop,
              image: AssetImage(
                gifList[index],
              ),
            ),
          );
        },
      ),
    );
    // }
  }

  void autoScroll([int delayMilliseconds = 2000]) {
    Future.delayed(Duration(milliseconds: delayMilliseconds)).then((value) {
      int nextPage = ((controllerr.page!.round() + 1) % items.length).toInt();
      controllerr.animateToPage(
        nextPage,
        duration: const Duration(milliseconds: 800),
        curve: Curves.fastOutSlowIn,
      );
      autoScroll(delayMilliseconds);
    });
  }

  String? gifUserId;
  String? gifIndex;

  void showGif(String userId, String index) async {
    setState(() {
      gifUserId = userId;
      gifIndex = index;
    });
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      gifUserId = null;
      gifIndex = null;
    });
  }
}

class AudioUserTile extends StatefulWidget {
  final UserModel user;
  final void Function()? onTap;
  final int? index;
  final int? gifIndex;
  final bool muted;
  const AudioUserTile({
    super.key,
    required this.user,
    this.index,
    this.onTap,
    this.gifIndex,
    this.muted = false,
  });

  @override
  State<AudioUserTile> createState() => _AudioUserTileState();
}

class _AudioUserTileState extends State<AudioUserTile>
    with TickerProviderStateMixin {
  bool isMuted = false;
  GifController? gifController;

  @override
  void initState() {
    super.initState();
    gifController = GifController(
      vsync: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () {
              if (widget.onTap != null) {
                widget.onTap!();
              }
            },
            child: Stack(
              children: [
                widget.user.photo.isEmpty
                    ? Container(
                        height: 60.sp,
                        width: 60.sp,
                        decoration: const BoxDecoration(
                          color: Colors.black45,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          (isMuted
                              ? Icons.mic_off_outlined
                              : Icons.mic_none_outlined),
                          size: 40,
                          color: colorScheme(context).primary,
                        ),
                      )
                    : ProfileImage(user: widget.user),
                if (widget.gifIndex != null)
                  Positioned(
                    top: 18.sp,
                    left: 14.sp,
                    child: SizedBox(
                      height: 55.sp,
                      width: 55.sp,
                      child: Gif(
                        fps: 30,
                        controller: gifController,
                        useCache: true,
                        autostart: Autostart.once,
                        placeholder: (context) =>
                            const Center(child: CircularProgressIndicator()),
                        image: AssetImage(
                          gifList[widget.gifIndex!],
                        ),
                      ),
                    ),
                  ),
                if (widget.muted)
                  const Icon(Icons.mic_off_outlined, color: Colors.white),
              ],
            ),
          ),
        ),
        Text(
          widget.user.name.isEmpty ? "No. ${widget.index}" : widget.user.name,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

void showAlertDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Card(
            color: Colors.transparent,
            child: SizedBox(
              height: 400,
              width: 400,
              child: GlassWidget(
                blur: 4,
                radius: 20,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                        Navigator.of(context).pop();
                        showOverlay(
                            context,
                            AudioUserTile(
                              user: currentUser,
                            ));
                      },
                      child: Container(
                          width: 100.sp,
                          height: 100.sp,
                          padding: const EdgeInsets.all(25),
                          decoration: const ShapeDecoration(
                            gradient: LinearGradient(
                              begin: Alignment(-1.00, -0.01),
                              end: Alignment(1, 0.01),
                              colors: [Color(0xFFF36158), Color(0xFF04A4FF)],
                            ),
                            shape: OvalBorder(),
                          ),
                          child: Image.asset(
                            "assets/mini.png",
                          )),
                    ),
                    Text(
                      'Keep',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.sp,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w900,
                        height: 0,
                      ),
                    ),
                    const SizedBox(height: 20),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                        Navigator.of(context).pop();
                      },
                      child: Container(
                          width: 100.sp,
                          height: 100.sp,
                          padding: const EdgeInsets.all(25),
                          decoration: const ShapeDecoration(
                            gradient: LinearGradient(
                              begin: Alignment(-1.00, -0.01),
                              end: Alignment(1, 0.01),
                              colors: [Color(0xFFF36158), Color(0xFF04A4FF)],
                            ),
                            shape: OvalBorder(),
                          ),
                          child: Image.asset(
                            "assets/shut.png",
                          )),
                    ),
                    Text(
                      'Exit',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.sp,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w900,
                        height: 0,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      );
    },
  );
}
        // actions: [
        //   TextButton(
        //     onPressed: () {
        //       Navigator.of(context).pop();
        //       Navigator.of(context).pop();
        //       showOverlay(
        //           context,
        //           AudioUserTile(
        //             user: currentUser,
        //           ));
        //     },
        //     child: const Text('Keep'),
        //   ),
        //   TextButton(
        //     onPressed: () {
        //       Navigator.of(context).pop();
        //       Navigator.of(context).pop();
        //     },
        //     child: const Text('Exit'),
        //   ),
        // ],

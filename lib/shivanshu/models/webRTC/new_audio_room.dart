import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:math' as math;
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:gif/gif.dart';
import 'package:spinner_try/shivanshu/models/globals.dart';
import 'package:spinner_try/shivanshu/models/room.dart';
import 'package:spinner_try/shivanshu/models/webRTC/room_users.dart';
import 'package:spinner_try/shivanshu/models/webRTC/webrtc.dart';
import 'package:spinner_try/shivanshu/screens/audio_page.dart';
import 'package:spinner_try/shivanshu/utils.dart';
import 'package:spinner_try/shivanshu/utils/loading_icon_button.dart';
import 'package:spinner_try/user_model.dart';
import 'package:video_player/video_player.dart';

import '../../../components/common_elevatedButton.dart';

class NewAudioRoom extends StatefulWidget {
  final Room room;
  const NewAudioRoom({super.key, required this.room});

  @override
  State<NewAudioRoom> createState() => _NewAudioRoomState();
}

class _NewAudioRoomState extends State<NewAudioRoom>
    with TickerProviderStateMixin {
  bool connected = false;
  Map<String, bool> isMuted = {};
  List<String?> seats = List.generate(8, (index) => null);
  final TextEditingController _controller = TextEditingController();
  late VideoPlayerController _controllerr;
  // final controllerr = PageController(initialPage: 0);
  List<Widget> items = [];
  List<UserModel> users = [];

  @override
  void initState() {
    super.initState();
    log("Initializing WebRTCRoom. This Should be called only once");
    WebRTCRoom.instance.roomId = widget.room.id;
    WebRTCRoom.instance.isVideoOn = false;
    WebRTCRoom.instance.onSeatsChanged = (seats) {
      log("SetState for function: onSeatsChanged");
      if (context.mounted) {
        setState(() {
          this.seats = seats;
        });
      }
    };
    WebRTCRoom.instance.onLocalStreamAdded = () {
      log("SetState for function: onLocalStreamAdded");
      if (context.mounted) {
        setState(() {
          log("onLocalStreamAdded called!");
        });
      }
    };
    WebRTCRoom.instance.onRemoteRemoved = () {
      log("SetState for function: onRemoteRemoved");
      if (context.mounted) {
        setState(() {
          log("onRemoteRemoved called!");
        });
      }
    };
    WebRTCRoom.instance.onRemoteStreamAdded = () {
      log("SetState for function: onRemoteStreamAdded");
      if (context.mounted) {
        setState(() {
          log("onRemoteStreamAdded called!");
        });
      }
    };
    WebRTCRoom.instance.onConnect = () {
      log("SetState for function: onConnect");
      if (context.mounted) {
        WebRTCRoom.instance.getUsers();
        setState(() {
          connected = true;
        });
      }
    };
    WebRTCRoom.instance.onConnectError = () {
      log("SetState for function: onConnectError");
      showMsg(context, "Connect Error");
    };
    WebRTCRoom.instance.onDisconnect = () {
      log("SetState for function: onDisconnect");
      if (context.mounted) {
        showMsg(context, "Disconnected");
      }
    };
    WebRTCRoom.instance.onReceiveMsg = (dynamic msgData) {
      log(msgData.toString());
      if (msgData['data'] != null) {
        final userData = UserModel.fromJson(msgData['userdata']);
        try {
          bool isAudioOn = json.decode(msgData['data'])['isAudioOn'];
          isMuted[userData.id!] = isAudioOn;
        } catch (e) {
          log(e.toString());
        }
        try {
          gifReceive(msgData['data']);
        } catch (e) {
          log(e.toString());
        }
      }
      if (msgData['message'] != null &&
          !(msgData['message'] as String).startsWith("\$#")) {
        setState(() {
          msgs.add(msgData);
        });
      }
    };
    WebRTCRoom.instance.onUsersChanged = (users) {
      log("SetState for function: onUsersChanged");
      if (context.mounted) {
        setState(() {
          this.users = users;
        });
      }
    };
    // WebRTCRoom.instance.onExit = () => showMsg(context, "You exited!");
    WebRTCRoom.instance.connectToServer(widget.room.id);

    _controllerr = VideoPlayerController.asset('assets/videoo.mp4')
      ..initialize().then((_) {
        print("video initialized");
        _controllerr.play();
        _controllerr.setLooping(true);
        setState(() {});
      }).catchError((error) {
        print("Error in video initialization: $error");
      });
  }

  void gifReceive(dynamic data) {
    log("Received a gif msg: $data");
    Map<String, dynamic> gifData = json.decode(data);
    gifIndex = gifData['gif'] ?? 0;
    final userId = UserModel.fromJson(gifData['userdata']).id!;
    log("userId = $userId");
    log("gifIndex = $gifIndex");
    showGif(userId, gifIndex!);
  }

  String? gifUserId;
  int? gifIndex;

  void showGif(String userId, int index) async {
    setState(() {
      gifUserId = userId;
      gifIndex = index;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _controllerr.dispose();
    WebRTCRoom.instance.disconnect();
    WebRTCRoom.instance.onSeatsChanged = null;
    WebRTCRoom.instance.onLocalStreamAdded = null;
    WebRTCRoom.instance.onRemoteRemoved = null;
    WebRTCRoom.instance.onRemoteStreamAdded = null;
    WebRTCRoom.instance.onConnect = null;
    WebRTCRoom.instance.onConnectError = null;
    WebRTCRoom.instance.onDisconnect = null;
    WebRTCRoom.instance.onReceiveMsg = null;
    super.dispose();
  }

  final List<Map<String, dynamic>> msgs = [];

  @override
  Widget build(BuildContext context) {
    WebRTCRoom.instance.builder =
        (context, roomId, usersData, videoViews, myUserData, myVideoView) {
      final user = UserModel.fromJson(myUserData);
      final List<UserModel> remoteUsers =
          usersData.map<UserModel>((e) => UserModel.fromJson(e)).toList();
      return GridView.extent(
        maxCrossAxisExtent: 100,
        childAspectRatio: 1,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          for (int i = 0; i < seats.length; ++i)
            seats[i] == null
                ? AudioUserTile(
                    onTap: () {
                      if (widget.room.admin == currentUser.id) {
                        showModalBottomSheet(
                          context: context,
                          builder: (context) => RoomUsers(
                            onSelect: (user) {
                              WebRTCRoom.instance.inviteUser(user.id!, i);
                            },
                            loader: (start, lastUser) async {
                              if (start == 0) {
                                return await WebRTCRoom.instance.getUsers();
                              }
                              return [];
                            },
                          ),
                        );
                      }
                    },
                    user: UserModel(name: "Empty"),
                    index: 0,
                  )
                : AudioUserTile(
                    gifIndex: (remoteUsers
                                        .where(
                                            (element) => element.id == seats[i])
                                        .firstOrNull ??
                                    user)
                                .id ==
                            gifUserId
                        ? gifIndex
                        : null,
                    user: remoteUsers
                            .where((element) => element.id == seats[i])
                            .firstOrNull ??
                        (user.id == seats[i]
                            ? user
                            : UserModel(
                                name: "Unknown ${seats[i]}", id: seats[i])),
                    index: 0,
                    onTap: () {
                      WebRTCRoom.instance
                          .toggleMic(!WebRTCRoom.instance.isAudioOn);
                      showMsg(context, "Muted");
                      setState(() {});
                    },
                    muted: isMuted[seats[i]] ?? false,
                  ),
        ],
      );
    };

    return WillPopScope(
      onWillPop: () async {
        if (await askUser(context, 'Do you really want to exit the room?',
                yes: true, no: true) !=
            'yes') {
          return false;
        }
        WebRTCRoom.instance.disconnect();
        return true;
      },
      child: Scaffold(
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
                  SizedBox(
                    height: 45.sp,
                    width: 45.sp,
                    child: IconButton(
                      style: IconButton.styleFrom(
                          padding: const EdgeInsets.all(0)),
                      onPressed: () {
                        shareRoomLink(widget.room.id);
                      },
                      icon: const Icon(
                        Icons.share,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  if (currentUser.id == widget.room.admin)
                    LoadingIconButton(
                      onPressed: () async {
                        final announcement = await promptUser(context,
                            question: "What to announce?",
                            defaultAns: widget.room.announcement);
                        if (announcement != widget.room.announcement) {
                          setState(() {
                            widget.room.announcement = announcement;
                          });
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
                            for (int i = 0; i < math.min(5, users.length); ++i)
                              Positioned(
                                left: 15 * i.toDouble(),
                                child: Container(
                                  width: 20,
                                  height: 20,
                                  clipBehavior: Clip.hardEdge,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                  ),
                                  child: users[i].photo.isEmpty
                                      ? Image.asset('assets/dummy_person.png')
                                      : Image.network(
                                          users[i].photo,
                                          fit: BoxFit.cover,
                                        ),
                                ),
                              ),
                            Positioned(
                              right: 10,
                              top: 6,
                              child: Text(
                                users.length.toString(),
                                style: const TextStyle(
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
              body: connected
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        WebRTCRoom.instance.build(context),
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 8.sp,
                              vertical: 8.sp,
                            ),
                            width: width * 2 / 3,
                            child: ListView.builder(
                              reverse: true,
                              // controller: controllerr,
                              itemCount: msgs.length +
                                  (widget.room.announcement != null ? 1 : 0),
                              itemBuilder: (context, index) {
                                if (widget.room.announcement != null) {
                                  if (index == msgs.length) {
                                    return Card(
                                      color: Colors.white,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            const Align(
                                              alignment: Alignment.center,
                                              child: Text(
                                                "Announcement",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                            Text(widget.room.announcement!),
                                          ],
                                        ),
                                      ),
                                    );
                                  } else {
                                    // index--;
                                  }
                                }
                                final msg = msgs[msgs.length - index - 1];
                                final user =
                                    UserModel.fromJson(msg['userdata']);
                                return Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    if (user.photo.isNotEmpty)
                                      CircleAvatar(
                                        radius: 20,
                                        backgroundImage: NetworkImage(
                                          user.photo,
                                        ),
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
                                        child: Image.asset(
                                          'assets/dummy_person.png',
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    SizedBox(width: 10.sp),
                                    Expanded(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            user.name,
                                            style: TextStyle(
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                            overflow: TextOverflow.fade,
                                          ),
                                          Text(
                                            msg['message'],
                                            style: TextStyle(
                                              fontSize: 10.sp,
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    )
                  : const Center(
                      child: MyColumn(
                        children: [
                          Text('Connecting to server'),
                          CircularProgressIndicatorRainbow(),
                        ],
                      ),
                    ),
              bottomNavigationBar: Card(
                color: Colors.black26,
                child: Row(
                  children: [
                    IconButton(
                      style: IconButton.styleFrom(
                        backgroundColor: Colors.black12,
                      ),
                      onPressed: () {
                        setState(() {
                          WebRTCRoom.instance
                              .toggleMic(!WebRTCRoom.instance.isAudioOn);
                        });
                      },
                      icon: WebRTCRoom.instance.isAudioOn
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
                            WebRTCRoom.instance
                                .sendMessage(value, widget.room.id);
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
                              onTap: !seats.contains(currentUser.id)
                                  ? null
                                  : () {
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
                        giftBottom(context);
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
  }

  final List<String> imageAssest = [
    "assets/stickers/1.png",
    "assets/stickers/2.png",
    "assets/stickers/3.png",
    "assets/stickers/4.png",
    "assets/stickers/5.png",
    "assets/stickers/6.png",
    "assets/stickers/7.png",
    "assets/stickers/8.png",
    "assets/stickers/9.png",
    "assets/stickers/10.png",
    "assets/stickers/11.png",
    "assets/stickers/12.png",
    "assets/stickers/13.png",
    "assets/stickers/14.png",
    "assets/stickers/15.png",
    "assets/stickers/16.png",
    "assets/stickers/17.png",
    "assets/stickers/18.png",
    "assets/stickers/19.png",
  ];
  giftBottom(BuildContext context) {
    List<String> value = ['all in the room', 'all on mic'];
    String? selectedValue;
    final List<String> categories = [
      'Hot',
      'Lucky',
      'Vip',
      'Events',
      'Couple',
      'Luxury'
    ];

    int currentPageIndex = 0;
    return showModalBottomSheet(
      context: context,
      builder: (context) {
        return Scaffold(
          appBar: AppBar(
            leading: Container(height: 1),
            centerTitle: false,
            title: Row(
              children: [
                Container(
                  width: 240,
                  height: 60,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: ListView.builder(
                    itemCount: users.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Container(
                        width: 40,
                        height: 40,
                        margin: const EdgeInsets.symmetric(horizontal: 5),
                        decoration: ShapeDecoration(
                          image: DecorationImage(
                            image: NetworkImage(users[index].photo.isEmpty
                                ? 'https://www.pngitem.com/pimgs/m/146-1468479_my-profile-icon-blank-profile-picture-circle-hd.png'
                                : users[index].photo),
                            fit: BoxFit.contain,
                          ),
                          shape: const CircleBorder(),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                DropdownButtonHideUnderline(
                  child: DropdownButton2(
                    customButton:
                        Image.asset("assets/dropdownimage.png", height: 10),
                    items: value
                        .map(
                          (item) => DropdownMenuItem<String>(
                            value: item,
                            child: Text(
                              item,
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ),
              ],
            ),
          ),
          // body: Container(
          //   width: MediaQuery.of(context).size.width,
          //   clipBehavior: Clip.antiAlias,
          //   decoration: const BoxDecoration(
          //     gradient: LinearGradient(
          //       begin: Alignment(-0.78, -0.63),
          //       end: Alignment(0.78, 0.63),
          //       colors: [
          //         Color(0xFF3E3B6F),
          //         Color(0xE22C2B3B),
          //         Color(0xFF090909)
          //       ],
          //     ),
          //   ),
          //   child: Column(
          //     children: [
          //       Padding(
          //         padding:
          //             const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
          //         child: Container(
          //           decoration: BoxDecoration(
          //             borderRadius: BorderRadius.circular(20),
          //             color: const Color(0xFFA69F9F),
          //           ),
          //           child:

          //         ),
          //       ),
          //       Row(
          //         mainAxisAlignment: MainAxisAlignment.spaceAround,
          //         children: [
          //           const SizedBox(
          //             width: 258,
          //             height: 15,
          //             child: Stack(
          //               children: [
          //                 Positioned(
          //                   left: 0,
          //                   top: 0,
          //                   child: Text(
          //                     'Hot',
          //                     style: TextStyle(
          //                       color: Colors.white,
          //                       fontSize: 14,
          //                       fontFamily: 'Sofia Pro',
          //                       fontWeight: FontWeight.w400,
          //                       height: 0,
          //                     ),
          //                   ),
          //                 ),
          //                 Positioned(
          //                   left: 32,
          //                   top: 0,
          //                   child: Text(
          //                     'Lucky',
          //                     style: TextStyle(
          //                       color: Color(0xFF9B8F8F),
          //                       fontSize: 14,
          //                       fontFamily: 'Sofia Pro',
          //                       fontWeight: FontWeight.w400,
          //                       height: 0,
          //                     ),
          //                   ),
          //                 ),
          //                 Positioned(
          //                   left: 78,
          //                   top: 0,
          //                   child: Text(
          //                     'Vip',
          //                     style: TextStyle(
          //                       color: Color(0xFF9B8F8F),
          //                       fontSize: 14,
          //                       fontFamily: 'Sofia Pro',
          //                       fontWeight: FontWeight.w400,
          //                       height: 0,
          //                     ),
          //                   ),
          //                 ),
          //                 Positioned(
          //                   left: 160,
          //                   top: 0,
          //                   child: Text(
          //                     'Events',
          //                     style: TextStyle(
          //                       color: Color(0xFF9B8F8F),
          //                       fontSize: 14,
          //                       fontFamily: 'Sofia Pro',
          //                       fontWeight: FontWeight.w400,
          //                       height: 0,
          //                     ),
          //                   ),
          //                 ),
          //                 Positioned(
          //                   left: 212,
          //                   top: 1,
          //                   child: Text(
          //                     'Couple',
          //                     style: TextStyle(
          //                       color: Color(0xFF9B8F8F),
          //                       fontSize: 14,
          //                       fontFamily: 'Sofia Pro',
          //                       fontWeight: FontWeight.w400,
          //                       height: 0,
          //                     ),
          //                   ),
          //                 ),
          //                 Positioned(
          //                   left: 107,
          //                   top: 0,
          //                   child: Text(
          //                     'Luxury',
          //                     style: TextStyle(
          //                       color: Color(0xFF9B8F8F),
          //                       fontSize: 14,
          //                       fontFamily: 'Sofia Pro',
          //                       fontWeight: FontWeight.w400,
          //                       height: 0,
          //                     ),
          //                   ),
          //                 ),
          //               ],
          //             ),
          //           ),
          //           const SizedBox(
          //             width: 10,
          //           ),
          //           Image.asset(
          //             "assets/shopping bag 1.png",
          //             height: 20,
          //           )
          //         ],
          //       ),
          //     ],
          //   ),
          // ),
          body: Container(
            width: MediaQuery.of(context).size.width,
            clipBehavior: Clip.antiAlias,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment(-0.78, -0.63),
                end: Alignment(0.78, 0.63),
                colors: [
                  Color(0xFF3E3B6F),
                  Color(0xE22C2B3B),
                  Color(0xFF090909)
                ],
              ),
            ),
            child: PageView(
              controller: PageController(initialPage: currentPageIndex),
              onPageChanged: (index) {
                setState(() {
                  currentPageIndex = index;
                });
              },
              children: List.generate(
                categories.length,
                (index) => buildPage(
                  categories[index],
                ),
              ),
            ),
          ),
          extendBody: true,
          bottomNavigationBar: Card(
            color: Colors.transparent,
            child: Row(
              children: [
                SizedBox(
                  width: 150.sp,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Image.asset("assets/diamond.png", height: 20),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text('${currentUser.diamonds}',
                            style: const TextStyle(color: Colors.white)),
                      ),
                      Image.asset("assets/chevron down.png", height: 20),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 75.sp,
                      height: 30.sp,
                      alignment: Alignment.center,
                      clipBehavior: Clip.antiAlias,
                      decoration: ShapeDecoration(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            '1',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 10.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          SizedBox(width: 13.sp),
                          Container(
                            width: 25,
                            height: 25,
                            clipBehavior: Clip.antiAlias,
                            alignment: Alignment.center,
                            decoration: ShapeDecoration(
                              shape: RoundedRectangleBorder(
                                side: const BorderSide(
                                  width: 0.50,
                                  color: Color(0xFFE05DD3),
                                ),
                                borderRadius: BorderRadius.circular(55),
                              ),
                            ),
                            child: const Icon(
                              Icons.upgrade_rounded,
                              color: Color(0xFFE05DD3),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 10.sp),
                    Container(
                      width: 75.sp,
                      height: 30.sp,
                      clipBehavior: Clip.antiAlias,
                      decoration: ShapeDecoration(
                        color: const Color(0xFFE05DD3),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      alignment: Alignment.center,
                      child: const Text(
                        'Send',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontFamily: 'Sofia Pro',
                          fontWeight: FontWeight.w400,
                          letterSpacing: 0.50,
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Widget buildPage(String category) {
    // return Text(category);
    if (category == "Hot") {
      return GridView.count(
          crossAxisCount: 3,
          padding: const EdgeInsets.all(4.0),
          children: [
            CommonElevatedButton(
              image: imageAssest[0],
              diamond: '10',
              text: 'Hot',
              onPressed: () {},
            ),
            CommonElevatedButton(
              image: imageAssest[1],
              diamond: '10',
              text: 'Hot',
              onPressed: () {},
            ),
            CommonElevatedButton(
              image: imageAssest[2],
              diamond: '10',
              text: 'Hot',
              onPressed: () {},
            ),
            CommonElevatedButton(
              image: imageAssest[3],
              diamond: '10',
              text: 'Hot',
              onPressed: () {},
            ),
            CommonElevatedButton(
              image: imageAssest[4],
              diamond: '10',
              text: 'Hot',
              onPressed: () {},
            ),
            CommonElevatedButton(
              image: imageAssest[5],
              diamond: '10',
              text: 'Hot',
              onPressed: () {},
            ),
            CommonElevatedButton(
              image: imageAssest[6],
              diamond: '10',
              text: 'Hot',
              onPressed: () {},
            ),
            CommonElevatedButton(
              image: imageAssest[7],
              diamond: '10',
              text: 'Hot',
              onPressed: () {},
            ),
            CommonElevatedButton(
              image: imageAssest[8],
              diamond: '10',
              text: 'Hot',
              onPressed: () {},
            ),
          ]);
    } else {
      return const Icon(Icons.email);
    }
  }

  gifBottom(BuildContext context) {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          IconData selectedIcon = Icons.animation_rounded;
          return Scaffold(
              bottomNavigationBar: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedIcon = Icons.animation_rounded;
                        });
                      },
                      child: const Icon(Icons.animation_rounded)),
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
              WebRTCRoom.instance.sendMessage(null, widget.room.id, {
                'userdata': currentUser.toJson(),
                'gif': index,
              });
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
      WebRTCRoom.instance.addAudioStream(mediaStream);
    }
  }
}

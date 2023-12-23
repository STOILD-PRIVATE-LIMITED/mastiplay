// import 'dart:developer';

// import 'package:animated_icon/animated_icon.dart';
// import 'package:emoji_keyboard_flutter/emoji_keyboard_flutter.dart';
// import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
// import 'package:flutter/foundation.dart' as foundation;
import 'package:flutter/material.dart';
import 'package:spinner_try/shivanshu/models/room.dart';
import 'package:spinner_try/shivanshu/utils.dart';
import 'package:spinner_try/user_model.dart';
import 'package:spinner_try/webRTC/audio_room.dart';
import 'package:spinner_try/webRTC/web_rtc.dart';

class AudioPage extends StatefulWidget {
  final Room room;
  const AudioPage({super.key, required this.room});

  @override
  State<AudioPage> createState() => _AudioPageState();
}

class _AudioPageState extends State<AudioPage> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

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
            child: Image.asset(
              'assets/1.png',
              fit: BoxFit.cover,
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
                          future: fetchUser(widget.room.admin!),
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
              // bottom: PreferredSize(
              //   preferredSize: Size(width, 40),
              //   child: Row(
              //     children: [
              //       // Image.asset(
              //       //   'assets/Group 18118.png',
              //       //   height: 25,
              //       // ),
              //       Container(
              //         decoration: const ShapeDecoration(
              //           color: Color(0xFFDFDFDF),
              //           shape: RoundedRectangleBorder(
              //             borderRadius: BorderRadius.only(
              //               topRight: Radius.circular(8),
              //               bottomRight: Radius.circular(8),
              //             ),
              //           ),
              //         ),
              //         padding: EdgeInsets.symmetric(
              //           horizontal: 8.sp,
              //           vertical: 2.sp,
              //         ),
              //         child: Row(
              //           children: [
              //             Container(
              //               alignment: Alignment.center,
              //               padding: EdgeInsets.symmetric(
              //                 horizontal: 2.sp,
              //                 vertical: 1.sp,
              //               ),
              //               decoration: const ShapeDecoration(
              //                 color: Colors.pink,
              //                 shape: StarBorder.polygon(
              //                   sides: 5,
              //                 ),
              //               ),
              //               child: Text("10",
              //                   style: TextStyle(
              //                       fontSize: 8.sp, color: Colors.white)),
              //             ),
              //             const Text(
              //               'Follow',
              //               style: TextStyle(
              //                 fontSize: 12,
              //               ),
              //             ),
              //           ],
              //         ),
              //       ),
              //       SizedBox(width: 10.sp),
              //       Container(
              //         padding: const EdgeInsets.only(
              //             top: 7, left: 23, right: 4, bottom: 5),
              //         clipBehavior: Clip.antiAlias,
              //         decoration: const ShapeDecoration(
              //           color: Color(0xFFDFDFDF),
              //           shape: RoundedRectangleBorder(
              //             borderRadius: BorderRadius.only(
              //               topRight: Radius.circular(8),
              //               bottomRight: Radius.circular(8),
              //             ),
              //           ),
              //         ),
              //         child: Row(
              //           mainAxisSize: MainAxisSize.min,
              //           mainAxisAlignment: MainAxisAlignment.end,
              //           crossAxisAlignment: CrossAxisAlignment.center,
              //           children: [
              //             Text(
              //               'No. 2 Bronze',
              //               style: TextStyle(
              //                 color: Colors.black,
              //                 fontSize: 11.sp,
              //                 fontWeight: FontWeight.w400,
              //                 height: 0,
              //                 letterSpacing: 0.55,
              //               ),
              //             ),
              //           ],
              //         ),
              //       ),
              //       SizedBox(width: 10.sp),
              //       Stack(
              //         alignment: Alignment.center,
              //         children: [
              //           Image.asset(
              //             'assets/family_bg.png',
              //             // width: width / 7,
              //           ),
              //           const Text(
              //             "Family",
              //             style: TextStyle(
              //               fontSize: 8,
              //               fontWeight: FontWeight.bold,
              //             ),
              //           ),
              //         ],
              //       ),
              //       Container(
              //         width: 84,
              //         height: 22,
              //         clipBehavior: Clip.antiAlias,
              //         decoration: ShapeDecoration(
              //           color: const Color(0xFFDFDFDF),
              //           shape: RoundedRectangleBorder(
              //             borderRadius: BorderRadius.circular(37),
              //           ),
              //         ),
              //         child: Stack(
              //           children: [
              //             Positioned(
              //               left: 1,
              //               top: 4.25,
              //               child: SizedBox(
              //                 width: 14.77,
              //                 height: 14.77,
              //                 child: Stack(
              //                   children: [
              //                     Positioned(
              //                       left: 0,
              //                       top: 0,
              //                       child: Container(
              //                         width: 14.77,
              //                         height: 14.77,
              //                         decoration: const ShapeDecoration(
              //                           image: DecorationImage(
              //                             image: NetworkImage(
              //                                 "https://via.placeholder.com/15x15"),
              //                             fit: BoxFit.cover,
              //                           ),
              //                           shape: OvalBorder(),
              //                         ),
              //                       ),
              //                     ),
              //                   ],
              //                 ),
              //               ),
              //             ),
              //             Positioned(
              //               left: 12.53,
              //               top: 4.25,
              //               child: SizedBox(
              //                 width: 14.77,
              //                 height: 14.77,
              //                 child: Stack(
              //                   children: [
              //                     Positioned(
              //                       left: 0,
              //                       top: 0,
              //                       child: Container(
              //                         width: 14.77,
              //                         height: 14.77,
              //                         decoration: const ShapeDecoration(
              //                           image: DecorationImage(
              //                             image: NetworkImage(
              //                                 "https://via.placeholder.com/15x15"),
              //                             fit: BoxFit.cover,
              //                           ),
              //                           shape: OvalBorder(),
              //                         ),
              //                       ),
              //                     ),
              //                   ],
              //                 ),
              //               ),
              //             ),
              //             Positioned(
              //               left: 21.81,
              //               top: 2.84,
              //               child: SizedBox(
              //                 width: 17.23,
              //                 height: 17.23,
              //                 child: Stack(
              //                   children: [
              //                     Positioned(
              //                       left: 0,
              //                       top: 0,
              //                       child: Container(
              //                         width: 17.23,
              //                         height: 17.23,
              //                         decoration: const ShapeDecoration(
              //                           color: Colors.white,
              //                           shape: OvalBorder(
              //                             side: BorderSide(
              //                                 width: 2,
              //                                 color: Color(0xFFF27121)),
              //                           ),
              //                         ),
              //                       ),
              //                     ),
              //                     Positioned(
              //                       left: 1.23,
              //                       top: 1.23,
              //                       child: Container(
              //                         width: 14.77,
              //                         height: 14.77,
              //                         decoration: ShapeDecoration(
              //                           image: const DecorationImage(
              //                             image: NetworkImage(
              //                                 "https://via.placeholder.com/15x15"),
              //                             fit: BoxFit.cover,
              //                           ),
              //                           shape: RoundedRectangleBorder(
              //                             borderRadius:
              //                                 BorderRadius.circular(100),
              //                           ),
              //                         ),
              //                       ),
              //                     ),
              //                   ],
              //                 ),
              //               ),
              //             ),
              //             Positioned(
              //               left: 31.65,
              //               top: 3.97,
              //               child: SizedBox(
              //                 width: 14.77,
              //                 height: 14.77,
              //                 child: Stack(
              //                   children: [
              //                     Positioned(
              //                       left: 0,
              //                       top: 0,
              //                       child: Container(
              //                         width: 14.77,
              //                         height: 14.77,
              //                         decoration: const ShapeDecoration(
              //                           image: DecorationImage(
              //                             image: NetworkImage(
              //                                 "https://via.placeholder.com/15x15"),
              //                             fit: BoxFit.cover,
              //                           ),
              //                           shape: OvalBorder(),
              //                         ),
              //                       ),
              //                     ),
              //                   ],
              //                 ),
              //               ),
              //             ),
              //             Positioned(
              //               left: 41.77,
              //               top: 2,
              //               child: SizedBox(
              //                 width: 17.23,
              //                 height: 17.23,
              //                 child: Stack(
              //                   children: [
              //                     Positioned(
              //                       left: 0,
              //                       top: 0,
              //                       child: Container(
              //                         width: 17.23,
              //                         height: 17.23,
              //                         decoration: const ShapeDecoration(
              //                           color: Colors.white,
              //                           shape: OvalBorder(
              //                             side: BorderSide(
              //                                 width: 2,
              //                                 color: Color(0xFFF27121)),
              //                           ),
              //                         ),
              //                       ),
              //                     ),
              //                     Positioned(
              //                       left: 1.23,
              //                       top: 1.23,
              //                       child: Container(
              //                         width: 14.77,
              //                         height: 14.77,
              //                         decoration: const ShapeDecoration(
              //                           image: DecorationImage(
              //                             image: NetworkImage(
              //                                 "https://via.placeholder.com/15x15"),
              //                             fit: BoxFit.cover,
              //                           ),
              //                           shape: OvalBorder(),
              //                         ),
              //                       ),
              //                     ),
              //                   ],
              //                 ),
              //               ),
              //             ),
              //             const Positioned(
              //               left: 60,
              //               top: 6,
              //               child: Text(
              //                 '250',
              //                 style: TextStyle(
              //                   color: Colors.black,
              //                   fontSize: 10,
              //                   fontFamily: 'Sofia Pro',
              //                   fontWeight: FontWeight.w400,
              //                   height: 0,
              //                   letterSpacing: 0.50,
              //                 ),
              //               ),
              //             ),
              //           ],
              //         ),
              //       )
              //     ],
              //   ),
              // ),
            ),
            body: Padding(
              padding: const EdgeInsets.only(
                top: 20.0,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AudioRoom(
                    room: widget.room,
                  ),
                  Expanded(
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        return LiveChatBuilder(
                          builder: (ctx, messages) {
                            messages = messages.reversed.toList();
                            return SizedBox(
                              height: constraints.maxHeight,
                              width: constraints.maxWidth * 4 / 5,
                              child: ListView.separated(
                                separatorBuilder: (ctx, index) =>
                                    const SizedBox(height: 5),
                                reverse: true,
                                itemCount: messages.length,
                                itemBuilder: (ctx, index) {
                                  final String message =
                                      messages[index]['message'] ?? "Error";
                                  final userData = messages[index]['userData'];
                                  final photo = userData['photo'];
                                  return ListTile(
                                    dense: true,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                    minVerticalPadding: 0,
                                    tileColor: Colors.black38,
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
                                      text: TextSpan(children: [
                                        TextSpan(
                                          text: "${userData['name']}: ",
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        TextSpan(
                                          text: message,
                                          style: const TextStyle(
                                            color: Colors.white,
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
                  ),
                ],
              ),
            ),
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
                        suffixIcon: Image.asset('assets/smile.png'),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: width / 30,
                          vertical: height / 100,
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    style: IconButton.styleFrom(
                      backgroundColor: Colors.black12,
                    ),
                    onPressed: () {
                      shareRoomLink(widget.room.id);
                    },
                    icon: Image.asset(
                      'assets/Send1.png',
                      height: 20.sp,
                    ),
                  ),
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
                  // Offstage(
                  //   offstage: !emojiShowing,
                  //   child: SizedBox(
                  //     height: 250,
                  //     child: EmojiKeyboard(
                  //       emotionController: _controller,
                  //       showEmojiKeyboard: emojiShowing,
                  //       darkMode: true,
                  //     )
                  //   ),
                  // ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class AudioUserTile extends StatefulWidget {
  final String name;
  final String? frame;
  final void Function()? onTap;
  final String? imgUrl;
  const AudioUserTile(
      {super.key, required this.name, this.onTap, this.imgUrl, this.frame});

  @override
  State<AudioUserTile> createState() => _AudioUserTileState();
}

class _AudioUserTileState extends State<AudioUserTile> {
  bool isMuted = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          style: IconButton.styleFrom(
            padding: EdgeInsets.zero,
            tapTargetSize: MaterialTapTargetSize.padded,
          ),
          onPressed: () {
            if (widget.onTap != null) {
              widget.onTap!();
              setState(() {
                isMuted = !isMuted;
              });
            }
          },
          icon: widget.imgUrl == null || widget.imgUrl!.isEmpty
              ? Container(
                  color: Colors.transparent,
                  child: Icon(
                    (isMuted
                        ? Icons.mic_off_outlined
                        : Icons.mic_none_outlined),
                    color: colorScheme(context).primary,
                  ),
                )
              : Container(
                  height: 70.sp,
                  width: 70.sp,
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: CircleAvatar(
                    backgroundColor: Colors.transparent,
                    foregroundImage:
                        (widget.frame == "1" || widget.frame == "2")
                            ? ((widget.frame == "1")
                                ? const AssetImage('assets/Frame 1.png')
                                : const AssetImage('assets/Frame 2.png'))
                            : null,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 9, left: 5, right: 9),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Image(
                          image: NetworkImage(widget.imgUrl!),
                          fit: BoxFit.cover,
                          // alignment: Alignment.center,
                        ),
                      ),
                    ),
                  ),
                ),
          // radius: 20,
          // NetworkImage(
          //   widget.imgUrl!,
          // ),
          // radius: 15,
          // foregroundImage:
          //     (widget.frame == "1" || widget.frame == "2")
          //         ? ((widget.frame == "1")
          //             ? const AssetImage('assets/Frame 1.png')
          //             : const AssetImage('assets/Frame 2.png'))
          //         : NetworkImage(widget.imgUrl!) as ImageProvider,
          // radius: 20,
          // child: CircleAvatar(
          //   backgroundColor: Colors.transparent,
          //   foregroundColor: Colors.transparent,
          //   backgroundImage: NetworkImage(widget.imgUrl!),
          //   radius: 25,
          // ),

          // child: CircleAvatar(
          //     backgroundColor: Colors.transparent,
          //     foregroundColor: Colors.transparent,
          //     foregroundImage: (widget.frame == "1" || widget.frame == "2")
          //         ? ((widget.frame == "1")
          //             ? const AssetImage('assets/Frame 1.png')
          //             : const AssetImage('assets/Frame 2.png'))
          //         : NetworkImage(widget.imgUrl!) as ImageProvider,
          //     radius: 25,
          //     backgroundImage: NetworkImage(
          //       widget.imgUrl!,
          //     ),
          //     // child: CircleAvatar(
          //     //   backgroundColor: Colors.transparent,
          //     //   foregroundColor: Colors.transparent,
          //     //   backgroundImage: NetworkImage(widget.imgUrl!),
          //     //   radius: 25,
          //     // ),
          //   ),
        ),
        // AnimateIcon(
        //   onTap: () {
        //     if (widget.onTap != null) {
        //       widget.onTap!();
        //       setState(() {
        //         isMuted = !isMuted;
        //       });
        //     }
        //   },
        //   width: 40,
        //   height: 20,
        //   color: Colors.white,
        //   iconType: IconType.continueAnimation,
        //   animateIcon: AnimateIcons.loading3,
        // ),
        FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            widget.name.isEmpty ? "Name is empty" : widget.name,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
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
      return AlertDialog(
        title: const Text('Confirmation'),
        content: const Text('Do you want to close?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).pop();
            },
            child: const Text('Yes'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('No'),
          ),
        ],
      );
    },
  );
}

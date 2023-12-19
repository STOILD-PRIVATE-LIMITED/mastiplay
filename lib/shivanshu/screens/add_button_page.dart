import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:spinner_try/shivanshu/models/globals.dart';
import 'package:spinner_try/shivanshu/models/room.dart';
import 'package:spinner_try/shivanshu/screens/audio_page.dart';
import 'package:spinner_try/shivanshu/screens/live_video_room.dart';
import 'package:spinner_try/shivanshu/utils.dart';
import 'package:spinner_try/shivanshu/utils/image.dart';
import 'package:spinner_try/shivanshu/utils/loading_icon_button.dart';
import 'package:spinner_try/shivanshu/widgets/tab_view.dart';
import 'package:spinner_try/webRTC/video_room.dart';

class AddButtonPage extends StatefulWidget {
  final int selectedIndex;
  final String? roomID;
  const AddButtonPage({
    super.key,
    this.selectedIndex = 0,
    this.roomID,
  });

  @override
  State<AddButtonPage> createState() => _AddButtonPageState();
}

class _AddButtonPageState extends State<AddButtonPage> {
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    if (widget.selectedIndex == 0) {
      roomIdController.text = widget.roomID ?? "";
    } else {
      audioIdController.text = widget.roomID ?? "";
    }
    WidgetsBinding.instance.addPostFrameCallback((_) =>
        _pageViewController.animateToPage(widget.selectedIndex,
            duration: const Duration(milliseconds: 300), curve: Curves.easeIn));
  }

  final PageController _pageViewController = PageController();
  TextEditingController roomIdController = TextEditingController();
  TextEditingController roomNameController = TextEditingController();
  TextEditingController audioIdController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: LoadingIconButton(
        onPressed: () async {
          if (roomNameController.text.isEmpty &&
              roomIdController.text.isEmpty) {
            showMsg(
                context, 'Room name can\'t be empty when creating a new room');
            return;
          }
          await joinRoom();
        },
        style: IconButton.styleFrom(
          backgroundColor: const Color.fromARGB(255, 224, 93, 211),
          iconSize: 40,
          minimumSize: const Size(50, 50),
        ),
        icon: Text(
          'Go',
          style: textTheme(context).titleLarge!.copyWith(
                color: colorScheme(context).onPrimary,
                fontWeight: FontWeight.bold,
              ),
        ),
      ),
      body: SafeArea(
        child: Stack(
          alignment: Alignment.topLeft,
          children: [
            PageView(
              controller: _pageViewController,
              onPageChanged: (i) {
                setState(() {
                  selectedIndex = i;
                });
              },
              children: [
                LiveVideoRoomPage(
                  controller: roomIdController,
                  nameController: roomNameController,
                  onChanged: changeImage,
                ),
                LiveVideoRoomPage(
                  showVideoButton: false,
                  controller: audioIdController,
                  nameController: roomNameController,
                  onChanged: changeImage,
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                style: IconButton.styleFrom(
                    elevation: 5,
                    shadowColor: Colors.black,
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    )),
                icon: const Icon(Icons.keyboard_arrow_left_rounded),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 20.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TabView(
              key: UniqueKey(),
              underline: false,
              separation: const SizedBox(width: 15),
              defaultSelected: selectedIndex,
              items: [
                Image.asset('assets/live_grey.png'),
                Image.asset('assets/audio_grey.png'),
              ],
              selectedItems: [
                Padding(
                  padding: EdgeInsets.only(left: selectedIndex == 0 ? 75.0 : 0),
                  child: Image.asset('assets/live.png'),
                ),
                Padding(
                  padding:
                      EdgeInsets.only(right: selectedIndex == 1 ? 27.0 : 0),
                  child: Image.asset('assets/audio.png'),
                ),
              ],
              onTap: (index) {
                setState(() {
                  selectedIndex = index;
                });
                _pageViewController.animateToPage(
                  index,
                  duration: const Duration(milliseconds: 400),
                  curve: Curves.easeInOut,
                );
              },
            )
          ],
        ),
      ),
    );
  }

  Future<void> joinRoom([Room? room]) async {
    String enteredRoomID = room?.id ?? "";
    if (room == null) {
      enteredRoomID =
          selectedIndex == 0 ? roomIdController.text : audioIdController.text;
      audioIdController.text = audioIdController.text.trim();
      roomIdController.text = roomIdController.text.trim();
      if (FirebaseAuth.instance.currentUser == null) {
        showMsg(context, 'You are\'nt logged in yet.');
        return;
      }
      if (FirebaseAuth.instance.currentUser!.email == null) {
        showMsg(context,
            'You do not posses an email. An email is required to join/create a room');
        return;
      }
      assert(
          roomNameController.text.isNotEmpty, "Room name shouldn't be empty");
      room = Room(
          roomType: selectedIndex == 0 ? RoomType.video : RoomType.audio,
          name: roomNameController.text);
    }
    try {
      if (enteredRoomID.isEmpty) {
        try {
          await room.create();
        } catch (e) {
          if (e.toString().contains("You already have a room!") &&
              context.mounted) {
            showMsg(context, 'You already have a room!');
            askUser(context, 'Do you want to join your previous room?',
                description: 'You cannot create 2 rooms at the same time.',
                yes: true,
                cancel: true,
                custom: {
                  "delete previous":
                      const Icon(Icons.delete, color: Colors.red),
                }).then((response) {
              if (response == 'yes') {
                if (room!.roomType == RoomType.audio && selectedIndex == 0) {
                  showMsg(context,
                      'You cannot join an audio room as a video room.');
                  return;
                } else if (room.roomType == RoomType.video &&
                    selectedIndex == 1) {
                  showMsg(context,
                      'You cannot join a video room as an audio room.');
                  return;
                }
                joinRoom(room);
              } else if (response == 'delete previous') {
                room!.delete().then((value) {
                  if (context.mounted) {
                    showMsg(context, "Room deleted successfully!");
                  }
                });
              }
            });
            return;
          } else {
            rethrow;
          }
        }
      } else {
        room.id = enteredRoomID;
        await room.fetch();
        if (context.mounted) {
          if (room.roomType == RoomType.audio && selectedIndex == 0) {
            showMsg(context, 'You cannot join an audio room as a video room.');
            return;
          } else if (room.roomType == RoomType.video && selectedIndex == 1) {
            showMsg(context, 'You cannot join a video room as an audio room.');
            return;
          }
        }
      }
    } catch (e) {
      if (context.mounted) {
        if (e.toString().contains("Document doesn't exist")) {
          showMsg(context, 'Room $enteredRoomID doesn\'t exist');
        } else {
          showMsg(context, 'Error: $e');
        }
      }
      return;
    }
    String? url;
    if (image != null) {
      url =
          await uploadImage(context, image!, 'rooms', auth.currentUser!.email!);
    }
    if (context.mounted) {
      if (selectedIndex == 0) {
        navigatorPush(
          context,
          VideoRoom(
            url: url,
            room: room,
          ),
        );
      } else {
        await navigatorPush(
          context,
          AudioPage(
            url: url,
            room: room,
          ),
        );
      }
    }
  }

  File? image;
  void changeImage(File? newImg) {
    image = newImg;
  }
}

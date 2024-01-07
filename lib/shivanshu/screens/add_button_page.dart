import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:spinner_try/shivanshu/models/globals.dart';
import 'package:spinner_try/shivanshu/models/room.dart';
import 'package:spinner_try/shivanshu/models/settings.dart';
import 'package:spinner_try/shivanshu/models/webRTC/new_audio_room.dart';
import 'package:spinner_try/shivanshu/screens/audio_page.dart';
import 'package:spinner_try/shivanshu/screens/live_video_room.dart';
import 'package:spinner_try/shivanshu/utils.dart';
import 'package:spinner_try/shivanshu/utils/image.dart';
import 'package:spinner_try/shivanshu/utils/loading_icon_button.dart';
import 'package:spinner_try/shivanshu/widgets/tab_view.dart';
import 'package:spinner_try/webRTC/video_room.dart';

class AddButtonPage extends StatefulWidget {
  final String email;
  const AddButtonPage({super.key, required this.email});

  @override
  State<AddButtonPage> createState() => _AddButtonPageState();
}

class _AddButtonPageState extends State<AddButtonPage> {
  int selectedIndex = 0;
  final PageController _pageViewController = PageController();
  TextEditingController roomNameController = TextEditingController();
  File? image;
  Room? room;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    roomNameController.text = PrefStorage.myRoomName ?? "";
    _fetchMyRoomDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: LoadingIconButton(
        key: ValueKey("AddPageFloatingActionButton:$_isLoading"),
        loading: _isLoading ? true : null,
        onPressed: () async {
          if (roomNameController.text.isEmpty) {
            showMsg(
                context, 'Room name can\'t be empty when creating a new room');
            return;
          }
          await joinMyRoom();
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
                  nameController: roomNameController,
                  onChanged: changeImage,
                ),
                LiveVideoRoomPage(
                  showVideoButton: false,
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

  Future<void> joinMyRoom() async {
    if (roomNameController.text.isEmpty) {
      showMsg(context, 'Room Name can\'t be empty');
      return;
    }
    if (room == null) {
      room = Room(
        name: roomNameController.text,
        roomType: selectedIndex == 0 ? RoomType.video : RoomType.audio,
        imgUrl: image == null
            ? null
            : await uploadImage(
                context, image!, 'rooms', auth.currentUser!.email!),
      );
      await room!.create();
      image = null;
      PrefStorage.myRoomName = room!.name;
      PrefStorage.myRoomUrl = room!.imgUrl;
    } else {
      room!.name = roomNameController.text;
      room!.roomType = selectedIndex == 0 ? RoomType.video : RoomType.audio;
      PrefStorage.myRoomName = room!.name;
      PrefStorage.myRoomUrl = room!.imgUrl;
      await room!.update();
    }
    // Navigating to the required page
    if (context.mounted) {
      if (selectedIndex == 0) {
        navigatorPush(
          context,
          VideoRoom(
            room: room!,
          ),
        );
      } else {
        await navigatorPush(
          context,
          // AudioPage(
          //   room: room!,
          // ),
          NewAudioRoom(room: room!)
        );
      }
    }
  }

  Future<File?> changeImage(File? newImg) async {
    newImg = image = await cropImage(context, newImg);
    if (image == null) return null;
    if (room != null) {
      if (context.mounted) {
        room!.imgUrl = await uploadImage(
            context, image!, 'rooms', auth.currentUser!.email!);
      }
      PrefStorage.myRoomUrl = room!.imgUrl;
      await room!.update();
      image = null;
    }
    return newImg;
  }

  Future<Room?> _fetchMyRoomDetails() async {
    setState(() {
      _isLoading = true;
    });
    try {
      room = await getMyRoom();
      if (room != null) {
        roomNameController.text = room!.name;
        PrefStorage.myRoomName = room!.name;
        PrefStorage.myRoomUrl = room!.imgUrl;
        log("This user has a room: ${room!.toJson()}");
      } else {
        log("This user does not have a room");
      }
    } catch (e) {
      log("error fetching room details: $e");
      if (context.mounted) showMsg(context, e.toString());
    }
    setState(() {
      _isLoading = false;
    });
    return room;
  }
}

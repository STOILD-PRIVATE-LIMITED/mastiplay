
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:spinner_try/shivanshu/models/firestore/firestore_document.dart';
import 'package:spinner_try/shivanshu/models/globals.dart';

enum RoomType {
  audio,
  video,
}

class Room extends FirestoreDocument {
  static const firestorePath = 'rooms/';
  String? admin; // userId of admin
  bool askBeforeJoining = false; // default is a public room
  late RoomType roomType;

  Room({
    this.admin,
    required this.roomType,
    this.askBeforeJoining = false,
  }) : super(path: Room.firestorePath);

  @override
  void loadFromJson(Map<String, dynamic> data) {
    super.loadFromJson(data);
    id = data['id'] ?? id;
    admin = data['admin'] ?? admin;
    roomType = RoomType.values[data['roomType'] ?? roomType.index];
    askBeforeJoining = data['askBeforeJoining'] ?? askBeforeJoining;
  }

  @override
  Map<String, dynamic> toJson() {
    return super.toJson()
      ..addAll({
        "admin": admin,
        "askBeforeJoining": askBeforeJoining,
        "roomType": roomType.index,
      });
  }

  @override
  Future<FirestoreDocument> fetch() async {
    await super.fetch();
    loadFromJson(super.data);
    return this;
  }

  Future<void> create() async {
    admin = FirebaseAuth.instance.currentUser!.email!;
    Room? myRoom = await getMyRoom();
    if (myRoom == null) {
      super.data = toJson();
      id = await randomSet(this);
      // await add();
    } else {
      loadFromJson(myRoom.toJson());
      id = myRoom.id;
      throw Exception("You already have a room!");
    }
  }

  @override
  Future<void> update() {
    assert(id.isNotEmpty,
        "Id shouldn't be empty when updating data on firestore, instead use Room.create() to create a new room!");
    super.data = toJson();
    return super.update();
  }
}

// Fetches a room where you're the admin
Future<Room?> getMyRoom() async {
  final room = Room(roomType: RoomType.audio);
  final snapshot = await firestore
      .collection(Room.firestorePath)
      .where('admin', isEqualTo: auth.currentUser!.email!)
      .get();
  if (snapshot.docs.isEmpty) {
    return null;
  }
  room.loadFromJson(snapshot.docs.first.data());
  room.id = snapshot.docs.first.id;
  return room;
}

class Timer extends StatefulWidget {
  DateTime? startTime;
  TextStyle? style;
  Timer({super.key, this.startTime, this.style});

  @override
  State<Timer> createState() => _TimerState();
}

class _TimerState extends State<Timer> {
  bool stopCountDown = false;

  @override
  void initState() {
    super.initState();
    widget.startTime = widget.startTime ?? DateTime.now();
    startCountDown();
  }

  @override
  void dispose() {
    super.dispose();
    stopCountDown = true;
  }

  @override
  Widget build(BuildContext context) {
    final sec =
        DateTime.now().difference(widget.startTime ?? DateTime.now()).inSeconds;
    return Text(
      "${sec >= 3600 * 24 ? '${sec ~/ (3600 * 24)}:' : ''}${sec >= 3600 ? '${sec ~/ 3600}:' : ''}${(sec ~/ 60) % 60}:${sec % 60}",
      style: widget.style,
    );
  }

  void startCountDown() async {
    await Future.delayed(const Duration(seconds: 1));
    if (!stopCountDown && context.mounted) {
      setState(() {});
    } else {
      return;
    }
    startCountDown();
  }
}

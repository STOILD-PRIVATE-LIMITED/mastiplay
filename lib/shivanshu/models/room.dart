import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:spinner_try/shivanshu/models/globals.dart';

enum RoomType {
  audio,
  video,
}

class Room {
  String id;
  String? admin; // userId of admin
  bool askBeforeJoining = false; // default is a public room
  late RoomType roomType;
  String name = "";
  String? imgUrl;
  String? announcement;
  DateTime updatedAt = DateTime.now();
  DateTime createdAt = DateTime.now();

  Room({
    this.id = "",
    this.admin,
    this.announcement,
    this.name = "",
    required this.roomType,
    this.imgUrl,
    this.askBeforeJoining = false,
    DateTime? updatedAt,
    DateTime? createdAt,
    List<String>? seatUsers,
  }) {
    this.updatedAt = updatedAt ?? this.updatedAt;
    this.createdAt = createdAt ?? this.createdAt;
  }

  void loadFromJson(Map<String, dynamic> data) {
    updatedAt = data['updatedAt'] == null
        ? updatedAt
        : DateTime.parse(data['updatedAt']);
    createdAt = data['createdAt'] == null
        ? createdAt
        : DateTime.parse(data['createdAt']);
    id = data['id'] ?? id;
    name = data['name'] ?? name;
    imgUrl = data['imgUrl'] ?? imgUrl;
    admin = data['admin'] ?? admin;
    announcement = data['announcement'] ?? announcement;
    roomType = RoomType.values[data['roomType'] ?? roomType.index];
    askBeforeJoining = data['askBeforeJoining'] ?? askBeforeJoining;
  }

  Map<String, dynamic> toJson() {
    return {
      'updatedAt': updatedAt.toIso8601String(),
      "admin": admin,
      "name": name,
      "imgUrl": imgUrl,
      "askBeforeJoining": askBeforeJoining,
      "announcement": announcement,
      "roomType": roomType.index,
    };
  }

  Future<Room> fetch() async {
    final response =
        await http.get(Uri.parse('$websocketUrl/api/rooms?id=$id'));
    if (response.statusCode != 200) {
      throw Exception(response.body);
    }
    loadFromJson(json.decode(response.body));
    return this;
  }

  Future<void> create() async {
    admin = currentUser.id;
    Room? myRoom = await getMyRoom();
    if (myRoom == null) {
      final response = await http.post(
        Uri.parse('$websocketUrl/api/rooms'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(toJson()),
      );
      if (response.statusCode != 200) {
        throw Exception(response.body);
      }
      loadFromJson(json.decode(response.body));
    } else {
      loadFromJson(myRoom.toJson());
      id = myRoom.id;
      throw Exception("You already have a room!");
    }
  }

  Future<void> update() async {
    assert(id.isNotEmpty, "Id shouldn't be empty when updating a room");
    final response = await http.post(
      Uri.parse('$websocketUrl/api/update-room'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
        toJson(),
      ),
    );
    if (response.statusCode != 200) {
      throw Exception(response.body);
    }
  }
}

// Fetches a room where you're the admin
Future<Room?> getMyRoom() async {
  final response = await http.get(
    Uri.parse('$websocketUrl/api/rooms?userId=${currentUser.id}'),
  );
  if (response.statusCode == 404) {
    return null;
  } else if (response.statusCode != 200) {
    throw Exception(response.body);
  }
  return Room(
    id: "",
    roomType: RoomType.audio,
  )..loadFromJson(json.decode(response.body));
}

Future<List<Room>> getAllRooms(int limit, int start) async {
  final response = await http.get(
    Uri.parse('$websocketUrl/api/rooms/all?limit=$limit&start=$start'),
  );
  if (response.statusCode != 200) {
    throw Exception(response.body);
  }
  List<Room> rooms = [];
  for (var room in json.decode(response.body)) {
    rooms.add(Room(
      id: "",
      roomType: RoomType.audio,
    )..loadFromJson(room));
  }
  return rooms;
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

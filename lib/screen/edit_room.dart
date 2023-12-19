import 'package:flutter/material.dart';

class EditRoom extends StatefulWidget {
  const EditRoom({super.key});

  @override
  State<EditRoom> createState() => _EditRoomState();
}

class _EditRoomState extends State<EditRoom> {
  TextEditingController roomNameController = TextEditingController();
  TextEditingController announcementController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            height: height / 1.3,
            width: width,
            padding: EdgeInsets.symmetric(
                horizontal: width / 30, vertical: height / 40),
            decoration: const BoxDecoration(
              color: Color(0xFFCEC3C3),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Edit Room",
                    style: TextStyle(
                        fontSize: height / 40, fontWeight: FontWeight.bold),
                  ),
                ),
                const Align(
                    alignment: Alignment.center, child: Icon(Icons.abc)),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Edit room photo",
                    style: TextStyle(
                      fontSize: height / 40,
                    ),
                  ),
                ),
                SizedBox(
                  height: height / 40,
                ),
                Text(
                  "Room Name",
                  style: TextStyle(
                    fontSize: height / 50,
                  ),
                ),
                SizedBox(
                  height: height / 100,
                ),
                Container(
                  width: width,
                  height: height / 15,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: TextFormField(
                    controller: roomNameController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Enter room name",
                      hintStyle: TextStyle(
                        fontSize: height / 50,
                      ),
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: width / 30, vertical: height / 100),
                    ),
                  ),
                ),
                SizedBox(
                  height: height / 40,
                ),
                Text(
                  "Announcement",
                  style: TextStyle(
                    fontSize: height / 50,
                  ),
                ),
                SizedBox(
                  height: height / 100,
                ),
                Container(
                  width: width,
                  height: height / 15,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: TextFormField(
                    controller: announcementController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Enter announcement",
                      hintStyle: TextStyle(
                        fontSize: height / 50,
                      ),
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: width / 30, vertical: height / 100),
                    ),
                  ),
                ),
                SizedBox(
                  height: height / 40,
                ),
                Text(
                  "Number of Mic",
                  style: TextStyle(
                    fontSize: height / 50,
                  ),
                ),
                SizedBox(
                  height: height / 100,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      width: width / 5,
                      height: height / 20,
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        "5 mic",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: height / 40,
                        ),
                      ),
                    ),
                    Container(
                      width: width / 5,
                      height: height / 20,
                      decoration: BoxDecoration(
                        color: Colors.grey[800],
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: Colors.white,
                        ),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        "8 mic",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: height / 40,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: height / 40,
                ),
                Text(
                  "Take mic mode",
                  style: TextStyle(
                    fontSize: height / 50,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      width: width / 4,
                      height: height / 20,
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        "Free mode",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: height / 50,
                        ),
                      ),
                    ),
                    Container(
                      width: width / 4,
                      height: height / 20,
                      decoration: BoxDecoration(
                        color: Colors.grey[800],
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: Colors.white,
                        ),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        "Apply mode",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: height / 50,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: height / 40,
                ),
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    width: width / 2,
                    height: height / 15,
                    decoration: BoxDecoration(
                      color: Colors.grey[800],
                      borderRadius: BorderRadius.circular(30),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      "Submit",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: height / 40,
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

class MyRoom extends StatefulWidget {
  const MyRoom({super.key});

  @override
  State<MyRoom> createState() => _MyRoomState();
}

class _MyRoomState extends State<MyRoom> {
  int currentIndex = 0;
  PageController pageController = PageController(initialPage: 0);
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(height / 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      height: height / 20,
                      width: width / 10,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 0.5,
                            blurRadius: 7,
                            offset: const Offset(0, 3),
                          ),
                        ],
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                      ),
                      child: const Icon(
                        Icons.arrow_back_ios_new,
                        color: Colors.black,
                        size: 12,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        currentIndex = 0;
                        pageController.animateToPage(0,
                            duration: const Duration(milliseconds: 100),
                            curve: Curves.fastEaseInToSlowEaseOut);
                      });
                    },
                    child: currentIndex == 0
                        ? Stack(
                            alignment: Alignment.center,
                            children: [
                              Text(
                                'My Room',
                                style: TextStyle(
                                    fontSize: height /
                                        40, // Adjust the font size as needed
                                    fontWeight: FontWeight.bold,
                                    // Adjust the font weight as needed
                                    letterSpacing: 1),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: height / 30),
                                height: height / 200,
                                width: width / 8,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: const Color(0xFFE05DD3),
                                ),
                              ),
                            ],
                          )
                        : Text("My Room",
                            style: TextStyle(
                                fontSize: height / 50,
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1)),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        currentIndex = 1;
                        pageController.animateToPage(1,
                            duration: const Duration(milliseconds: 100),
                            curve: Curves.fastEaseInToSlowEaseOut);
                      });
                    },
                    child: currentIndex == 1
                        ? Stack(
                            alignment: Alignment.center,
                            children: [
                              Text(
                                'Recent Room',
                                style: TextStyle(
                                    fontSize: height /
                                        40, // Adjust the font size as needed
                                    fontWeight: FontWeight.bold,
                                    letterSpacing:
                                        1 // Adjust the font weight as needed
                                    ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: height / 30),
                                height: height / 200,
                                width: width / 6,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: const Color(0xFFE05DD3),
                                ),
                              ),
                            ],
                          )
                        : Text(
                            "Recent Room",
                            style: TextStyle(
                                fontSize: height / 50,
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1),
                          ),
                  ),
                ],
              ),
              SizedBox(
                height: height / 20,
              ),
              Expanded(
                child: PageView(
                  controller: pageController,
                  onPageChanged: (index) {
                    currentIndex = index;
                    pageController.animateToPage(currentIndex,
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.fastEaseInToSlowEaseOut);
                  },
                  children: [
                    RoomScreen(width: width, height: height),
                    RecentRoom(width: width, height: height)
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class RoomScreen extends StatefulWidget {
  const RoomScreen({
    super.key,
    required this.width,
    required this.height,
  });

  final double width;
  final double height;

  @override
  State<RoomScreen> createState() => _RoomScreenState();
}

class _RoomScreenState extends State<RoomScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: widget.width / 20),
          child: Text(
            "My Room",
            style: TextStyle(
              fontSize: widget.height / 50,
              color: Colors.grey,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        ListTile(
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Image.network(
              'https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg',
              width: widget.width / 5,
            ),
          ),
          title: Text(
            "FARMER",
            style: TextStyle(
                fontSize: widget.height / 50, fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            "Room Description",
            style: TextStyle(
              fontSize: widget.height / 60,
              color: Colors.grey,
            ),
          ),
        ),
        Padding(
          padding:
              EdgeInsets.only(left: widget.width / 20, top: widget.height / 50),
          child: Text(
            "Join Room",
            style: TextStyle(
                fontSize: widget.height / 50,
                color: Colors.grey,
                fontWeight: FontWeight.w600),
          ),
        ),
        Expanded(
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: 10,
            itemBuilder: (context, index) {
              return ListTile(
                leading: const CircleAvatar(
                  backgroundImage: NetworkImage(
                      'https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg',
                      scale: 5),
                ),
                title: Text(
                  "FARMER",
                  style: TextStyle(
                      fontSize: widget.height / 50,
                      fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  "ID: Room Description",
                  style: TextStyle(
                    fontSize: widget.height / 60,
                    color: Colors.grey,
                  ),
                ),
              );
            },
          ),
        )
      ],
    );
  }
}

class RecentRoom extends StatefulWidget {
  final double width;
  final double height;
  const RecentRoom({super.key, required this.width, required this.height});

  @override
  State<RecentRoom> createState() => _RecentRoomState();
}

class _RecentRoomState extends State<RecentRoom> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: 10,
            itemBuilder: (context, index) {
              return ListTile(
                leading: const CircleAvatar(
                  backgroundImage: NetworkImage(
                      'https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg',
                      scale: 5),
                ),
                title: Text(
                  "FARMER",
                  style: TextStyle(
                      fontSize: widget.height / 50,
                      fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  "ID: Room Description",
                  style: TextStyle(
                    fontSize: widget.height / 60,
                    color: Colors.grey,
                  ),
                ),
              );
            },
          ),
        )
      ],
    );
  }
}

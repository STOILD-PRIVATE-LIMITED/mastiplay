import 'package:flutter/material.dart';
import 'package:flutter_octicons/flutter_octicons.dart';

class RoomAdmin extends StatefulWidget {
  const RoomAdmin({super.key});

  @override
  State<RoomAdmin> createState() => _RoomAdminState();
}

class _RoomAdminState extends State<RoomAdmin> {
  int itemCount = 15;
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        title: Text(
          "RoomAdmin",
          style: TextStyle(fontSize: height / 30),
        ),
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios,
            size: height / 40,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(OctIcons.question_24),
          )
        ],
      ),
      body: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: width / 30, vertical: height / 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.center,
              child: Text(
                "RoomAdmin Number: $itemCount/$itemCount",
                style: TextStyle(
                  fontSize: height / 50,
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: itemCount,
                itemBuilder: (context, index) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: width / 10,
                            height: height / 20,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Icon(
                              Icons.mic,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(
                            width: width / 30,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "User Name",
                                style: TextStyle(
                                  fontSize: height / 50,
                                ),
                              ),
                              SizedBox(
                                height: height / 100,
                              ),
                              Container(
                                height: height / 30,
                                width: width / 4,
                                decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                alignment: Alignment.center,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.abc,
                                      color: Colors.white,
                                    ),
                                    SizedBox(
                                      width: width / 100,
                                    ),
                                    Text(
                                      "User ID",
                                      style: TextStyle(
                                        fontSize: height / 60,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Container(
                          width: width / 4,
                          height: height / 20,
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const CircleAvatar(
                                radius: 10,
                                backgroundColor: Colors.red,
                                child: Icon(
                                  Icons.remove,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ),
                              SizedBox(
                                width: width / 100,
                              ),
                              const Text("Remove")
                            ],
                          ))
                    ],
                  );
                  // return ListTile(
                  //   leading: Container(
                  //     width: width / 10,
                  //     height: height / 20,
                  //     decoration: BoxDecoration(
                  //       color: Colors.white,
                  //       borderRadius: BorderRadius.circular(20),
                  //     ),
                  //     child: const Icon(
                  //       Icons.mic,
                  //       color: Colors.black,
                  //     ),
                  //   ),
                  //   title: Text(
                  //     "User Name",
                  //     style: TextStyle(
                  //       fontSize: height / 50,
                  //     ),
                  //   ),
                  //   subtitle: Container(
                  //     height: height / 30,
                  //     width: width / 50,
                  //     decoration: BoxDecoration(
                  //       color: Colors.blue,
                  //       borderRadius: BorderRadius.circular(20),
                  //     ),
                  //     alignment: Alignment.center,
                  //     child: Text(
                  //       "User ID",
                  //       style: TextStyle(
                  //         fontSize: height / 60,
                  //         color: Colors.white,
                  //       ),
                  //     ),
                  //   ),
                  //   trailing: IconButton(
                  //     onPressed: () {},
                  //     icon: const Icon(
                  //       Icons.more_vert,
                  //       color: Colors.black,
                  //     ),
                  //   ),
                  // );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

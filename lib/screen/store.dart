import 'package:flutter/material.dart';

class Store extends StatefulWidget {
  const Store({super.key});

  @override
  State<Store> createState() => _StoreState();
}

class _StoreState extends State<Store> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        backgroundColor: const Color(0xFFf7f8fc),
        appBar: AppBar(
          backgroundColor: const Color(0xFFf7f8fc),
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back_ios,
              size: height / 40,
            ),
          ),
          title: Text(
            "Store",
            style: TextStyle(fontSize: height / 40),
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: width / 30),
          child: Column(
            children: [
              TabBar(
                labelColor: Colors.white,
                dividerColor: Colors.white,
                indicator: const BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                  color: Colors.grey,
                ),
                tabs: [
                  Container(
                    height: height / 20,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      "Entry",
                      style:
                          TextStyle(color: Colors.black, fontSize: height / 60),
                    ),
                  ),
                  Container(
                    height: height / 20,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      "Frame",
                      style:
                          TextStyle(color: Colors.black, fontSize: height / 60),
                    ),
                  ),
                  Container(
                    height: height / 20,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      "Chat Bubble",
                      style:
                          TextStyle(color: Colors.black, fontSize: height / 65),
                    ),
                  ),
                  Container(
                    height: height / 20,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      "Theme",
                      style:
                          TextStyle(color: Colors.black, fontSize: height / 60),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    GridView.count(
                      crossAxisCount: 2,
                      crossAxisSpacing: 50.0,
                      shrinkWrap: true,
                      children: List.generate(
                        4,
                        (index) {
                          return Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(20.0),
                                    ),
                                    color: Colors.grey[100]),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.abc,
                                      size: height / 20,
                                    ),
                                    Text(
                                      "₹10000",
                                      style: TextStyle(
                                          fontSize: height / 50,
                                          color: Colors.grey),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Icon(
                                          Icons.diamond,
                                          color: Colors.pink,
                                        ),
                                        Text(
                                          "96000",
                                          style: TextStyle(
                                              fontSize: height / 40,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ],
                                )),
                          );
                        },
                      ),
                    ),
                    GridView.count(
                      crossAxisCount: 2,
                      crossAxisSpacing: 50.0,
                      shrinkWrap: true,
                      children: List.generate(
                        4,
                        (index) {
                          return Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(20.0),
                                    ),
                                    color: Colors.grey[100]),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.abc,
                                      size: height / 20,
                                    ),
                                    Text(
                                      "Frame Name",
                                      style: TextStyle(
                                          fontSize: height / 50,
                                          color: Colors.grey),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Icon(
                                          Icons.punch_clock_rounded,
                                          color: Colors.pink,
                                        ),
                                        Text(
                                          "0d 04h",
                                          style: TextStyle(
                                              fontSize: height / 40,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ],
                                )),
                          );
                        },
                      ),
                    ),
                    Container(
                      height: height / 2,
                      width: width,
                      color: Colors.green,
                    ),
                    Container(
                      height: height / 2,
                      width: width,
                      color: Colors.yellow,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

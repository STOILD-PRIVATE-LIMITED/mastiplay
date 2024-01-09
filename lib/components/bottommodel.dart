import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:spinner_try/components/common_elevatedButton.dart';
import 'package:spinner_try/shivanshu/utils.dart';

import '../shivanshu/models/globals.dart';
import '../user_model.dart';

class NewBottomModel extends StatefulWidget {
  final List<UserModel> users;
  const NewBottomModel({super.key, required this.users});

  @override
  State<NewBottomModel> createState() => _NewBottomModelState();
}

class _NewBottomModelState extends State<NewBottomModel> {
  String selectedValue = 'all in the room';
  List<String> value = ['all in the room', 'all on mic'];
  final List<String> categories = [
    'Hot',
    'Lucky',
    'Vip',
    'Events',
    'Couple',
    'Luxury'
  ];
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
  final List<String> hotAssest = [
    "assets/stickers/1.png",
    "assets/stickers/2.png",
    "assets/stickers/3.png",
    "assets/stickers/4.png",
    "assets/stickers/5.png",
    "assets/stickers/6.png",
    "assets/stickers/7.png",
    "assets/stickers/8.png",
    "assets/stickers/12.png",
    "assets/stickers/15.png",
    "assets/stickers/16.png",
    "assets/stickers/17.png",
    "assets/stickers/18.png",
    "assets/stickers/19.png",
  ];
  final List<String> luxuryAsset = [
    "assets/stickers/10.png",
    "assets/stickers/11.png",
    "assets/stickers/14.png",
  ];
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    final pageController = PageController(initialPage: currentPageIndex);
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: const SizedBox(
          height: 0,
          width: 0,
        ),
        centerTitle: false,
        title: Row(
          children: [
            Container(
              width: 170,
              height: 60,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: ShapeDecoration(
                color: Colors.grey,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40),
                ),
              ),
              child: ListView.builder(
                itemCount: widget.users.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Container(
                    width: 40,
                    height: 40,
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    decoration: ShapeDecoration(
                      image: DecorationImage(
                        image: NetworkImage(widget.users[index].photo.isEmpty
                            ? 'https://www.pngitem.com/pimgs/m/146-1468479_my-profile-icon-blank-profile-picture-circle-hd.png'
                            : widget.users[index].photo),
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
            Container(
              width: 70,
              alignment: Alignment.center,
              child: DropdownButton<String>(
                  isExpanded: true,
                  underline: const SizedBox(),
                  icon: Image.asset(
                    'assets/dropdownimage.png',
                    height: 10,
                  ),
                  onChanged: (String? value) {
                    setState(() {
                      selectedValue = value!;
                    });
                  },
                  items: value.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: const TextStyle(fontSize: 10),
                      ),
                    );
                  }).toList()),
            ),
          ],
        ),
        bottom: PreferredSize(
          preferredSize: Size(width, 30.sp),
          child: Row(
            key: UniqueKey(),
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                width: 258,
                height: 15,
                child: Stack(
                  children: [
                    Positioned(
                      left: 0,
                      top: 0,
                      child: currentPageIndex == 0
                          ? const Text(
                              "Hot",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontFamily: 'Sofia Pro',
                                fontWeight: FontWeight.w400,
                                height: 0,
                              ),
                            )
                          : GestureDetector(
                              onTap: () {
                                pageController.animateToPage(0,
                                    duration: const Duration(milliseconds: 500),
                                    curve: Curves.ease);
                                setState(() {
                                  currentPageIndex == 0;
                                });
                              },
                              child: const Text(
                                'Hot',
                                style: TextStyle(
                                  color: Color(0xFF9B8F8F),
                                  fontSize: 14,
                                  fontFamily: 'Sofia Pro',
                                  fontWeight: FontWeight.w400,
                                  height: 0,
                                ),
                              ),
                            ),
                    ),
                    Positioned(
                      left: 32,
                      top: 0,
                      child: currentPageIndex == 1
                          ? const Text(
                              'Lucky',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontFamily: 'Sofia Pro',
                                fontWeight: FontWeight.w400,
                                height: 0,
                              ),
                            )
                          : GestureDetector(
                              onTap: () {
                                pageController.animateToPage(1,
                                    duration: const Duration(milliseconds: 500),
                                    curve: Curves.ease);
                                setState(() {
                                  currentPageIndex == 1;
                                });
                              },
                              child: const Text(
                                'Lucky',
                                style: TextStyle(
                                  color: Color(0xFF9B8F8F),
                                  fontSize: 14,
                                  fontFamily: 'Sofia Pro',
                                  fontWeight: FontWeight.w400,
                                  height: 0,
                                ),
                              ),
                            ),
                    ),
                    Positioned(
                      left: 78,
                      top: 0,
                      child: currentPageIndex == 2
                          ? const Text(
                              'Vip',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontFamily: 'Sofia Pro',
                                fontWeight: FontWeight.w400,
                                height: 0,
                              ),
                            )
                          : GestureDetector(
                              onTap: () {
                                pageController.animateToPage(2,
                                    duration: const Duration(milliseconds: 500),
                                    curve: Curves.ease);
                                setState(() {
                                  currentPageIndex == 2;
                                });
                              },
                              child: const Text(
                                'Vip',
                                style: TextStyle(
                                  color: Color(0xFF9B8F8F),
                                  fontSize: 14,
                                  fontFamily: 'Sofia Pro',
                                  fontWeight: FontWeight.w400,
                                  height: 0,
                                ),
                              ),
                            ),
                    ),
                    Positioned(
                      left: 160,
                      top: 0,
                      child: currentPageIndex == 3
                          ? const Text(
                              'Events',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontFamily: 'Sofia Pro',
                                fontWeight: FontWeight.w400,
                                height: 0,
                              ),
                            )
                          : GestureDetector(
                              onTap: () {
                                pageController.animateToPage(3,
                                    duration: const Duration(milliseconds: 500),
                                    curve: Curves.ease);
                                setState(() {
                                  currentPageIndex == 3;
                                });
                              },
                              child: const Text(
                                'Events',
                                style: TextStyle(
                                  color: Color(0xFF9B8F8F),
                                  fontSize: 14,
                                  fontFamily: 'Sofia Pro',
                                  fontWeight: FontWeight.w400,
                                  height: 0,
                                ),
                              ),
                            ),
                    ),
                    Positioned(
                      left: 212,
                      top: 1,
                      child: currentPageIndex == 4
                          ? const Text(
                              'Couple',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontFamily: 'Sofia Pro',
                                fontWeight: FontWeight.w400,
                                height: 0,
                              ),
                            )
                          : GestureDetector(
                              onTap: () {
                                pageController.animateToPage(4,
                                    duration: const Duration(milliseconds: 500),
                                    curve: Curves.ease);
                                setState(() {
                                  currentPageIndex == 4;
                                });
                              },
                              child: const Text(
                                'Couple',
                                style: TextStyle(
                                  color: Color(0xFF9B8F8F),
                                  fontSize: 14,
                                  fontFamily: 'Sofia Pro',
                                  fontWeight: FontWeight.w400,
                                  height: 0,
                                ),
                              ),
                            ),
                    ),
                    Positioned(
                      left: 107,
                      top: 0,
                      child: currentPageIndex == 5
                          ? const Text(
                              'Luxury',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontFamily: 'Sofia Pro',
                                fontWeight: FontWeight.w400,
                                height: 0,
                              ),
                            )
                          : GestureDetector(
                              onTap: () {
                                pageController.animateToPage(5,
                                    duration: const Duration(milliseconds: 500),
                                    curve: Curves.ease);
                                setState(() {
                                  currentPageIndex == 5;
                                });
                              },
                              child: const Text(
                                'Luxury',
                                style: TextStyle(
                                  color: Color(0xFF9B8F8F),
                                  fontSize: 14,
                                  fontFamily: 'Sofia Pro',
                                  fontWeight: FontWeight.w400,
                                  height: 0,
                                ),
                              ),
                            ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Image.asset(
                "assets/shopping bag 1.png",
                height: 20,
              )
            ],
          ),
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        clipBehavior: Clip.antiAlias,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment(-0.78, -0.63),
            end: Alignment(0.78, 0.63),
            colors: [Color(0xFF3E3B6F), Color(0xE22C2B3B), Color(0xFF090909)],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 100.0, bottom: 40),
          child: PageView(
            controller: pageController,
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
  }

  double _progress = 0.0;

  void _updateProgress(double value) {
    setState(() {
      _progress = value;
    });
  }

  Widget buildPage(String category) {
    if (category == "Hot") {
      return NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification scrollInfo) {
          if (scrollInfo.metrics.axis == Axis.horizontal) {
            double maxScroll = scrollInfo.metrics.maxScrollExtent;
            double currentScroll = scrollInfo.metrics.pixels;
            double scrollPercentage = currentScroll / maxScroll;
            _updateProgress(scrollPercentage);
          }
          return false;
        },
        child: Stack(
          children: [
            GridView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.all(4.0),
                itemCount: hotAssest.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                ),
                itemBuilder: (context, index) {
                  return CommonElevatedButton(
                      image: hotAssest[index],
                      diamond: '10',
                      text: 'Hot',
                      onPressed: () {});
                }),
            Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                width: 75,
                child: LinearProgressIndicator(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  value: _progress,
                  backgroundColor: Colors.grey,
                  valueColor:
                      const AlwaysStoppedAnimation<Color>(Color(0xFFE05DD3)),
                ),
              ),
            )
          ],
        ),
      );
    }
    if (category == "Lucky") {
      return GridView.count(
          crossAxisCount: 3,
          padding: const EdgeInsets.all(4.0),
          children: [
            CommonElevatedButton(
              image: imageAssest[8],
              diamond: '10',
              text: 'Lucky',
              onPressed: () {},
            ),
            CommonElevatedButton(
              image: imageAssest[9],
              diamond: '10',
              text: 'Lucky',
              onPressed: () {},
            ),
            CommonElevatedButton(
              image: imageAssest[10],
              diamond: '10',
              text: 'Lucky',
              onPressed: () {},
            ),
            CommonElevatedButton(
              image: imageAssest[11],
              diamond: '10',
              text: 'Lucky',
              onPressed: () {},
            ),
            CommonElevatedButton(
              image: imageAssest[12],
              diamond: '10',
              text: 'Lucky',
              onPressed: () {},
            ),
            CommonElevatedButton(
              image: imageAssest[13],
              diamond: '10',
              text: 'Lucky',
              onPressed: () {},
            ),
            CommonElevatedButton(
              image: imageAssest[14],
              diamond: '10',
              text: 'Lucky',
              onPressed: () {},
            ),
            CommonElevatedButton(
              image: imageAssest[15],
              diamond: '10',
              text: 'Lucky',
              onPressed: () {},
            ),
          ]);
    }
    if (category == "Vip") {
      return GridView.count(
          crossAxisCount: 3,
          padding: const EdgeInsets.all(4.0),
          children: [
            CommonElevatedButton(
              image: imageAssest[16],
              diamond: '10',
              text: 'Vip',
              onPressed: () {},
            ),
            CommonElevatedButton(
              image: imageAssest[17],
              diamond: '10',
              text: 'Vip',
              onPressed: () {},
            ),
            CommonElevatedButton(
              image: imageAssest[18],
              diamond: '10',
              text: 'Vip',
              onPressed: () {},
            ),
            CommonElevatedButton(
              image: imageAssest[0],
              diamond: '10',
              text: 'Vip',
              onPressed: () {},
            ),
            CommonElevatedButton(
              image: imageAssest[0],
              diamond: '10',
              text: 'Vip',
              onPressed: () {},
            ),
            CommonElevatedButton(
              image: imageAssest[1],
              diamond: '10',
              text: 'Vip',
              onPressed: () {},
            ),
            CommonElevatedButton(
              image: imageAssest[2],
              diamond: '10',
              text: 'Vip',
              onPressed: () {},
            ),
            CommonElevatedButton(
              image: imageAssest[3],
              diamond: '10',
              text: 'Vip',
              onPressed: () {},
            ),
          ]);
    }
    if (category == "Events") {
      return GridView.count(
          crossAxisCount: 3,
          padding: const EdgeInsets.all(4.0),
          children: [
            CommonElevatedButton(
              image: imageAssest[4],
              diamond: '10',
              text: 'Events',
              onPressed: () {},
            ),
            CommonElevatedButton(
              image: imageAssest[5],
              diamond: '10',
              text: 'Events',
              onPressed: () {},
            ),
            CommonElevatedButton(
              image: imageAssest[6],
              diamond: '10',
              text: 'Events',
              onPressed: () {},
            ),
            CommonElevatedButton(
              image: imageAssest[7],
              diamond: '10',
              text: 'Events',
              onPressed: () {},
            ),
            CommonElevatedButton(
              image: imageAssest[8],
              diamond: '10',
              text: 'Events',
              onPressed: () {},
            ),
            CommonElevatedButton(
              image: imageAssest[9],
              diamond: '10',
              text: 'Events',
              onPressed: () {},
            ),
            CommonElevatedButton(
              image: imageAssest[10],
              diamond: '10',
              text: 'Events',
              onPressed: () {},
            ),
            CommonElevatedButton(
              image: imageAssest[11],
              diamond: '10',
              text: 'Events',
              onPressed: () {},
            ),
          ]);
    }
    if (category == "Couple") {
      return GridView.count(
          crossAxisCount: 3,
          padding: const EdgeInsets.all(4.0),
          children: [
            CommonElevatedButton(
              image: imageAssest[0],
              diamond: '10',
              text: 'Luxury',
              onPressed: () {},
            ),
            CommonElevatedButton(
              image: imageAssest[1],
              diamond: '10',
              text: 'Luxury',
              onPressed: () {},
            ),
            CommonElevatedButton(
              image: imageAssest[2],
              diamond: '10',
              text: 'Luxury',
              onPressed: () {},
            ),
            CommonElevatedButton(
              image: imageAssest[3],
              diamond: '10',
              text: 'Luxury',
              onPressed: () {},
            ),
            CommonElevatedButton(
              image: imageAssest[4],
              diamond: '10',
              text: 'Luxury',
              onPressed: () {},
            ),
            CommonElevatedButton(
              image: imageAssest[5],
              diamond: '10',
              text: 'Luxury',
              onPressed: () {},
            ),
            CommonElevatedButton(
              image: imageAssest[6],
              diamond: '10',
              text: 'Luxury',
              onPressed: () {},
            ),
            CommonElevatedButton(
              image: imageAssest[7],
              diamond: '10',
              text: 'Luxury',
              onPressed: () {},
            ),
          ]);
    }
    if (category == "Luxury") {
      return GridView.builder(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.all(4.0),
          itemCount: luxuryAsset.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
          ),
          itemBuilder: (context, index) {
            return CommonElevatedButton(
                image: luxuryAsset[index],
                diamond: '10',
                text: 'Luxury',
                onPressed: () {});
          });
    } else {
      return Container(alignment: Alignment.center, child: const Text("Empty"));
    }
  }
}

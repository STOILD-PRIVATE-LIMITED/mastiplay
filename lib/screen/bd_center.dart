import 'package:flutter/material.dart';
import 'package:spinner_try/shivanshu/utils.dart';

import '../shivanshu/screens/family_room_page.dart';

class BDCenter extends StatefulWidget {
  const BDCenter({
    super.key,
  });

  @override
  State<BDCenter> createState() => _BDCenterState();
}

class _BDCenterState extends State<BDCenter> {
  String dropdownValue = "December";
  List<String> months = [
    "January",
    "February",
    "March",
    "April",
    "May",
    "June",
    "July",
    "August",
    "September",
    "October",
    "November",
    "December"
  ];
  int currentIndex = 0;
  PageController pageController = PageController(initialPage: 0);
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: const Color(0xFFf7f8fc),
      appBar: AppBar(
        backgroundColor: const Color(0xFFf7f8fc),
        leading: const ElevatedBackButton(),
        title: Text(
          "Agency Center",
          style: TextStyle(fontSize: height / 40),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              ListTile(
                leading: const SizedBox(
                  height: 40,
                  width: 40,
                  // child: ProfileImage(user: widget.user),
                  child: Icon(Icons.person),
                ),
                title: Text(
                  "username",
                  style: TextStyle(
                      fontSize: height / 40, fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  "ID: ",
                  style: TextStyle(fontSize: height / 50, color: Colors.grey),
                ),
                trailing: Container(
                  height: height / 20,
                  width: width / 3,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: DropdownButton(
                    focusColor: Colors.white,
                    value: dropdownValue,
                    icon: const Icon(Icons.arrow_downward),
                    iconSize: height / 40,
                    elevation: 16,
                    style: const TextStyle(color: Colors.deepPurple),
                    underline: Container(
                      height: 0,
                      color: Colors.deepPurpleAccent,
                    ),
                    onChanged: (String? newValue) {
                      setState(() {
                        dropdownValue = newValue!;
                      });
                    },
                    items: months.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: TextStyle(
                              fontSize: height / 50, color: Colors.grey),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: const Color(0xFFffeddf),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text("Total income: ",
                            style: TextStyle(fontSize: 22.sp)),
                        Image.asset(
                          "assets/bean.png",
                          height: 25.sp,
                          width: 25.sp,
                        ),
                        Text(
                          "9874",
                          style: TextStyle(
                            color: const Color.fromARGB(255, 128, 117, 14),
                            fontSize: 22.sp,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFFfff8f2),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              Text(
                                "From Agency",
                                style: TextStyle(
                                  fontSize: 10.sp,
                                  color: Colors.grey,
                                ),
                              ),
                              Row(
                                children: [
                                  Image.asset(
                                    "assets/bean.png",
                                    height: 25.sp,
                                    width: 25.sp,
                                  ),
                                  const Text(
                                    "9874",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 8.0.sp,
                            ),
                            child: Text(
                              "+",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15.sp,
                              ),
                            ),
                          ),
                          Column(
                            children: [
                              Text(
                                "From Target",
                                style: TextStyle(
                                  fontSize: 10.sp,
                                  color: Colors.grey,
                                ),
                              ),
                              Row(
                                children: [
                                  Image.asset(
                                    "assets/bean.png",
                                    height: 25.sp,
                                    width: 25.sp,
                                  ),
                                  const Text(
                                    "9874",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10.sp),
              Row(
                children: [
                  GestureDetector(
                      onTap: () {
                        setState(() {
                          currentIndex = 0;
                          pageController.animateToPage(currentIndex,
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.fastEaseInToSlowEaseOut);
                        });
                      },
                      child: currentIndex == 0
                          ? Stack(
                              alignment: Alignment.center,
                              children: [
                                Text(
                                  'Agency',
                                  style: TextStyle(
                                      fontSize: height /
                                          50, // Adjust the font size as needed
                                      fontWeight: FontWeight.bold,
                                      // Adjust the font weight as needed
                                      letterSpacing: 1),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: height / 30),
                                  height: height / 200,
                                  width: width / 15,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            )
                          : Text(
                              "Agency",
                              style: TextStyle(
                                fontSize: height / 60,
                                color: Colors.grey,
                              ),
                            )),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 8.0.sp,
                    ),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          currentIndex = 1;
                          pageController.animateToPage(currentIndex,
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.fastEaseInToSlowEaseOut);
                        });
                      },
                      child: currentIndex == 1
                          ? Stack(
                              alignment: Alignment.center,
                              children: [
                                Text(
                                  'Target',
                                  style: TextStyle(
                                      fontSize: height /
                                          50, // Adjust the font size as needed
                                      fontWeight: FontWeight.bold,
                                      // Adjust the font weight as needed
                                      letterSpacing: 1),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: height / 30),
                                  height: height / 200,
                                  width: width / 15,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            )
                          : Text(
                              "Target",
                              style: TextStyle(
                                fontSize: height / 60,
                                color: Colors.grey,
                              ),
                            ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: height,
                child: PageView(
                  controller: pageController,
                  onPageChanged: (index) {
                    currentIndex = index;
                    pageController.animateToPage(currentIndex,
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.fastEaseInToSlowEaseOut);
                  },
                  children: [
                    Column(
                      children: [
                        SizedBox(height: 10.sp),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          padding: const EdgeInsets.symmetric(
                            vertical: 1,
                            horizontal: 8,
                          ),
                          child: ListTile(
                            leading: const Icon(Icons.person),
                            title: const Text("Agency Name"),
                            subtitle: const Text("Agency ID"),
                            trailing: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                foregroundColor: Colors.white,
                                side: const BorderSide(
                                    color: Colors.blue), // Border color
                              ),
                              child: const Text(
                                'Invitation',
                                style: TextStyle(
                                  color: Colors.blue,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 10.sp),
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "Your income: ",
                                    style: TextStyle(
                                      fontSize: 22.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Image.asset(
                                    "assets/bean.png",
                                    height: 25.sp,
                                    width: 25.sp,
                                  ),
                                  Text(
                                    "9874",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 22.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 5.sp),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Column(
                                    children: [
                                      Text(
                                        "Total agency income",
                                        style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 10.sp),
                                      ),
                                      Row(
                                        children: [
                                          Image.asset(
                                            "assets/bean.png",
                                            height: 20.sp,
                                            width: 20.sp,
                                          ),
                                          const Text(
                                            "9874",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                  Text(
                                    "x",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 10.sp),
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                        "Commission Rate",
                                        style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 10.sp),
                                      ),
                                      const Text(
                                        "10%",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 50.sp,
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Agency details",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Icon(Icons.search),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                            vertical: 10.sp,
                            horizontal: 5.sp,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white,
                          ),
                          child: Column(
                            children: [
                              ListTile(
                                leading: const Icon(Icons.person),
                                title: Text(
                                  "Agency Name",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20.sp),
                                ),
                                subtitle: Text(
                                  "ID:9483 Code: 9874",
                                  style: TextStyle(
                                      fontSize: 15.sp, color: Colors.grey),
                                ),
                                trailing: CircleAvatar(
                                  backgroundColor: Colors.yellow,
                                  child: IconButton(
                                    onPressed: () {},
                                    icon: const Icon(
                                      Icons.message,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              Row(
                                children: [
                                  Text(
                                    "Agency Income:",
                                    style: TextStyle(
                                        fontSize: 15.sp, color: Colors.grey),
                                  ),
                                  Image.asset(
                                    "assets/bean.png",
                                    height: 25.sp,
                                    width: 25.sp,
                                  ),
                                  Text(
                                    "879456",
                                    style: TextStyle(
                                      fontSize: 15.sp,
                                      color: const Color.fromARGB(
                                          255, 128, 117, 14),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 8.0.sp,
                                    ),
                                    child: CircleAvatar(
                                        radius: 10.sp,
                                        child: const Icon(
                                          Icons.question_mark_rounded,
                                          size: 15,
                                        )),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10.sp,
                              ),
                              Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFfff8f2),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Row(
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        RichText(
                                          text: TextSpan(
                                            text: 'Creator Income',
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 12),
                                            children: [
                                              WidgetSpan(
                                                child: Padding(
                                                  padding: EdgeInsets.symmetric(
                                                    horizontal: 8.0.sp,
                                                  ),
                                                  child: CircleAvatar(
                                                      radius: 10.sp,
                                                      child: const Icon(
                                                        Icons
                                                            .question_mark_rounded,
                                                        size: 15,
                                                      )),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Image.asset(
                                              "assets/bean.png",
                                              height: 25.sp,
                                              width: 25.sp,
                                            ),
                                            Text(
                                              "879456",
                                              style: TextStyle(
                                                fontSize: 15.sp,
                                                color: const Color.fromARGB(
                                                    255, 128, 117, 14),
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        RichText(
                                          text: TextSpan(
                                            text: 'Valid Creator',
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 12),
                                            children: [
                                              WidgetSpan(
                                                child: Padding(
                                                  padding: EdgeInsets.symmetric(
                                                    horizontal: 8.0.sp,
                                                  ),
                                                  child: CircleAvatar(
                                                      radius: 10.sp,
                                                      child: const Icon(
                                                        Icons
                                                            .question_mark_rounded,
                                                        size: 15,
                                                      )),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const Text(
                                          "30",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                    const Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text("New Creator"),
                                        Text(
                                          "20",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 10.sp,
                              ),
                              const Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text("Phone: +91-9876543210")),
                            ],
                          ),
                        )
                      ],
                    ),
                    const Text("data"),
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

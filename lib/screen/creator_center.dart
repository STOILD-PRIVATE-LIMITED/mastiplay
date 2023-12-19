import 'package:flutter/material.dart';

class CreatorCenter extends StatefulWidget {
  const CreatorCenter({super.key});

  @override
  State<CreatorCenter> createState() => _CreatorCenterState();
}

class _CreatorCenterState extends State<CreatorCenter> {
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
        leading: Icon(
          Icons.arrow_back_ios,
          size: height / 40,
        ),
        title: Text(
          "Creator Center",
          style: TextStyle(fontSize: height / 40),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: width / 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                leading: Icon(
                  Icons.person,
                  size: height / 40,
                ),
                title: Text(
                  'Profile',
                  style: TextStyle(fontSize: height / 50, color: Colors.black),
                ),
                subtitle: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'ID: 123456789',
                      style:
                          TextStyle(fontSize: height / 60, color: Colors.grey),
                    ),
                    Icon(
                      Icons.copy,
                      size: height / 60,
                      color: Colors.grey,
                    )
                  ],
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
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.yellow[100],
                ),
                padding: EdgeInsets.symmetric(
                    horizontal: width / 30, vertical: height / 50),
                child: const Column(
                  children: [
                    Row(
                      children: [
                        Text("Total: "),
                        Icon(Icons.abc),
                        Text(
                          "0",
                          style: TextStyle(color: Colors.yellow),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            Text("Basic Income"),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(Icons.abc),
                                Text(
                                  "0",
                                  style: TextStyle(color: Colors.yellow),
                                )
                              ],
                            )
                          ],
                        ),
                        Column(
                          children: [
                            Text("Bonus Income"),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(Icons.abc),
                                Text(
                                  "0",
                                  style: TextStyle(color: Colors.yellow),
                                )
                              ],
                            )
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                    horizontal: width / 30, vertical: height / 50),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'date',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: height / 60,
                                  backgroundColor: Colors.yellow[100],
                                ),
                              ),
                              WidgetSpan(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: width / 60),
                                  child: Icon(
                                    Icons.help_outline,
                                    size: height / 40,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'History list',
                                style: TextStyle(
                                    color: Colors.black, fontSize: height / 60),
                              ),
                              WidgetSpan(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: width / 60),
                                  child: Icon(
                                    Icons.arrow_forward_ios_outlined,
                                    size: height / 40,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: height / 50),
                    RichText(
                      text: TextSpan(children: [
                        TextSpan(
                          text: 'Gift bonus rate: ',
                          style: TextStyle(
                              fontSize: height / 50,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                        TextSpan(
                          text: '0%',
                          style: TextStyle(
                              fontSize: height / 50,
                              color: Colors.yellow,
                              fontWeight: FontWeight.bold),
                        ),
                      ]),
                    ),
                    SizedBox(height: height / 50),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text("0%"),
                        Text("5%"),
                        Text("7%"),
                        Text("10%"),
                      ],
                    ),
                    SizedBox(
                      height: height / 50,
                    ),
                    const LinearProgressIndicator(
                      value: .75,
                      minHeight: 7,
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                    ),
                    SizedBox(
                      height: height / 50,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Row(
                          children: [
                            Image.asset(
                              "assets/bean.png",
                              height: height / 50,
                            ),
                            Text(
                              "0",
                              style: TextStyle(
                                fontSize: height / 80,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Image.asset(
                              "assets/bean.png",
                              height: height / 50,
                            ),
                            Text(
                              "50K",
                              style: TextStyle(
                                fontSize: height / 80,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Image.asset(
                              "assets/bean.png",
                              height: height / 50,
                            ),
                            Text(
                              "200K",
                              style: TextStyle(
                                fontSize: height / 80,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Image.asset(
                              "assets/bean.png",
                              height: height / 50,
                            ),
                            Text(
                              "500K",
                              style: TextStyle(
                                fontSize: height / 80,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: height / 50),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: width / 30,
                        vertical: height / 50,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.yellow[100],
                      ),
                      child: ListTile(
                        leading: Icon(
                          Icons.present_to_all,
                          size: height / 40,
                        ),
                        title: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'Gift Income: ',
                                style: TextStyle(
                                    fontSize: height / 50,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                              TextSpan(
                                text: '0',
                                style: TextStyle(
                                    fontSize: height / 50,
                                    color: Colors.yellow,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        subtitle: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'Need:',
                                style: TextStyle(
                                  fontSize: height / 60,
                                  color: Colors.black,
                                ),
                              ),
                              WidgetSpan(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: width / 60),
                                  child: Icon(
                                    Icons.help_outline,
                                    size: height / 40,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                              TextSpan(
                                text: '5000 ',
                                style: TextStyle(
                                  fontSize: height / 60,
                                  color: Colors.black,
                                ),
                              ),
                              TextSpan(
                                text: 'to upgrade the ',
                                style: TextStyle(
                                  fontSize: height / 60,
                                  color: Colors.black,
                                ),
                              ),
                              TextSpan(
                                text: '5%',
                                style: TextStyle(
                                  fontSize: height / 60,
                                  color: Colors.yellow,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                    horizontal: width / 30, vertical: height / 50),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          "My agency",
                          style: TextStyle(
                            fontSize: height / 60,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Icon(Icons.abc),
                        Text(
                          "SR",
                          style: TextStyle(
                            fontSize: height / 50,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'Change Agency',
                            style: TextStyle(
                              fontSize: height / 60,
                              color: Colors.black,
                            ),
                          ),
                          WidgetSpan(
                            child: Padding(
                              padding:
                                  EdgeInsets.symmetric(horizontal: width / 60),
                              child: Icon(
                                Icons.arrow_forward_ios_outlined,
                                size: height / 40,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
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
                                'Daily Income',
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
                        : Text("Daily Income",
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
                                'Room data',
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
                            "Room data",
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
                    const Text("data"),
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: width / 30,
                                  vertical: height / 50),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.white,
                              ),
                              child: RichText(
                                text: TextSpan(
                                  children: [
                                    WidgetSpan(
                                      child: Icon(
                                        Icons.live_help_outlined,
                                        size: height / 60,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    TextSpan(
                                      text: ' Live Room',
                                      style: TextStyle(
                                          fontSize: height / 70,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: width / 30,
                                  vertical: height / 50),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.white,
                              ),
                              child: RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'Chat Room',
                                      style: TextStyle(
                                          fontSize: height / 70,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: DataTable(
                              columns: const [
                                DataColumn(
                                  label: Expanded(
                                    child: Text(
                                      'Date',
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                  ),
                                ),
                                DataColumn(
                                  label: Expanded(
                                    child: Text(
                                      'Live Duration\n(mins)',
                                      textAlign: TextAlign.end,
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                  ),
                                ),
                                DataColumn(
                                  label: Expanded(
                                    child: Text(
                                      'Live room gift\n(myself)',
                                      textAlign: TextAlign.end,
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                  ),
                                ),
                              ],
                              rows: <DataRow>[
                                DataRow(
                                  cells: <DataCell>[
                                    const DataCell(Text('12.01')),
                                    const DataCell(Text('0')),
                                    DataCell(RichText(
                                      text: TextSpan(
                                        children: [
                                          WidgetSpan(
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: width / 60),
                                              child: Icon(
                                                Icons.help_outline,
                                                size: height / 40,
                                                color: Colors.grey,
                                              ),
                                            ),
                                          ),
                                          TextSpan(
                                            text: '5000 ',
                                            style: TextStyle(
                                              fontSize: height / 60,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ],
                                      ),
                                    )),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    )
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

import 'package:flutter/material.dart';

class HistoryList extends StatefulWidget {
  const HistoryList({super.key});

  @override
  State<HistoryList> createState() => _HistoryListState();
}

class _HistoryListState extends State<HistoryList> {
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

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
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
          "Creator Center",
          style: TextStyle(fontSize: height / 40),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: width / 30),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Text(
                      'Gift Income',
                      style: TextStyle(
                          fontSize:
                              height / 40, // Adjust the font size as needed
                          fontWeight: FontWeight.bold,
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
                ),
                Container(
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
              ],
            ),
            SizedBox(height: height / 30),
            Container(
              width: width,
              padding: EdgeInsets.symmetric(
                  horizontal: width / 30, vertical: height / 50),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "09.16",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: height / 40,
                    ),
                  ),
                  SizedBox(height: height / 50),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Text(
                            "Gift Income",
                            style: TextStyle(
                              fontSize: height / 60,
                              color: Colors.grey,
                            ),
                          ),
                          Text(
                            "0%",
                            style: TextStyle(
                                fontSize: height / 60,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            "Common rate:",
                            style: TextStyle(
                              fontSize: height / 60,
                              color: Colors.grey,
                            ),
                          ),
                          Text(
                            "0%",
                            style: TextStyle(
                                fontSize: height / 60,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            "Gift commission",
                            style: TextStyle(
                              fontSize: height / 60,
                              color: Colors.grey,
                            ),
                          ),
                          Text(
                            "0%",
                            style: TextStyle(
                                fontSize: height / 60,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

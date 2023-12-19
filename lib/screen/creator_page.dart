import 'package:flutter/material.dart';

class CreatorPage extends StatefulWidget {
  const CreatorPage({super.key});

  @override
  State<CreatorPage> createState() => _CreatorPageState();
}

class _CreatorPageState extends State<CreatorPage> {
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
          "Agency Center",
          style: TextStyle(fontSize: height / 40),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: width / 30),
          child: Column(
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Myself: "),
                  Icon(
                    Icons.abc,
                    color: Colors.purple,
                  ),
                  Text("1234567890"),
                ],
              ),
              SizedBox(height: height / 60),
              Container(
                width: width / 1.2,
                padding: EdgeInsets.symmetric(
                    horizontal: width / 30, vertical: height / 35),
                decoration: BoxDecoration(
                  color: Colors.blue[100],
                  borderRadius: BorderRadius.circular(20),
                ),
                alignment: Alignment.center,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Monthly tasks",
                          style: TextStyle(
                              fontSize: height / 50,
                              fontWeight: FontWeight.bold),
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons.punch_clock,
                              color: Colors.grey,
                            ),
                            Text(
                              "25days 01:32:53",
                              style: TextStyle(
                                fontSize: height / 60,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Text(
                      "Tasks to be completed every month",
                      style:
                          TextStyle(fontSize: height / 60, color: Colors.black),
                    ),
                    SizedBox(
                      height: height / 90,
                    ),
                    Text(
                      "Option Task A",
                      style: TextStyle(
                          fontSize: height / 60,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: height / 90,
                    ),
                    Container(
                      height: height / 10,
                      width: width / 1.2,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 1,
                            blurRadius: 5,
                          ),
                        ],
                      ),
                      padding: EdgeInsets.symmetric(
                          horizontal: width / 30, vertical: height / 80),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.abc,
                            color: Colors.purple,
                          ),
                          SizedBox(
                            width: width / 30,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Number of invited creators",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: height / 60),
                              ),
                              Text(
                                "2/5",
                                style: TextStyle(fontSize: height / 60),
                              ),
                              SizedBox(
                                width: width / 2.5,
                                child: const LinearProgressIndicator(
                                  value: .25,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(20),
                                  ),
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.green),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: height / 60),
              Row(
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Text(
                        'Creator',
                        style: TextStyle(
                            fontSize:
                                height / 40, // Adjust the font size as needed
                            fontWeight: FontWeight.bold,
                            // Adjust the font weight as needed
                            letterSpacing: 1),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: height / 30),
                        height: height / 200,
                        width: width / 10,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: width / 30,
                  ),
                  const Text("Commision rate: "),
                  SizedBox(
                    width: width / 30,
                  ),
                  const Text("23", style: TextStyle(color: Colors.yellow)),
                  SizedBox(
                    width: width / 30,
                  ),
                  const Text(
                    "Total",
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
              SizedBox(height: height / 40),
              Container(
                // height: height / 4,
                width: width / 1,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 5,
                    ),
                  ],
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: width / 30,
                  vertical: height / 60,
                ),
                alignment: Alignment.center,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("December"),
                        Row(
                          children: [
                            const Text("History list"),
                            Icon(
                              Icons.arrow_forward_ios,
                              size: height / 50,
                            )
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: height / 50,
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text("5%"),
                        Text("10%"),
                        Text("15%"),
                        Text("17%"),
                        Text("19%"),
                        Text("21%"),
                        Text("23%"),
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
                              "assets/Vector.png",
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
                              "assets/Vector.png",
                              height: height / 50,
                            ),
                            Text(
                              "1M",
                              style: TextStyle(
                                fontSize: height / 80,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Image.asset(
                              "assets/Vector.png",
                              height: height / 50,
                            ),
                            Text(
                              "5M",
                              style: TextStyle(
                                fontSize: height / 80,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Image.asset(
                              "assets/Vector.png",
                              height: height / 50,
                            ),
                            Text(
                              "10M",
                              style: TextStyle(
                                fontSize: height / 80,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Image.asset(
                              "assets/Vector.png",
                              height: height / 50,
                            ),
                            Text(
                              "30M",
                              style: TextStyle(
                                fontSize: height / 80,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Image.asset(
                              "assets/Vector.png",
                              height: height / 50,
                            ),
                            Text(
                              "80M",
                              style: TextStyle(
                                fontSize: height / 80,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Image.asset(
                              "assets/Vector.png",
                              height: height / 50,
                            ),
                            Text(
                              "150M",
                              style: TextStyle(
                                fontSize: height / 80,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: height / 50,
                    ),
                    Row(
                      children: [
                        Text(
                          "THIS MONTH AGENCY TARGET IS ",
                          style: TextStyle(
                              fontSize: height / 70,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 2),
                        ),
                        Image.asset(
                          "assets/Vector.png",
                          height: height / 30,
                        ),
                        Text(
                          "800000",
                          style: TextStyle(
                              fontSize: height / 60,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              ListTile(
                leading: Icon(
                  Icons.abc,
                  size: height / 30,
                ),
                title: Text(
                  "Creator application",
                  style: TextStyle(
                    fontSize: height / 60,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                trailing: Container(
                  height: height / 20,
                  width: width / 5,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.red,
                        minRadius: 15,
                        child: Text(
                          "2",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: height / 70,
                          ),
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: height / 50,
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: width / 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "All Creators",
                      style: TextStyle(
                        // height: height / 50,
                        fontSize: height / 40,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Icon(
                      Icons.search,
                      size: height / 30,
                    )
                  ],
                ),
              ),
              SizedBox(height: height / 60),
              SizedBox(
                height: height,
                child: ListView.builder(
                  itemCount: 2,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: height / 5.5,
                        width: width,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          children: [
                            ListTile(
                              leading: Icon(Icons.abc, size: height / 20),
                              title: Text(
                                "SR",
                                style: TextStyle(
                                    fontSize: height / 50,
                                    fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text(
                                "ID: 123456789",
                                style: TextStyle(
                                  fontSize: height / 60,
                                  color: Colors.grey,
                                ),
                              ),
                              trailing: const Icon(Icons.message),
                            ),
                            SizedBox(
                              height: height / 100,
                            ),
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Column(
                                  children: [
                                    Text("My Commision"),
                                    Row(
                                      children: [
                                        Icon(Icons.abc),
                                        Text("000000"),
                                      ],
                                    )
                                  ],
                                ),
                                Column(
                                  children: [
                                    Text("My Commision"),
                                    Row(
                                      children: [
                                        Icon(Icons.abc),
                                        Text("000000"),
                                      ],
                                    )
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

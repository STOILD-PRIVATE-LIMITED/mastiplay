import 'package:flutter/material.dart';

class NobelCenter extends StatefulWidget {
  const NobelCenter({super.key});

  @override
  State<NobelCenter> createState() => _NobelCenterState();
}

class _NobelCenterState extends State<NobelCenter> {
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
          "Nobel Center",
          style: TextStyle(fontSize: height / 40),
        ),
        actions: [
          Container(
            color: Colors.yellow,
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: width / 30, vertical: height / 100),
              child: Row(
                children: [
                  Icon(
                    Icons.star,
                    size: height / 60,
                  ),
                  Text(
                    " VIP",
                    style: TextStyle(
                        fontSize: height / 60,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: width / 30,
              vertical: height / 100,
            ),
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                  'https://images.pexels.com/photos/13870516/pexels-photo-13870516.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
                ),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Text(
                          'Gift Income',
                          style: TextStyle(
                            fontSize: height / 60,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: height / 30),
                          height: height / 200,
                          width: width / 10,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: const Color(0xFFE05DD3),
                          ),
                        ),
                      ],
                    ),
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Text(
                          'Gift Income',
                          style: TextStyle(
                            fontSize: height / 60,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: height / 30),
                          height: height / 200,
                          width: width / 10,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: const Color(0xFFE05DD3),
                          ),
                        ),
                      ],
                    ),
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Text(
                          'Gift Income',
                          style: TextStyle(
                            fontSize: height / 60,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: height / 30),
                          height: height / 200,
                          width: width / 10,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: const Color(0xFFE05DD3),
                          ),
                        ),
                      ],
                    ),
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Text(
                          'Gift Income',
                          style: TextStyle(
                            fontSize: height / 60,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: height / 30),
                          height: height / 200,
                          width: width / 10,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: const Color(0xFFE05DD3),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: height / 5,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: width / 30,
                  ),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: width / 30,
                      vertical: height / 100,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              children: [
                                Text(
                                  "INR 56789",
                                  style: TextStyle(
                                    fontSize: height / 40,
                                  ),
                                ),
                                Text(
                                  "Total Income",
                                  style: TextStyle(
                                    fontSize: height / 60,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                                height: height / 20,
                                child: const VerticalDivider()),
                            Column(
                              children: [
                                Text(
                                  "INR 56789",
                                  style: TextStyle(
                                    fontSize: height / 40,
                                  ),
                                ),
                                Text(
                                  "Total Income",
                                  style: TextStyle(
                                    fontSize: height / 60,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Text(
                          "Lorem Ipsum has been the industry's standard dummy text ever since the 1500s",
                          style: TextStyle(
                            fontSize: height / 60,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: height / 50,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(width: width / 5, child: const Divider()),
              Text(
                "Duke Upgrade",
                style: TextStyle(
                  fontSize: height / 60,
                ),
              ),
              SizedBox(width: width / 5, child: const Divider()),
            ],
          ),
          SizedBox(
            height: height / 50,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: width / 30,
                  vertical: height / 100,
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SizedBox(width: width / 10, child: const Divider()),
                        Text(
                          "Upgrade Duke level",
                          style: TextStyle(
                            fontSize: height / 60,
                          ),
                        ),
                        SizedBox(width: width / 10, child: const Divider()),
                      ],
                    ),
                    SizedBox(
                      height: height / 50,
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Icon(Icons.panorama_horizontal_select),
                        Icon(Icons.panorama_horizontal_select),
                        Icon(Icons.panorama_horizontal_select),
                        Icon(Icons.panorama_horizontal_select),
                        Icon(Icons.panorama_horizontal_select),
                        Icon(Icons.panorama_horizontal_select),
                        Icon(Icons.panorama_horizontal_select),
                      ],
                    ),
                    SizedBox(
                      height: height / 50,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: width / 15,
                                vertical: height / 50,
                              ),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: Colors.yellow,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child:
                                  const Icon(Icons.panorama_horizontal_select),
                            ),
                            Text(
                              "Duke Upgrade\nMedal",
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: height / 80),
                            )
                          ],
                        ),
                        Column(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: width / 15,
                                vertical: height / 50,
                              ),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: Colors.yellow,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child:
                                  const Icon(Icons.panorama_horizontal_select),
                            ),
                            Text(
                              "Duke Upgrade\nAvatar Frame",
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: height / 80),
                            )
                          ],
                        ),
                        Column(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: width / 15,
                                vertical: height / 50,
                              ),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: Colors.yellow,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child:
                                  const Icon(Icons.panorama_horizontal_select),
                            ),
                            Text(
                              "Duke Upgrade\nEntrance Effect",
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: height / 80),
                            )
                          ],
                        ),
                        Column(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: width / 15,
                                vertical: height / 50,
                              ),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: Colors.yellow,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child:
                                  const Icon(Icons.panorama_horizontal_select),
                            ),
                            Text(
                              "24h Exclusive\nCustomer Service",
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: height / 80),
                            )
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: height / 50,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SizedBox(width: width / 5, child: const Divider()),
                        Text(
                          "Display privileges",
                          style: TextStyle(
                            fontSize: height / 60,
                          ),
                        ),
                        SizedBox(width: width / 5, child: const Divider()),
                      ],
                    ),
                    Image.asset(
                      "assets/horse.png",
                    ),
                    Image.asset(
                      "assets/nobel1.png",
                    ),
                    Image.asset(
                      "assets/nobel2.png",
                    ),
                    Image.asset(
                      "assets/nobel3.png",
                    ),
                    Image.asset(
                      "assets/nobel4.png",
                    ),
                    Image.asset(
                      "assets/nobel5.png",
                    ),
                    Image.asset(
                      "assets/nobel6.png",
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

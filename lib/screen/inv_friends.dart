import 'package:flutter/material.dart';

class InviteFriends extends StatefulWidget {
  const InviteFriends({super.key});

  @override
  State<InviteFriends> createState() => _InviteFriendsState();
}

class _InviteFriendsState extends State<InviteFriends> {
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
          "Invite Friends",
          style: TextStyle(fontSize: height / 40),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: width / 20, vertical: height / 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.center,
              child: Text(
                "Creator",
                style: TextStyle(
                    fontSize: height / 40, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: height / 50,
            ),
            Container(
              width: width,
              padding: EdgeInsets.symmetric(
                  horizontal: width / 20, vertical: height / 50),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  ListTile(
                    title: Text(
                      "Total Creator Rewards",
                      style: TextStyle(
                        fontSize: height / 50,
                      ),
                    ),
                    trailing: SizedBox(
                      width: width / 4,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Image.asset(
                              "assets/Vector.png",
                              height: height / 40,
                            ),
                            Text(
                              "21370",
                              style: TextStyle(
                                  fontSize: height / 40,
                                  fontWeight: FontWeight.bold),
                            )
                          ]),
                    ),
                  ),
                  const Divider(
                    color: Colors.grey,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Current received rewards",
                              style: TextStyle(
                                fontSize: height / 50,
                              ),
                            ),
                            SizedBox(
                              height: height / 100,
                            ),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Image.asset(
                                    "assets/Vector.png",
                                    height: height / 40,
                                  ),
                                  Text(
                                    "21370",
                                    style: TextStyle(
                                        fontSize: height / 40,
                                        fontWeight: FontWeight.bold),
                                  )
                                ]),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Rewards to unlock",
                              style: TextStyle(
                                fontSize: height / 50,
                              ),
                            ),
                            SizedBox(
                              height: height / 100,
                            ),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Image.asset(
                                    "assets/Vector.png",
                                    height: height / 40,
                                  ),
                                  Text(
                                    "21370",
                                    style: TextStyle(
                                        fontSize: height / 40,
                                        fontWeight: FontWeight.bold),
                                  )
                                ]),
                          ],
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
            SizedBox(
              height: height / 50,
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.pink[100],
                borderRadius: BorderRadius.circular(10),
              ),
              padding: EdgeInsets.symmetric(
                  horizontal: width / 20, vertical: height / 50),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(
                    Icons.abc,
                    color: Colors.pink,
                    size: height / 15,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          "Creator Rewards Wallet",
                          style: TextStyle(
                              color: Colors.black,
                              // fontSize: height / 60,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Image.asset(
                              "assets/Vector.png",
                              height: height / 40,
                            ),
                            Text(
                              "21370",
                              style: TextStyle(
                                  fontSize: height / 40,
                                  fontWeight: FontWeight.bold),
                            )
                          ]),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.info,
                              color: Colors.pink,
                              size: height / 30,
                            ),
                            Text(
                              "21370",
                              style: TextStyle(
                                  fontSize: height / 60,
                                  fontWeight: FontWeight.bold),
                            )
                          ]),
                    ],
                  ),
                  Container(
                    height: height / 20,
                    padding: EdgeInsets.symmetric(
                        horizontal: width / 20, vertical: height / 100),
                    decoration: BoxDecoration(
                      color: Colors.pink,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      "Collect",
                      style:
                          TextStyle(fontSize: height / 60, color: Colors.white),
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
                Text(
                  'My Invitations',
                  style: TextStyle(
                      fontSize: height / 40,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1),
                ),
                Text(
                  'Details',
                  style: TextStyle(
                      fontSize: height / 40,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1),
                ),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Text(
                      'Rank',
                      style: TextStyle(
                          fontSize: height / 40,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: height / 25),
                      height: height / 200,
                      width: width / 15,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.black,
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
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    SizedBox(
                      height: height / 30,
                    ),
                    Container(
                      width: width / 3.5,
                      padding: EdgeInsets.symmetric(
                          horizontal: width / 20, vertical: height / 100),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.pink,
                      ),
                      alignment: Alignment.center,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.person,
                            color: Colors.white,
                            size: height / 20,
                          ),
                          SizedBox(
                            height: height / 100,
                          ),
                          Text(
                            "Name",
                            style: TextStyle(
                                fontSize: height / 50,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          SizedBox(
                            height: height / 100,
                          ),
                          Text(
                            "\$982.16",
                            style: TextStyle(
                                fontSize: height / 50,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                Container(
                  width: width / 3.5,
                  padding: EdgeInsets.symmetric(
                      horizontal: width / 20, vertical: height / 100),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.pink,
                  ),
                  alignment: Alignment.center,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.person,
                        color: Colors.white,
                        size: height / 20,
                      ),
                      SizedBox(
                        height: height / 100,
                      ),
                      Text(
                        "Name",
                        style: TextStyle(
                            fontSize: height / 50,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      SizedBox(
                        height: height / 100,
                      ),
                      Text(
                        "\$982.16",
                        style: TextStyle(
                            fontSize: height / 50,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      )
                    ],
                  ),
                ),
                Column(
                  children: [
                    SizedBox(
                      height: height / 50,
                    ),
                    Container(
                      width: width / 3.5,
                      padding: EdgeInsets.symmetric(
                          horizontal: width / 20, vertical: height / 100),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.pink,
                      ),
                      alignment: Alignment.center,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.person,
                            color: Colors.white,
                            size: height / 20,
                          ),
                          SizedBox(
                            height: height / 100,
                          ),
                          Text(
                            "Name",
                            style: TextStyle(
                                fontSize: height / 50,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          SizedBox(
                            height: height / 100,
                          ),
                          Text(
                            "\$982.16",
                            style: TextStyle(
                                fontSize: height / 50,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: height / 50,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: 8,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Text(
                      '$index',
                      style: TextStyle(fontSize: height / 50),
                    ),
                    title: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: width / 20, vertical: height / 100),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      alignment: Alignment.center,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.person,
                            color: Colors.black,
                            size: height / 30,
                          ),
                          Text(
                            "Name",
                            style: TextStyle(
                                fontSize: height / 40,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                    trailing: Text(
                      "\$ ${index * 100}",
                      style: TextStyle(
                          color: Colors.yellow, fontSize: height / 50),
                    ),
                  );
                },
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Container(
                width: width / 4,
                height: height / 20,
                padding: EdgeInsets.symmetric(
                    horizontal: width / 20, vertical: height / 100),
                decoration: BoxDecoration(
                  color: Colors.pink,
                  borderRadius: BorderRadius.circular(40),
                ),
                alignment: Alignment.center,
                child: Text(
                  "Creator",
                  style: TextStyle(fontSize: height / 60, color: Colors.white),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

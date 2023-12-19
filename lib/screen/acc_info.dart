import 'package:flutter/material.dart';

class AccountInformation extends StatefulWidget {
  const AccountInformation({super.key});

  @override
  State<AccountInformation> createState() => _AccountInformationState();
}

class _AccountInformationState extends State<AccountInformation> {
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
          "Account info",
          style: TextStyle(fontSize: height / 40),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: height / 30,
              width: width,
              color: const Color(0xFFf9b121),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.info,
                    color: Colors.white,
                    size: height / 40,
                  ),
                  Text(
                    "Please don't share your password with anyone",
                    style:
                        TextStyle(color: Colors.white, fontSize: height / 60),
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width / 30),
              child: Column(
                children: [
                  Container(
                    height: height / 2,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: height / 30),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.abc,
                              size: height / 20,
                            ),
                            Text(
                              "Mastiplay",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: height / 40,
                              ),
                            )
                          ],
                        ),
                        Text(
                          "Account Information",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: height / 40),
                        ),
                        SizedBox(height: height / 30),
                        ListTile(
                          title: Text(
                            "Account ID",
                            style: TextStyle(
                                fontSize: height / 50, color: Colors.grey),
                          ),
                          trailing: SizedBox(
                            width: width / 3,
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.person,
                                    size: height / 40,
                                  ),
                                  Text(
                                    "12345567",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: height / 60,
                                    ),
                                  ),
                                  Icon(
                                    Icons.copy,
                                    size: height / 40,
                                  )
                                ]),
                          ),
                        ),
                        ListTile(
                          title: Text(
                            "Phone Number",
                            style: TextStyle(
                                fontSize: height / 50, color: Colors.grey),
                          ),
                          trailing: Text(
                            "12345567",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: height / 60,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 18),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Password",
                                style: TextStyle(
                                    fontSize: height / 50, color: Colors.grey),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: width / 90,
                                  vertical: height / 100,
                                ),
                                width: width / 3,
                                child: Column(
                                  children: [
                                    Text(
                                      "*******",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: height / 60,
                                      ),
                                    ),
                                    Text(
                                      "Update Password >",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.pink,
                                        fontSize: height / 60,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: height / 2.3),
                  Container(
                    width: width / 1.5,
                    height: height / 15,
                    decoration: BoxDecoration(
                      color: Colors.pink,
                      borderRadius: BorderRadius.circular(40),
                    ),
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.download_rounded,
                          color: Colors.white,
                          size: height / 30,
                        ),
                        Text(
                          "Save to album",
                          style: TextStyle(
                              color: Colors.white, fontSize: height / 60),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

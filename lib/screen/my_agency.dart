import 'package:flutter/material.dart';

class MyAgency extends StatefulWidget {
  const MyAgency({super.key});

  @override
  State<MyAgency> createState() => _MyAgencyState();
}

class _MyAgencyState extends State<MyAgency> {
  TextEditingController agencyId = TextEditingController();
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
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: width / 20, vertical: height / 50),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              "My Agency",
              style: TextStyle(
                  fontSize: height / 40,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            ListTile(
              leading: Icon(Icons.abc, size: height / 30),
              title: Text(
                "Name",
                style: TextStyle(
                    fontSize: height / 50, fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                "ID: 123456789",
                style: TextStyle(fontSize: height / 60, color: Colors.grey),
              ),
              trailing: Icon(
                Icons.message_rounded,
                size: height / 30,
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return SizedBox(
                          height: height / 3,
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: width / 20,
                                    vertical: height / 50),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Change the Agency",
                                      style: TextStyle(
                                          fontSize: height / 40,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
                                      child: Icon(
                                        Icons.close,
                                        size: height / 40,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: width / 20,
                                  ),
                                  child: Text(
                                    "Agency id provided by agency",
                                    style: TextStyle(
                                        fontSize: height / 50,
                                        color: Colors.black),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: width / 20,
                                    vertical: height / 50),
                                child: TextField(
                                  controller: agencyId,
                                  decoration: InputDecoration(
                                      hintText: "Please enter the Agency ID",
                                      hintStyle: TextStyle(
                                          fontSize: height / 50,
                                          color: Colors.grey),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10))),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: width / 20,
                                    vertical: height / 50),
                                child: Container(
                                  width: width,
                                  height: height / 15,
                                  decoration: BoxDecoration(
                                      color: Colors.pink,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Center(
                                    child: Text(
                                      "Bind",
                                      style: TextStyle(
                                          fontSize: height / 50,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        );
                      });
                },
                child: RichText(
                  text: TextSpan(children: [
                    TextSpan(
                      text: "Change Agency",
                      style: TextStyle(
                        fontSize: height / 50,
                        color: Colors.black,
                      ),
                    ),
                    WidgetSpan(
                        child: Icon(
                      Icons.arrow_forward_ios,
                      size: height / 50,
                      color: Colors.grey,
                    ))
                  ]),
                ),
              ),
            ),
            SizedBox(
              height: height / 50,
            ),
            Container(
              padding: EdgeInsets.symmetric(
                  horizontal: width / 20, vertical: height / 50),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 2,
                    offset: const Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: const Text(
                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed vitae nisl eget nunc ultricies aliquet. Sed vitae nisl eget nunc ultricies aliquet."),
            )
          ]),
        ));
  }
}

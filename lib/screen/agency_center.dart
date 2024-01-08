import 'package:flutter/material.dart';
import 'package:spinner_try/screen/creator_application.dart';
import 'package:spinner_try/shivanshu/models/agency/agency.dart';
import 'package:spinner_try/shivanshu/screens/creators_list.dart';
import 'package:spinner_try/shivanshu/screens/family_room_page.dart';
import 'package:spinner_try/shivanshu/utils.dart';
import 'package:spinner_try/shivanshu/utils/loading_widget.dart';
import 'package:spinner_try/shivanshu/utils/profile_image.dart';
import 'package:spinner_try/user_model.dart';

// import 'package:spinner_try/screen/creator_page.dart';

import 'agency_creator.dart';

class AgencyCenter extends StatefulWidget {
  final UserModel user;
  const AgencyCenter({super.key, required this.user});

  @override
  State<AgencyCenter> createState() => _AgencyCenterState();
}

class _AgencyCenterState extends State<AgencyCenter> {
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
        leading: const ElevatedBackButton(),
        title: Text(
          "Agency Center",
          style: TextStyle(fontSize: height / 40),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListTile(
              leading: SizedBox(
                height: 40,
                width: 40,
                child: ProfileImage(user: widget.user),
              ),
              title: Text(
                widget.user.name,
                style: TextStyle(
                    fontSize: height / 40, fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                "ID: ${widget.user.ownedAgencyData!.id ?? 'No ID'}",
                style: TextStyle(fontSize: height / 50, color: Colors.grey),
              ),
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
                      style:
                          TextStyle(fontSize: height / 50, color: Colors.grey),
                    ),
                  );
                }).toList(),
              ),
            ),
            SizedBox(
              height: height / 40,
            ),
            Container(
              height: height / 2.8,
              width: width / 1.2,
              padding: EdgeInsets.symmetric(
                  horizontal: width / 30, vertical: width / 30),
              decoration: BoxDecoration(
                color: Colors.yellow[200],
                borderRadius: BorderRadius.circular(20),
              ),
              alignment: Alignment.center,
              child: Column(
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text("Total:"),
                          Text(
                            "123456789",
                            style: TextStyle(color: Colors.black),
                          ),
                          Icon(Icons.question_mark_rounded)
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            "History",
                            style: TextStyle(color: Colors.black),
                          ),
                          Icon(Icons.arrow_forward_ios_rounded,
                              color: Colors.grey)
                        ],
                      )
                    ],
                  ),
                  SizedBox(
                    height: height / 40,
                  ),
                  Container(
                    height: height / 4,
                    width: width * 3 / 4,
                    padding: EdgeInsets.symmetric(
                        horizontal: width / 30, vertical: width / 30),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.diamond,
                              color: Colors.pink,
                            ),
                            Text(
                              widget.user.ownedAgencyData!.beansCount
                                  .toString(),
                              style: TextStyle(
                                  fontSize: height / 40,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Text(
                          "Commision from Creator",
                          style: TextStyle(
                              fontSize: height / 60, color: Colors.grey),
                        ),
                        SizedBox(
                          height: height / 60,
                        ),
                        LoadingWidget(
                          onPressed: () async {
                            await collectBeans(
                              widget.user.ownedAgencyData!.id!,
                            );
                          },
                          loadingWidget: Container(
                            height: height / 20,
                            width: width / 3,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.purple,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.purple.withOpacity(0.5),
                                  spreadRadius: 1,
                                  blurRadius: 5,
                                ),
                              ],
                            ),
                            alignment: Alignment.center,
                            child: const CircularProgressIndicatorRainbow(),
                          ),
                          child: Container(
                            height: height / 20,
                            width: width / 3,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.purple,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.purple.withOpacity(0.5),
                                  spreadRadius: 1,
                                  blurRadius: 5,
                                ),
                              ],
                            ),
                            alignment: Alignment.center,
                            child: const Text(
                              "Collect",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: height / 80,
                        ),
                        Text(
                          "*agent Collect in 2 time in a month",
                          style: TextStyle(
                              color: Colors.red, fontSize: height / 100),
                        ),
                        SizedBox(
                          height: height / 80,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const CreatorApplication(),
                                  ),
                                );
                              },
                              child: Container(
                                height: height / 20,
                                width: width / 4,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.purple[100],
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.purple.withOpacity(0.5),
                                      spreadRadius: 1,
                                      blurRadius: 5,
                                    ),
                                  ],
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  "Add Creator",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.purple,
                                      fontSize: height / 60),
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                navigatorPush(
                                    context, CreatorsList(user: widget.user));
                              },
                              child: Row(
                                children: [
                                  Text(
                                    "Creator List",
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: height / 60),
                                  ),
                                  const Icon(Icons.arrow_forward_ios_rounded,
                                      color: Colors.grey)
                                ],
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // const Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     Text("Myself: "),
            //     Icon(
            //       Icons.abc,
            //       color: Colors.purple,
            //     ),
            //     Text("1234567890"),
            //   ],
            // ),
            SizedBox(
              height: height / 40,
            ),
            // Container(
            //   width: width / 1.2,
            //   padding: EdgeInsets.symmetric(
            //       horizontal: width / 30, vertical: height / 35),
            //   decoration: BoxDecoration(
            //     color: Colors.blue[100],
            //     borderRadius: BorderRadius.circular(20),
            //   ),
            //   alignment: Alignment.center,
            //   child: Column(
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: [
            //       Row(
            //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //         children: [
            //           Text(
            //             "Monthly tasks",
            //             style: TextStyle(
            //                 fontSize: height / 50, fontWeight: FontWeight.bold),
            //           ),
            //           Row(
            //             children: [
            //               const Icon(
            //                 Icons.access_time_rounded,
            //                 color: Colors.grey,
            //               ),
            //               Text(
            //                 "25days 01:32:53",
            //                 style: TextStyle(
            //                   fontSize: height / 60,
            //                 ),
            //               ),
            //             ],
            //           ),
            //         ],
            //       ),
            //       Text(
            //         "Tasks to be completed every month",
            //         style:
            //             TextStyle(fontSize: height / 60, color: Colors.black),
            //       ),
            //       SizedBox(
            //         height: height / 90,
            //       ),
            //       Text(
            //         "Option Task A",
            //         style: TextStyle(
            //             fontSize: height / 60,
            //             color: Colors.black,
            //             fontWeight: FontWeight.bold),
            //       ),
            //       SizedBox(
            //         height: height / 90,
            //       ),
            //       Container(
            //         height: height / 10,
            //         width: width / 1.2,
            //         decoration: BoxDecoration(
            //           borderRadius: BorderRadius.circular(20),
            //           color: Colors.white,
            //           boxShadow: [
            //             BoxShadow(
            //               color: Colors.grey.withOpacity(0.5),
            //               spreadRadius: 1,
            //               blurRadius: 5,
            //             ),
            //           ],
            //         ),
            //         padding: EdgeInsets.symmetric(
            //             horizontal: width / 30, vertical: height / 80),
            //         child: Row(
            //           children: [
            //             const Icon(
            //               Icons.abc,
            //               color: Colors.purple,
            //             ),
            //             SizedBox(
            //               width: width / 30,
            //             ),
            //             Column(
            //               crossAxisAlignment: CrossAxisAlignment.start,
            //               children: [
            //                 Text(
            //                   "Number of invited creators",
            //                   style: TextStyle(
            //                       fontWeight: FontWeight.bold,
            //                       fontSize: height / 60),
            //                 ),
            //                 Text(
            //                   "2/5",
            //                   style: TextStyle(fontSize: height / 60),
            //                 ),
            //                 SizedBox(
            //                   width: width / 2.5,
            //                   child: const LinearProgressIndicator(
            //                     value: .75,
            //                     borderRadius: BorderRadius.all(
            //                       Radius.circular(20),
            //                     ),
            //                     valueColor:
            //                         AlwaysStoppedAnimation<Color>(Colors.green),
            //                   ),
            //                 )
            //               ],
            //             ),
            //           ],
            //         ),
            //       ),
            //       SizedBox(
            //         height: height / 90,
            //       ),
            //       Container(
            //         height: height / 10,
            //         width: width / 1.2,
            //         decoration: BoxDecoration(
            //           borderRadius: BorderRadius.circular(20),
            //           color: Colors.white,
            //           boxShadow: [
            //             BoxShadow(
            //               color: Colors.grey.withOpacity(0.5),
            //               spreadRadius: 1,
            //               blurRadius: 5,
            //             ),
            //           ],
            //         ),
            //         padding: EdgeInsets.symmetric(
            //             horizontal: width / 30, vertical: height / 80),
            //         child: Row(
            //           children: [
            //             const Icon(
            //               Icons.abc,
            //               color: Colors.purple,
            //             ),
            //             SizedBox(
            //               width: width / 30,
            //             ),
            //             Column(
            //               crossAxisAlignment: CrossAxisAlignment.start,
            //               children: [
            //                 Text(
            //                   "Number of valid new Creators",
            //                   style: TextStyle(
            //                       fontWeight: FontWeight.bold,
            //                       fontSize: height / 60),
            //                 ),
            //                 Text(
            //                   "3/5",
            //                   style: TextStyle(fontSize: height / 60),
            //                 ),
            //                 SizedBox(
            //                   width: width / 2.5,
            //                   child: const LinearProgressIndicator(
            //                     value: .75,
            //                     borderRadius: BorderRadius.all(
            //                       Radius.circular(20),
            //                     ),
            //                     valueColor:
            //                         AlwaysStoppedAnimation<Color>(Colors.green),
            //                   ),
            //                 )
            //               ],
            //             ),
            //           ],
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            // SizedBox(
            //   height: height / 40,
            // ),
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AgencyCreator(),
                      ),
                    );
                  },
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Text(
                        'Creator',
                        style: TextStyle(
                            fontSize:
                                height / 40, // Adjust the font size as needed
                            fontWeight: FontWeight.bold,
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
                ),
                SizedBox(
                  width: width / 30,
                ),
                const Text("Commision rate: "),
                SizedBox(
                  width: width / 30,
                ),
                const Text(
                  "23",
                  style: TextStyle(color: Colors.yellow),
                ),
                SizedBox(
                  width: width / 30,
                ),
                const Text("Creator"),
              ],
            ),
            SizedBox(
              height: height / 40,
            ),
            Container(
              width: width / 1.2,
              padding: EdgeInsets.symmetric(
                  horizontal: width / 30, vertical: height / 35),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "December",
                    style: TextStyle(
                        fontSize: height / 40, // Adjust the font size as needed
                        fontWeight: FontWeight.bold,
                        // Adjust the font weight as needed
                        letterSpacing: 1),
                  ),
                  SizedBox(
                    height: height / 80,
                  ),
                  Row(
                    children: [
                      Text(
                        "Total: ",
                        style: TextStyle(
                            fontSize: height / 55, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "23%",
                        style: TextStyle(
                            fontSize: height / 60,
                            color: Colors.yellow,
                            fontWeight: FontWeight.bold),
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

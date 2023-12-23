import 'package:flutter/material.dart';
import 'package:spinner_try/screen/room.dart';
import 'package:spinner_try/screen/trending_list.dart';
import 'package:spinner_try/shivanshu/screens/audio_live_screen.dart';
import 'package:spinner_try/shivanshu/screens/home_live_screen.dart';
import 'package:spinner_try/shivanshu/utils.dart';
import 'package:spinner_try/shivanshu/widgets/tab_view.dart';

class HomePage extends StatefulWidget {
  int selectedTab = 0;
  HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _pageView = PageController();
  final imgUrls = [
    'https://stoild.in/wp-content/uploads/2023/05/re2.png',
    'https://stoild.in/wp-content/uploads/2023/05/reviews1-e1683543553269-300x291-1.png',
    'https://stoild.in/wp-content/uploads/2023/05/reviews.png',
  ];
  final List<String> tabs = [
    'Live',
    'Audio',
  ];
  bool showAlert = false;
  

  
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: TabView(
          defaultSelected: widget.selectedTab,
          key: UniqueKey(),
          items: [
            Image.asset('assets/live_grey.png'),
            Image.asset('assets/audio_grey.png'),
            // Image.asset('assets/game_grey.png'),
          ],
          selectedItems: [
            Image.asset('assets/live.png'),
            Image.asset('assets/audio.png'),
            // Image.asset('assets/game.png'),
          ],
          onTap: (index) {
            _pageView.animateToPage(
              index,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );
          },
        ),
        actions: [
          IconButton(
            onPressed: () {
              navigatorPush(context, const MyRoom());
            },
            icon: Image.asset('assets/profile.png'),
          ),
          IconButton(
            onPressed: () {
              navigatorPush(context, TrendingList());
              showMsg(context, 'In Development');
            },
            icon: Image.asset('assets/trophy.png'),
          ),
          IconButton(
            onPressed: () {
              showMsg(context, "Search");
            },
            icon: Image.asset('assets/search.png'),
          ),
        ],
      ),
      body: Stack(
        alignment: Alignment.bottomRight,
        children: [
          PageView(
            controller: _pageView,
            onPageChanged: (value) {
              if (context.mounted) {
                setState(() {
                  widget.selectedTab = value;
                });
              }
            },
            children: [
              HomeLive(
                  tabs: tabs,
                  widget: widget,
                  mediaQuery: mediaQuery,
                  height: height,
                  width: width),
              AudioLive(
                  tabs: tabs,
                  widget: widget,
                  mediaQuery: mediaQuery,
                  height: height,
                  width: width),
              // GameLive(
              //     tabs: tabs,
              //     widget: widget,
              //     mediaQuery: mediaQuery,
              //     height: height,
              //     width: width),
            ],
          ),
          // SafeArea(
          //   child: InkWell(
          //     onTap: () {
          //       navigatorPush(context, const FollowingPage());
          //     },
          //     child: Container(
          //       decoration: const BoxDecoration(
          //         color: Color.fromARGB(255, 113, 218, 118),
          //         borderRadius: BorderRadius.only(
          //           topLeft: Radius.circular(20),
          //           bottomLeft: Radius.circular(20),
          //         ),
          //       ),
          //       padding: const EdgeInsets.only(
          //         left: 8,
          //         top: 2,
          //         bottom: 2,
          //       ),
          //       child: Row(
          //         mainAxisSize: MainAxisSize.min,
          //         children: [
          //           SizedBox(
          //             width: 40,
          //             height: 40,
          //             child: Stack(
          //               children: [
          //                 Positioned(
          //                   top: 0,
          //                   left: 0,
          //                   child: CircleAvatar(
          //                     radius: 14,
          //                     backgroundImage: NetworkImage(
          //                       imgUrls[0],
          //                     ),
          //                   ),
          //                 ),
          //                 Positioned(
          //                   top: 0,
          //                   right: 0,
          //                   child: CircleAvatar(
          //                     radius: 14,
          //                     backgroundImage: NetworkImage(
          //                       imgUrls[1],
          //                     ),
          //                   ),
          //                 ),
          //                 Positioned(
          //                   bottom: 0,
          //                   left: 0,
          //                   child: CircleAvatar(
          //                     radius: 14,
          //                     backgroundImage: NetworkImage(
          //                       imgUrls[2],
          //                     ),
          //                   ),
          //                 ),
          //                 Positioned(
          //                   right: 0,
          //                   bottom: 0,
          //                   child: CircleAvatar(
          //                     radius: 14,
          //                     backgroundImage: NetworkImage(
          //                       imgUrls[0],
          //                     ),
          //                   ),
          //                 ),
          //               ],
          //             ),
          //           ),
          //           const SizedBox(
          //             width: 3,
          //           ),
          //           Text(
          //             '116 followers\nin the rooms',
          //             style: textTheme(context).bodySmall!.copyWith(
          //                   fontWeight: FontWeight.bold,
          //                 ),
          //           ),
          //         ],
          //       ),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}

class GameLive extends StatelessWidget {
  const GameLive({
    super.key,
    required this.tabs,
    required this.widget,
    required this.mediaQuery,
    required this.height,
    required this.width,
  });

  final List<String> tabs;
  final HomePage widget;
  final MediaQueryData mediaQuery;
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: () {
                // navigatorPush(context, CameraScreen());
              },
              child: Card(
                color: const Color.fromARGB(255, 224, 93, 211),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(right: 1.0),
                        child: Icon(
                          Icons.star_rounded,
                          color: Colors.amber,
                          size: 12,
                        ),
                      ),
                      Text(
                        tabs[widget.selectedTab],
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              color: Theme.of(context).colorScheme.onPrimary,
                              fontSize: 10,
                            ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                showMsg(context, 'Hehe');
              },
              child: Container(
                width: mediaQuery.size.width,
                height: 100,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 192, 105, 105),
                  borderRadius: BorderRadius.circular(10),
                  image: const DecorationImage(
                    image: AssetImage('assets/banner.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: height / 2.3,
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 2,
                  mainAxisSpacing: 2,
                ),
                itemCount: 4,
                itemBuilder: (context, index) {
                  return Container(
                    decoration: BoxDecoration(boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(.1),
                        blurRadius: 2,
                      ),
                    ]),
                    child: Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.black12,
                                width: 1,
                              ),
                              color: Colors.white),
                          child: Image.asset(
                            "assets/mohtarma.png",
                            filterQuality: FilterQuality.high,
                            fit: BoxFit.cover,
                            height: height / 5,
                          ),
                        ),
                        Positioned(
                          left: width / 3.3,
                          top: height / 80,
                          child: Text(
                            "00:00",
                            style: TextStyle(
                              fontSize: height / 75,
                              color: const Color(0xFFE05DD3),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: height / 18,
                          left: width / 50,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 5,
                            ),
                            clipBehavior: Clip.hardEdge,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              gradient: LinearGradient(
                                begin: AlignmentDirectional.centerStart,
                                end: AlignmentDirectional.centerEnd,
                                colors: [
                                  const Color(0xFFE05DD3).withOpacity(.7),
                                  const Color(0xFFE05DD3).withOpacity(.7),
                                ],
                              ),
                            ),
                            child: Text(
                              "Live",
                              style: TextStyle(
                                fontSize: height / 80,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: height / 25,
                          left: width / 6,
                          child: Text(
                            "Name",
                            style: TextStyle(
                              fontSize: height / 70,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: height / 50,
                          left: width / 30,
                          child: Row(
                            children: [
                              Image.asset(
                                'assets/Home_white.png',
                                height: height / 80,
                              ),
                              SizedBox(
                                width: width / 40,
                              ),
                              Text(
                                "Agent",
                                style: TextStyle(
                                    fontSize: height / 80, color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                        // Positioned(child: child),
                      ],
                    ),
                  );
                },
              ),
            ),
            InkWell(
              onTap: () {
                showMsg(context, 'Hehe');
              },
              child: Container(
                width: mediaQuery.size.width,
                height: 100,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 192, 105, 105),
                  borderRadius: BorderRadius.circular(10),
                  image: const DecorationImage(
                    image: AssetImage('assets/banner.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 150,
            ),
          ],
        ),
      ),
    );
  }
}
// import 'package:flutter/material.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: MyHomePage(),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   bool showAlert = false;

//   @override
//   void initState() {
//     super.initState();

//     Future.delayed(Duration(seconds: 2), () {
//       setState(() {
//         showAlert = true;
//       });
//       _showAlertDialog();
//     });
//   }

//   void _showAlertDialog() {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text('Alert Dialog'),
//           content: Text('This is an alert dialog that appears after 2 seconds.'),
//           actions: <Widget>[
//             ElevatedButton (
//               child: Text('OK'),
//               onPressed: () {
//                 // Close the dialog
//                 Navigator.of(context).pop();
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Show AlertDialog'),
//       ),
//       body: Center(
//         child: ElevatedButton(
//           onPressed: () {
//             // Show the AlertDialog immediately when the button is pressed
//             setState(() {
//               showAlert = true;
//             });
//             _showAlertDialog();
//           },
//           child: Text('Show AlertDialog'),
//         ),
//       ),
//     );
//   }
// }

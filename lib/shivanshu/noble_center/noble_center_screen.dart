// import 'package:flutter/material.dart';
// import 'package:spinner_try/shivanshu/noble_center/duke_screen.dart';
// import 'package:spinner_try/shivanshu/screens/family_room_page.dart';
// import 'package:spinner_try/shivanshu/utils.dart';

// class NobleScreen extends StatefulWidget {
//   const NobleScreen({super.key});

//   @override
//   State<NobleScreen> createState() => _NobleScreenState();
// }

// class _NobleScreenState extends State<NobleScreen>
//     with TickerProviderStateMixin {
//   late final _tabController;

//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(length: 4, vsync: this);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       appBar: AppBar(
//         title: const Text('Noble Center'),
//         leading: const ElevatedBackButton(),
//         actions: [
//           ElevatedButton.icon(
//             onPressed: () {
//               showMsg(context, 'In Dev.');
//             },
//             icon: const Icon(Icons.mail_rounded),
//             label: const Text('VIP'),
//           ),
//         ],
//         bottom: PreferredSize(
//           preferredSize: const Size.fromHeight(40),
//           child: Container(
//             width: width,
//             padding: const EdgeInsets.symmetric(horizontal: 10),
//             decoration: const BoxDecoration(color: Colors.black),
//             child: TabBar(
//               indicatorColor: Colors.amber,
//               dividerColor: Colors.transparent,
//               overlayColor: MaterialStateProperty.all(Colors.amber),
//               labelColor: Colors.white,
//               unselectedLabelColor: Colors.grey,
//               controller: _tabController,
//               isScrollable: true,
//               labelPadding:
//                   const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
//               tabs: const [
//                 Text('Duke'),
//                 Text('Earl'),
//                 Text('Viscount'),
//                 Text('Knight'),
//               ],
//             ),
//           ),
//         ),
//       ),
//       body: TabBarView(
//         controller: _tabController,
//         children: const [
//           ViscountPage(), // Duke Page
//           ViscountPage(),
//           ViscountPage(),
//           ViscountPage(),
//         ],
//       ),
//     );
//   }
// }

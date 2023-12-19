// import 'package:flutter/material.dart';
// import 'package:spinner_try/shivanshu/utils.dart';

// class ViscountPage extends StatelessWidget {
//   const ViscountPage({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final List<Color> pinkToPurpleColors = generateGradientColors(10, [
//       Colors.cyan,
//       Colors.blue,
//       Colors.amber,
//     ]);
//     return Padding(
//       padding: const EdgeInsets.all(10.0),
//       child: SingleChildScrollView(
//         child: MyColumn(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             Image.asset('assets/duke.png'),
//             Container(
//               width: width - width / 10,
//               decoration: BoxDecoration(
//                 borderRadius: const BorderRadius.only(
//                   topLeft: Radius.circular(10),
//                   topRight: Radius.circular(10),
//                 ),
//                 border: Border.all(
//                   color: const Color.fromARGB(255, 146, 146, 131),
//                 ),
//                 color: const Color.fromARGB(255, 146, 146, 131),
//                 gradient: LinearGradient(
//                   begin: Alignment.topCenter,
//                   end: Alignment.bottomCenter,
//                   colors: [
//                     Colors.white.withOpacity(0.01),
//                     Colors.black,
//                   ],
//                 ),
//               ),
//               child: MyColumn(
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceAround,
//                     children: [
//                       const MyColumn(
//                         children: [
//                           Text(
//                             'INR 84,900',
//                             style: TextStyle(
//                               color: Colors.white,
//                             ),
//                           ),
//                           Text(
//                             'First month cost',
//                             style: TextStyle(
//                               color: Colors.white54,
//                               fontSize: 10,
//                             ),
//                           ),
//                         ],
//                       ),
//                       const Divider(color: Colors.white),
//                       MyColumn(
//                         children: [
//                           MyRow(
//                             children: [
//                               Image.asset(
//                                 'assets/diamond.png',
//                                 width: 15,
//                                 color: Colors.amber,
//                               ),
//                               const Text(
//                                 '54,000',
//                                 style: TextStyle(
//                                   color: Colors.white,
//                                 ),
//                               ),
//                             ],
//                           ),
//                           const Text(
//                             'Total diamond rebate',
//                             style: TextStyle(
//                               color: Colors.white54,
//                               fontSize: 10,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                   Container(
//                     decoration: BoxDecoration(
//                       color: Colors.grey[800],
//                     ),
//                     padding:
//                         const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
//                     child: MyRow(
//                       children: [
//                         Container(
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(20),
//                             color: const Color(0xffdc534b),
//                           ),
//                           padding: const EdgeInsets.symmetric(
//                             horizontal: 4,
//                             vertical: 2,
//                           ),
//                           child: const Text(
//                             'Great Deal',
//                             style: TextStyle(
//                               color: Colors.white,
//                               fontWeight: FontWeight.bold,
//                               fontSize: 12,
//                             ),
//                           ),
//                         ),
//                         const Expanded(
//                           child: Text(
//                             'Monthly Subscription only costs ₹28300 and you\'ll get 18000 diamonds as rebate',
//                             style: TextStyle(
//                               color: Color.fromARGB(255, 197, 165, 49),
//                               fontSize: 12,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             Container(
//               padding: const EdgeInsets.all(10),
//               decoration: const BoxDecoration(
//                 borderRadius: BorderRadius.only(
//                   topLeft: Radius.circular(20),
//                   topRight: Radius.circular(20),
//                   bottomLeft: Radius.circular(20),
//                   bottomRight: Radius.circular(20),
//                 ),
//                 color: Color(0xfffef2d8),
//               ),
//               child: SingleChildScrollView(
//                 child: MyColumn(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     Text(
//                       'Duke Upgrade',
//                       style: TextStyle(
//                           fontSize: 18.sp,
//                           fontWeight: FontWeight.bold,
//                           color: const Color(0xff4e310c)),
//                     ),
//                     SizedBox(height: 20.sp),
//                     Container(
//                       decoration: BoxDecoration(
//                         borderRadius: const BorderRadius.only(
//                           topLeft: Radius.circular(10),
//                           topRight: Radius.circular(10),
//                           bottomLeft: Radius.circular(10),
//                           bottomRight: Radius.circular(10),
//                         ),
//                         border: Border.all(
//                           color: const Color(0xfffde8b9),
//                         ),
//                         // color: Colors.grey[200],
//                       ),
//                       child: MyColumn(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Container(
//                             decoration: BoxDecoration(
//                               borderRadius: const BorderRadius.only(
//                                 topLeft: Radius.circular(10),
//                                 topRight: Radius.circular(10),
//                               ),
//                               color: Colors.grey[200],
//                             ),
//                             width: width,
//                             child: Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               child: MyRow(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   Text(
//                                     'Level',
//                                     style: TextStyle(
//                                         fontSize: 14.sp,
//                                         color: Colors.grey[600]),
//                                   ),
//                                   Text(
//                                     'Label',
//                                     style: TextStyle(
//                                         fontSize: 14.sp,
//                                         color: Colors.grey[600]),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

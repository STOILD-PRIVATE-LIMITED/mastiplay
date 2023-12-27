import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:spinner_try/main.dart';
import 'package:spinner_try/shivanshu/models/firestore/firestore_document.dart';
import 'package:spinner_try/shivanshu/models/globals.dart';
import 'package:spinner_try/shivanshu/screens/family_room_page.dart';
import 'package:spinner_try/shivanshu/screens/home_live.dart';
import 'package:spinner_try/shivanshu/utils.dart';
import 'package:spinner_try/shivanshu/utils/loading_elevated_button.dart';
import 'package:spinner_try/user_model.dart';

class FrameChooseScreen extends StatefulWidget {
  final String name;
  final String gender;
  final String email;
  final String country;
  final String? imgUrl;
  final DateTime dob;

  const FrameChooseScreen({
    super.key,
    required this.name,
    required this.gender,
    required this.email,
    required this.country,
    this.imgUrl,
    required this.dob,
  });

  @override
  State<FrameChooseScreen> createState() => _FrameChooseScreenState();
}

class _FrameChooseScreenState extends State<FrameChooseScreen> {
  int? selectedIndex;
  TextEditingController nameController = TextEditingController();

  Future<void> _submitForm() async {
    // final isValid = _formKey.currentState!.validate();
    if (selectedIndex == null) {
      showMsg(context, "Choose a frame please.");
      return;
    }
    final db = FirebaseFirestore.instance;

    currentUser = UserModel(
      email: widget.email,
      name: widget.name,
      photo: widget.imgUrl ?? '',
      gender: (widget.gender == 'Male') ? 0 : 1,
      dob: widget.dob,
      country: widget.country,
      frame: (selectedIndex! + 1).toString(),
    );
    final id = await randomSet(
      FirestoreDocument(
        id: widget.email,
        path: 'users',
        data: currentUser.toJson(),
      ),
      digitCount: 8,
      uniqueCondition: (transaction, id) async {
        log("uniqueCondition called for id: $id");
        final doc = await FirebaseFirestore.instance
            .collection('users')
            .where('id', isEqualTo: id)
            .get();
        log("uniqueCondition is ${doc.docs.isEmpty}");
        return doc.docs.isEmpty;
      },
      docSet: (transaction, id, data) async {
        log("docSet called for id: $id");
        data['id'] = id.toString();
        data['updatedAt'] = DateTime.now().toIso8601String();
        log("Adding things was succesful");
        transaction.set(db.collection('users').doc(widget.email), data);
      },
    ).whenComplete(() {
      while (Navigator.of(context).canPop()) {
        Navigator.of(context).pop();
      }
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) {
            return NewAuth();
          },
        ),
      );
      // setState(() {});
    });
    currentUser.id = id.toString();
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Navigator.of(context).canPop()
            ? ElevatedBackButton(
                onTap: () {
                  Navigator.pop(context);
                },
              )
            : null,
        title: const Text('Choose a Frame'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: width,
                    height: 130,
                    // clipBehavior: Clip.hardEdge,
                    decoration: const BoxDecoration(
                        // shape: BoxShape.circle,
                        ),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Positioned(
                          left: 0,
                          right: 0,
                          top: 30,
                          bottom: 10,
                          child: Container(
                            clipBehavior: Clip.hardEdge,
                            decoration:
                                const BoxDecoration(shape: BoxShape.circle),
                            child: Hero(
                              tag: widget.gender,
                              child: widget.imgUrl != null
                                  ? Image.network(widget.imgUrl!,
                                      fit: BoxFit.cover)
                                  : Image.asset(
                                      widget.gender == 'Male'
                                          ? 'assets/male.jpg'
                                          : 'assets/female.jpg',
                                      fit: BoxFit.contain,
                                      width: 150,
                                    ),
                            ),
                          ),
                        ),
                        if (selectedIndex != null)
                          Image.asset(
                            "assets/Frame ${selectedIndex! + 1}.png",
                            // width: 150,
                            height: 220,
                            fit: BoxFit.fitHeight,
                          ),
                      ],
                    ),
                  ),
                  Text(
                    'Choose a frame for your profile picture',
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 30.sp),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Stack(
                              alignment: Alignment.bottomRight,
                              children: [
                                Container(
                                  clipBehavior: Clip.hardEdge,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    // color: Colors.black12.withOpacity(0.05),
                                  ),
                                  child: InkWell(
                                    child: Image.asset(
                                      'assets/Frame 1.png',
                                      fit: BoxFit.contain,
                                      height: 100,
                                    ),
                                    onTap: () {
                                      setState(() {
                                        selectedIndex = 0;
                                      });
                                    },
                                  ),
                                ),
                                Icon(Icons.check_circle,
                                    color: selectedIndex == 0
                                        ? Colors.green
                                        : Colors.transparent),
                              ],
                            ),
                            SizedBox(height: 10.sp),
                            Text(
                              'Frame 1',
                              style: TextStyle(
                                color: selectedIndex == 0
                                    ? const Color.fromARGB(255, 59, 214, 168)
                                    : Colors.black26,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Stack(
                              alignment: Alignment.bottomRight,
                              children: [
                                Container(
                                  clipBehavior: Clip.hardEdge,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    // color: Colors.black12.withOpacity(0.05),
                                  ),
                                  child: InkWell(
                                    child: Image.asset(
                                      'assets/Frame 2.png',
                                      fit: BoxFit.contain,
                                      height: 100,
                                    ),
                                    onTap: () {
                                      setState(() {
                                        selectedIndex = 1;
                                      });
                                    },
                                  ),
                                ),
                                Icon(
                                  Icons.check_circle,
                                  color: selectedIndex == 1
                                      ? Colors.green
                                      : Colors.transparent,
                                ),
                              ],
                            ),
                            SizedBox(height: 10.sp),
                            Text(
                              'Frame 2',
                              style: TextStyle(
                                color: selectedIndex == 1
                                    ? const Color.fromARGB(255, 59, 214, 168)
                                    : Colors.black26,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 50.sp),
                  Hero(
                    tag: 'submit',
                    child: Card(
                      elevation: 0,
                      color: Colors.transparent,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          shaderWidget(
                            context,
                            colors: [
                              Colors.yellow.withOpacity(0.7),
                              Colors.blueAccent.withOpacity(0.7),
                            ],
                            child: LoadingElevatedButton(
                              icon: const Icon(Icons.donut_large_rounded),
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(40),
                                ),
                                padding: EdgeInsets.symmetric(
                                  horizontal: width * 0.8,
                                  vertical: 20,
                                ),
                                foregroundColor: Colors.black,
                              ),
                              onPressed: _submitForm,
                              label: const Text(
                                '                  ',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: _submitForm,
                            child: const Text(
                              'Continue',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

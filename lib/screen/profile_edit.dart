import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../auth.dart';

class ProfileEdit extends StatefulWidget {
  const ProfileEdit({super.key});

  @override
  State<ProfileEdit> createState() => _ProfileEditState();
}

class _ProfileEditState extends State<ProfileEdit> {
  String selectedGender = 'Male';
  File? img;
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
          "Edit Profile",
          style: TextStyle(fontSize: height / 40),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: width / 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.center,
              child: Stack(
                children: [
                  CircleAvatar(
                    radius: height / 15,
                    backgroundImage: img == null
                        ? const AssetImage("assets/background.jpg")
                        : FileImage(img!) as ImageProvider,
                  ),
                  Positioned(
                    bottom: 1,
                    right: 5,
                    child: IconButton(
                      color: Theme.of(context).colorScheme.primary,
                      style: IconButton.styleFrom(
                          backgroundColor: Theme.of(context)
                              .colorScheme
                              .background
                              .withOpacity(0.5)),
                      onPressed: () {
                        ImagePicker()
                            .pickImage(
                          source: ImageSource.gallery,
                          imageQuality: 50,
                          maxWidth: 200,
                        )
                            .then((value) {
                          if (value == null) return;
                          setState(() => img = File(value.path));
                        });
                      },
                      icon: Icon(
                        Icons.camera_alt,
                        color: Colors.pink,
                        size: height / 30,
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: height / 30,
            ),
            Text(
              "Basic information",
              style:
                  TextStyle(fontSize: height / 50, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: height / 50,
            ),
            ListTile(
              title: Text(
                "Name",
                style: TextStyle(
                    fontSize: height / 50, fontWeight: FontWeight.bold),
              ),
              trailing: SizedBox(
                width: width / 3,
                height: height / 20,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("UserName",
                        style: TextStyle(
                            fontSize: height / 50, color: Colors.grey)),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: height / 50,
                    )
                  ],
                ),
              ),
            ),
            ListTile(
              title: Text(
                "Age",
                style: TextStyle(
                    fontSize: height / 50, fontWeight: FontWeight.bold),
              ),
              trailing: SizedBox(
                width: width / 3,
                height: height / 20,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("24",
                        style: TextStyle(
                            fontSize: height / 50, color: Colors.grey)),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: height / 50,
                    )
                  ],
                ),
              ),
            ),
            ListTile(
              title: Text(
                "Bio",
                style: TextStyle(
                    fontSize: height / 50, fontWeight: FontWeight.bold),
              ),
              trailing: SizedBox(
                width: width / 3,
                height: height / 20,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Available",
                        style: TextStyle(
                            fontSize: height / 50, color: Colors.grey)),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: height / 50,
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: height / 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  children: [
                    Radio(
                      value: 'Male',
                      groupValue: selectedGender,
                      onChanged: (value) {
                        setState(() {
                          selectedGender = value!;
                        });
                      },
                    ),
                    Text(
                      'Male',
                      style: TextStyle(
                          fontSize: height / 50, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Radio(
                      value: 'Female',
                      groupValue: selectedGender,
                      onChanged: (value) {
                        setState(() {
                          selectedGender = value!;
                        });
                      },
                    ),
                    Text(
                      'Female',
                      style: TextStyle(
                          fontSize: height / 50, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: height / 25,
            ),
            Align(
              alignment: Alignment.center,
              child: GestureDetector(
                onTap: () async {},
                child: Center(
                  child: Text(
                    "Save",
                    style: TextStyle(
                      color: Colors.pink ,
                      fontSize: height / 50,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: height / 25,
            ),
            Align(
              alignment: Alignment.center,
              child: GestureDetector(
                onTap: () async {
                  while (Navigator.of(context).canPop()) {
                    Navigator.of(context).pop();
                  }
                  await FirebaseAuth.instance.signOut();
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => const MyAuth(),
                    ),
                  );
                },
                child: Container(
                  height: height / 15,
                  width: width / 2,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.pink,
                  ),
                  child: Center(
                    child: Text(
                      "Logout",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: height / 50,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

            // SizedBox(
            //   height: height / 30,
            // ),
            // Text(
            //   "Album 1/1",
            //   style:
            //       TextStyle(fontSize: height / 50, fontWeight: FontWeight.bold),
            // ),
            // SizedBox(
            //   height: height / 50,
            // ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceAround,
            //   children: [
            //     Container(
            //       decoration: BoxDecoration(
            //         borderRadius: BorderRadius.circular(10),
            //         border: Border.all(color: Colors.grey),
            //       ),
            //       alignment: Alignment.center,
            //       height: height / 8,
            //       width: width / 4,
            //       child: const Icon(
            //         Icons.add,
            //         color: Colors.black,
            //       ),
            //     ),
            //     Container(
            //       decoration: BoxDecoration(
            //         borderRadius: BorderRadius.circular(10),
            //         border: Border.all(color: Colors.grey),
            //       ),
            //       alignment: Alignment.center,
            //       height: height / 8,
            //       width: width / 4,
            //       child: const Icon(
            //         Icons.add,
            //         color: Colors.black,
            //       ),
            //     ),
            //     Container(
            //       decoration: BoxDecoration(
            //         borderRadius: BorderRadius.circular(10),
            //         border: Border.all(color: Colors.grey),
            //       ),
            //       alignment: Alignment.center,
            //       height: height / 8,
            //       width: width / 4,
            //       child: const Icon(
            //         Icons.add,
            //         color: Colors.black,
            //       ),
            //     ),
            //   ],
            // ),
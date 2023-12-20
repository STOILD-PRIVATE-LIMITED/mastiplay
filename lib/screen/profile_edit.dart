import 'dart:io';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:scroll_date_picker/scroll_date_picker.dart';
import 'package:spinner_try/screen/login.dart';
import 'package:spinner_try/user_model.dart';


class ProfileEdit extends StatefulWidget {
  const ProfileEdit({super.key});

  @override
  State<ProfileEdit> createState() => _ProfileEditState();
}

class _ProfileEditState extends State<ProfileEdit> {
  String selectedGender = 'Male';
  File? img;
  final db = FirebaseFirestore.instance;

  String name = '';
  String photoUrl = '';
  String userEmail = '';
  int userGender = 0;
  DateTime? userAge;
  int age = 0;

  List<UserModel> users = [];
  final user = FirebaseAuth.instance.currentUser;
  getProfile() async {
    final email = user!.email;
    userEmail = email.toString();
    final snapshot =
        await db.collection("users").where("email", isEqualTo: email).get();
    users =
        snapshot.docs.map<UserModel>((e) => UserModel.fromSnapahot(e)).toList();
    name = users[0].name;
    userGender = users[0].gender;
    photoUrl = users[0].photo;
    userAge = users[0].dob;
    age = calculateAge(userAge.toString());
    setState(() {});
  }

  int calculateAge(String dateString) {
    DateTime birthDate =
        DateFormat('yyyy-MM-dd HH:mm:ss.SSS').parse(dateString);
    DateTime currentDate = DateTime.now();
    int age = currentDate.year - birthDate.year;
    if (currentDate.month < birthDate.month ||
        (currentDate.month == birthDate.month &&
            currentDate.day < birthDate.day)) {
      age--;
    }

    return age;
  }

  updateName() async {
    final email = user!.email;
    final userRef = FirebaseFirestore.instance.collection('users');
    final userDoc = await userRef.where('email', isEqualTo: email).get();
    final userDocId = userDoc.docs.first.id;
    await userRef.doc(userDocId).update({
      'name': nameController.text,
    });
  }

  updateDob() async {
    final email = user!.email;
    final userRef = FirebaseFirestore.instance.collection('users');
    final userDoc = await userRef.where('email', isEqualTo: email).get();
    final userDocId = userDoc.docs.first.id;
    await userRef.doc(userDocId).update({
      'dob': _selectedDate,
    });
  }

  TextEditingController nameController = TextEditingController();
  DateTime _selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    getProfile();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xFFf7f8fc),
      appBar: AppBar(
        backgroundColor: const Color(0xFFf7f8fc),
        // leading: GestureDetector(
        //   onTap: () {
        //     // Navigator.pop(context);
        //   },
        //   child: Icon(
        //     Icons.arrow_back_ios,
        //     size: height / 40,
        //   ),
        // ),
        title: Text(
          "Edit Profile",
          style: TextStyle(fontSize: height / 40),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
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
                          ? photoUrl.isEmpty
                              ? const AssetImage("assets/background.jpg")
                              : NetworkImage(photoUrl) as ImageProvider
                          : FileImage(img!),
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
              Align(
                alignment: Alignment.center,
                child: Text(
                  "Basic information",
                  style: TextStyle(
                      fontSize: height / 50, fontWeight: FontWeight.bold),
                ),
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
                  width: width / 2.2,
                  height: height / 20,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(name.isEmpty ? "UserName" : name,
                          style: TextStyle(
                              fontSize: height / 50, color: Colors.grey)),
                      GestureDetector(
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: const Text("Change Name"),
                                  content: TextField(
                                    controller: nameController,
                                    decoration: const InputDecoration(
                                      hintText: "Enter new name",
                                    ),
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        updateName();
                                        setState(() {
                                          name = nameController.text;
                                        });
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                            content: Text(
                                                'Name updated successfully'),
                                          ),
                                        );
                                        Navigator.pop(context);
                                      },
                                      child: const Text("Save"),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Text("Cancel"),
                                    ),
                                  ],
                                );
                              });
                        },
                        child: Icon(
                          Icons.arrow_forward_ios,
                          size: height / 50,
                        ),
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
                  width: width / 2.2,
                  height: height / 20,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('$age',
                          style: TextStyle(
                              fontSize: height / 50, color: Colors.grey)),
                      GestureDetector(
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20),
                            )),
                            clipBehavior: Clip.hardEdge,
                            builder: (context) {
                              return Scaffold(
                                appBar: AppBar(
                                  backgroundColor: Colors.transparent,
                                  surfaceTintColor: Colors.transparent,
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        updateDob();
                                        setState(() {
                                          age = calculateAge(
                                              _selectedDate.toString());
                                        });
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                            content: Text(
                                                'Date of birth updated successfully'),
                                          ),
                                        );
                                        Navigator.pop(context);
                                      },
                                      child: const Text('Confirm'),
                                    ),
                                  ],
                                ),
                                body: SizedBox(
                                  height: height / 2,
                                  child: ScrollDatePicker(
                                    selectedDate:
                                        _selectedDate ?? DateTime.now(),
                                    locale: const Locale('en'),
                                    options: const DatePickerOptions(
                                      isLoop: false,
                                    ),
                                    onDateTimeChanged: (DateTime value) {
                                      setState(() {
                                        _selectedDate = value;
                                      });
                                    },
                                  ),
                                ),
                              );
                            },
                          );
                        },
                        child: Icon(
                          Icons.arrow_forward_ios,
                          size: height / 50,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              ListTile(
                title: Text(
                  "Email",
                  style: TextStyle(
                      fontSize: height / 50, fontWeight: FontWeight.bold),
                ),
                trailing: Text(userEmail,
                    style:
                        TextStyle(fontSize: height / 60, color: Colors.grey)),
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
                  onTap: () async {
                    // while (Navigator.of(context).canPop()) {
                    //   Navigator.of(context).pop();
                    // }
                    await FirebaseAuth.instance.signOut();
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => const Login(),
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
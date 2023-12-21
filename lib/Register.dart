// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:spinner_try/components/button.dart';
import 'package:spinner_try/components/textfield.dart';
import 'package:spinner_try/shivanshu/models/globals.dart';
import 'package:spinner_try/shivanshu/screens/gender_screen.dart';
import 'package:spinner_try/shivanshu/utils.dart';
import 'package:spinner_try/shivanshu/utils/image.dart';

class Register extends StatefulWidget {
  final Function()? onTap;
  static String verify = "";
  const Register({super.key, required this.onTap});
  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  final nameController = TextEditingController();
  File? _image1;
  final picker = ImagePicker();
  final phoneController = TextEditingController();
  final otpController = TextEditingController();

  bool pass = true;
  bool isverified = false;
  void visible() {
    setState(() {
      pass = !pass;
    });
  }

  final imageController = TextEditingController();
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;
  Future getImage() async {
    final pickedFile =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 100);
    setState(() {
      if (pickedFile != null) {
        _image1 = File(pickedFile.path);
        imageController.text = pickedFile.name;
      } else {
        imageController.text = "no image picked";
      }
    });
  }

  void signIn() async {
    // try {
    final db = FirebaseFirestore.instance;
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: emailController.text.toLowerCase(),
      password: passwordController.text,
    );
    final Map<String, String?> obj = {
      "name": nameController.text,
      "email": emailController.text.toLowerCase(),
      "photo": await uploadImage(
        context,
        _image1,
        'images',
        auth.currentUser!.email!,
      ),
    };
    assert(obj['email'] != null || obj['email']!.isEmpty,
        "Email shouldn't be empty.");

    navigatorPush(context, GenderScreen(email: obj['email']!));
    // await randomSet(
    //   FirestoreDocument(
    //     id: obj['email']!,
    //     path: 'users',
    //     data: obj,
    //   ),
    //   digitCount: 8,
    //   uniqueCondition: (transaction, id) async {
    //     log("uniqueCondition called for id: $id");
    //     final doc = await FirebaseFirestore.instance
    //         .collection('users')
    //         .where('id', isEqualTo: id)
    //         .get();
    //     log("uniqueCondition is ${doc.docs.isEmpty}");
    //     return doc.docs.isEmpty;
    //   },
    //   docSet: (transaction, id, data) async {
    //     log("docSet called for id: $id");
    //     data['id'] = id.toString();
    //     data['updatedAt'] = DateTime.now().toIso8601String();
    //     log("Adding things was succesful");
    //     transaction.set(db.collection('users').doc(obj['email']), data);
    // },
    //   ).whenComplete(() {
    //     Navigator.pushReplacement(
    //       context,
    //       MaterialPageRoute(
    //         builder: (context) {
    //           return HomeLive(
    //             email: emailController.text.toLowerCase(),
    //           );
    //         },
    //       ),
    //     );
    //     setState(() {});
    //   });
    // } on FirebaseAuthException catch (e) {
    //   Navigator.pop(context);
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     SnackBar(
    //       content: Text(e.code),
    //     ),
    //   );
    //   return;
    // }
    // if (Navigator.of(context).canPop()) {
    //   Navigator.pop(context);
    // }
  }

  void verify() async {
    if (otpController.text == otp.toString()) {
      signIn();
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(
      //     builder: (context) => GenderScreen(
      //       username: nameController.text,
      //       email: emailController.text.toLowerCase(),
      //     ),
      //   ),
      // );
    }
  }

  int otp = 0;

  getOtpFromUrl() async {
    final response =
        await http.post(Uri.parse("https://3.7.66.245:8080/api/otp"), headers: {
      'Content-Type': 'application/json',
      'email': emailController.text.toLowerCase(),
    });
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      otp = data['otp'];
      setState(() {});
    } else {
      throw Exception(
          'Failed to send OTP to your mail: ${emailController.text.toLowerCase()}');
    }
  }

  void signUp() async {
    if (nameController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Name shouldn't be empty"),
        ),
      );
      return;
    }
    if (isEmailExits(emailController.text.toLowerCase())) {
      _showAlertDialog(context);
      return;
    }
    getOtpFromUrl();
    setState(() {
      isverified = true;
    });

    // try {
    //   final db = FirebaseFirestore.instance;
    //   await getOtpFromUrl();
    //   var res = await db
    //       .collection("users")
    //       .where(
    //         "number",
    //         isEqualTo: phone.toString(),
    //       )
    //       .get();
    //   if (res.docs.isNotEmpty) {
    //     Navigator.pop(context);
    //     ScaffoldMessenger.of(context).showSnackBar(
    //       const SnackBar(
    //         content: Text("This number is already registered"),
    //       ),
    //     );
    //   } else {
    //     setState(() {
    //       isverified = true;
    //     });
    // var res1 =
    //     await db.collection("users").where("email", isEqualTo: email).get();
    // if (res1.docs.isNotEmpty) {
    //   Navigator.pop(context);
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     const SnackBar(
    //       content: Text("This email is already registered"),
    //     ),
    //   );
    // } else {
    //   setState(() {
    //     isverified = true;
    //   });
    // }
    // }
    // } on FirebaseAuthException catch (e) {
    //   Navigator.pop(context);
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     SnackBar(
    //       content: Text(e.code),
    //     ),
    //   );
    // }
  }

  final CollectionReference _usersCollection =
      FirebaseFirestore.instance.collection('users');

  List<String> _documentIds = [];

  @override
  void initState() {
    super.initState();
    _fetchDocumentIds();
  }

  Future<void> _fetchDocumentIds() async {
    QuerySnapshot querySnapshot = await _usersCollection.get();
    setState(() {
      _documentIds =
          querySnapshot.docs.map((doc) => doc.id.toString()).toList();
    });
  }

  bool isEmailExits(String email) {
    return _documentIds.contains(email);
  }

  _showAlertDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      title: const Text("Email already exists"),
      content: const Text(
          "Please try with another email or login with existing email"),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text("OK"),
        ),
      ],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) => isverified
      ? Scaffold(
          body: Container(
            constraints: const BoxConstraints.expand(),
            decoration: const BoxDecoration(),
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 100),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 23),
                          child: const Text(
                            "Verify Otp",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 30,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 23),
                          child: Text(
                            "We have sent the code to your email",
                            style: TextStyle(
                                color: Colors.grey[600], fontSize: 18),
                          ),
                        ),
                        const SizedBox(height: 10),
                      ],
                    ),
                    const SizedBox(height: 30),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: TextField(
                        controller: otpController,
                        obscureText: false,
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        decoration: InputDecoration(
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Color(0xFFFF290C),
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          fillColor: Colors.grey.shade200,
                          filled: true,
                          hintText: "Otp",
                          hintStyle:
                              TextStyle(color: Colors.grey[500], fontSize: 18),
                        ),
                      ),
                    ),
                    const SizedBox(height: 35),
                    MyButton(
                      onTap: () => {verify()},
                      text: "Verify OTP",
                    ),
                  ],
                ),
              ),
            ),
          ),
        )
      : Scaffold(
          body: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 75),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 23),
                        child: const Text(
                          "Sign Up",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 30,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 23),
                        child: Text(
                          "Full Name",
                          style:
                              TextStyle(color: Colors.grey[700], fontSize: 18),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  MyTextField(
                    controller: nameController,
                    hintText: 'Name',
                    obscureText: false,
                  ),
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 23),
                        child: Text(
                          "E-mail",
                          style:
                              TextStyle(color: Colors.grey[700], fontSize: 18),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  MyTextField(
                    controller: emailController,
                    hintText: 'Your Email',
                    obscureText: false,
                  ),
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 23),
                        child: Text(
                          "Password",
                          style:
                              TextStyle(color: Colors.grey[700], fontSize: 18),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: TextField(
                      controller: passwordController,
                      obscureText: pass,
                      decoration: InputDecoration(
                        suffixIcon: GestureDetector(
                          onTap: visible,
                          child: pass == true
                              ? Icon(
                                  Icons.visibility,
                                  size: 25,
                                  color: Colors.grey[500],
                                )
                              : Icon(Icons.visibility_off,
                                  color: Colors.grey[500], size: 25),
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.blue),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        fillColor: Colors.grey.shade200,
                        filled: true,
                        hintText: "Password",
                        hintStyle:
                            TextStyle(color: Colors.grey[500], fontSize: 18),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  MyButton(
                    onTap: signUp,
                    text: "Sign Up",
                  ),
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Already have an account?",
                        style: TextStyle(
                            color: Colors.grey[700],
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(width: 4),
                      GestureDetector(
                        onTap: widget.onTap,
                        child: const Text(
                          'Login',
                          style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 15),
                ],
              ),
            ),
          ),
        );
}

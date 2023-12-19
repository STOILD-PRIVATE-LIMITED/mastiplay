import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:scroll_date_picker/scroll_date_picker.dart';
import 'package:spinner_try/shivanshu/models/globals.dart';
import 'package:spinner_try/shivanshu/screens/family_room_page.dart';
import 'package:spinner_try/shivanshu/utils.dart';
import 'package:spinner_try/shivanshu/utils/image.dart';
import 'package:spinner_try/user_model.dart';

import '../models/firestore/firestore_document.dart';
import 'home_live.dart';

class BirthdayScreen extends StatefulWidget {
  final String name;
  final String gender;
  final String email;

  const BirthdayScreen({
    super.key,
    required this.name,
    required this.gender,
    required this.email,
  });

  @override
  State<BirthdayScreen> createState() => _BirthdayScreenState();
}

class _BirthdayScreenState extends State<BirthdayScreen> {
  String name = "";

  DateTime? _selectedDate;
  Country? country;

  File? img;

  void _submitForm() async {
    if (_selectedDate == null) {
      showMsg(context, "Choose a birthday please.");
      return;
    }
    if (country == null) {
      showMsg(context, "Choose a country please.");
      return;
    }
    if (img == null &&
        await askUser(
              context,
              'Do you really want to continue without a profile picture?',
              yes: true,
              no: true,
            ) !=
            'yes') {
      return;
    }
    String? imgUrl;
    if (context.mounted) {
      imgUrl = img == null
          ? null
          : await uploadImage(
              context,
              img!,
              'images',
              auth.currentUser!.email!,
            );
    }
    // send these to next screen
    widget.name;
    widget.gender;
    _selectedDate;
    country;
    imgUrl;

    widget.email;

    final db = FirebaseFirestore.instance;

    randomSet(
      FirestoreDocument(
        id: widget.email,
        path: 'users',
        data: UserModel(
          email: widget.email,
          name: widget.name,
          photo: imgUrl ?? '',
          gender: (widget.gender == 'Male') ? 0 : 1,
          dob: _selectedDate,
          country: country!.name.toString(),
        ).toJson(),
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
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) {
            return const HomeLive();
          },
        ),
      );
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    log(widget.gender);
    return Scaffold(
      appBar: AppBar(
        leading: ElevatedBackButton(
          onTap: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Complete Information',
          style: TextStyle(fontSize: 15.sp),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: height / 10),
              Container(
                width: 150,
                height: 150,
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: InkWell(
                  onTap: () async {
                    final String? source = await askUser(
                        context, 'Where to take your photo from?',
                        custom: {
                          'gallery': const Icon(Icons.photo_rounded),
                          'camera': const Icon(Icons.photo_camera_rounded),
                        });
                    if (source == null) return;
                    ImagePicker()
                        .pickImage(
                      source: source == 'camera'
                          ? ImageSource.camera
                          : ImageSource.gallery,
                      preferredCameraDevice: CameraDevice.front,
                    )
                        .then((value) {
                      if (value == null) return;
                      setState(() => img = File(value.path));
                    });
                  },
                  child: Hero(
                    tag: widget.gender,
                    child: img != null
                        ? Image.file(img!, fit: BoxFit.cover)
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
              SizedBox(height: 50.sp),
              ElevatedButton.icon(
                icon: const Icon(Icons.location_on_rounded),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.black26,
                  backgroundColor: Colors.black12.withOpacity(0.05),
                  elevation: 0,
                  shadowColor: Colors.white,
                  minimumSize: Size(width * 0.9, 60),
                  padding: EdgeInsets.only(
                    top: 15.sp,
                    left: 15.sp,
                    bottom: 15.sp,
                  ),
                  alignment: Alignment.centerLeft,
                ),
                onPressed: () {
                  showCountryPicker(
                      context: context,
                      countryListTheme: CountryListThemeData(
                        flagSize: 25,
                        backgroundColor: Colors.white,
                        textStyle: const TextStyle(
                            fontSize: 16, color: Colors.blueGrey),
                        bottomSheetHeight: 500,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(20.0),
                          topRight: Radius.circular(20.0),
                        ),
                        inputDecoration: InputDecoration(
                          labelText: 'Search',
                          hintText: 'Start typing to search',
                          prefixIcon: const Icon(Icons.search),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: const Color(0xFF8C98A8).withOpacity(0.2),
                            ),
                            borderRadius: BorderRadius.circular(50),
                          ),
                        ),
                      ),
                      onSelect: (Country country) => setState(() {
                            this.country = country;
                          }));
                },
                label: country != null
                    ? Text(
                        "${country!.flagEmoji} ${country!.name}",
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      )
                    : const Text(
                        'Country / Region',
                        style: TextStyle(fontSize: 16),
                      ),
              ),
              SizedBox(height: 20.sp),
              ElevatedButton.icon(
                icon: const Icon(Icons.cake_rounded),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.black26,
                  backgroundColor: Colors.black12.withOpacity(0.05),
                  elevation: 0,
                  shadowColor: Colors.white,
                  minimumSize: Size(width * 0.9, 60),
                  padding: EdgeInsets.only(
                    // right: width / 3,
                    top: 15.sp,
                    left: 15.sp,
                    bottom: 15.sp,
                  ),
                  alignment: Alignment.centerLeft,
                ),
                onPressed: () {
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
                          // title: const Text('When were you born?'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text('Confirm'),
                            ),
                          ],
                        ),
                        body: SizedBox(
                          height: height / 2,
                          child: ScrollDatePicker(
                            selectedDate: _selectedDate ?? DateTime.now(),
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
                label: _selectedDate != null
                    ? Text(
                        ddmmyyyy(_selectedDate!),
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      )
                    : const Text(
                        'Birthday',
                        style: TextStyle(fontSize: 16),
                      ),
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
                        child: ElevatedButton(
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
                          child: const Text(
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
                          'Register now',
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
    );
  }
}

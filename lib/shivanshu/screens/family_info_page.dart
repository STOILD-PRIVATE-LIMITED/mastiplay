import 'package:flutter/material.dart';

import '../utils.dart';

class FamilyInfo extends StatelessWidget {
  const FamilyInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Family Info', textScaleFactor: 0.9),
        centerTitle: true,
        leading: const BackButton(),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20.sp),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(child: Image.asset('assets/dummy_person.png')),
              SizedBox(height: 20.sp),
              Text(
                'Family Name',
                style: TextStyle(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextField(
                maxLength: 20,
                decoration: InputDecoration(
                  hintText: 'Enter Family Name',
                  hintStyle: const TextStyle(color: Colors.black12),
                  isDense: true,
                  filled: true,
                  fillColor: Colors.black26.withOpacity(0.05),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(3),
                    borderSide: BorderSide.none,
                  ),
                ),
                style: const TextStyle(
                  decorationColor: Colors.black12,
                  color: Colors.black,
                ),
              ),
              Text(
                'Family Tag',
                style: TextStyle(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextField(
                maxLength: 8,
                decoration: InputDecoration(
                  hintText: 'Enter Family Name',
                  hintStyle: const TextStyle(color: Colors.black12),
                  isDense: true,
                  filled: true,
                  fillColor: Colors.black26.withOpacity(0.05),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(3),
                    borderSide: BorderSide.none,
                  ),
                ),
                style: const TextStyle(
                  decorationColor: Colors.black12,
                  color: Colors.black,
                ),
              ),
              Text(
                'Family Announcement',
                style: TextStyle(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextField(
                maxLines: null,
                decoration: InputDecoration(
                  hintText: 'Enter Family Name',
                  hintStyle: const TextStyle(color: Colors.black12),
                  isDense: true,
                  filled: true,
                  fillColor: Colors.black26.withOpacity(0.05),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(3),
                    borderSide: BorderSide.none,
                  ),
                ),
                style: const TextStyle(
                  decorationColor: Colors.black12,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: SizedBox(
        width: width - 40.sp,
        child: FloatingActionButton.extended(
          onPressed: () {
            showMsg(
                context, 'Your family information was updated successfully');
            Navigator.of(context).pop();
          },
          backgroundColor: const Color(0xff01d8d1),
          foregroundColor: Colors.white,
          isExtended: true,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.sp),
          ),
          label: const Text('Save'),
        ),
      ),
      // ElevatedButton(
      //   onPressed: () {
      //     showMsg(context, 'Saved');
      //   },

      //   child: const Text('Save'),
      // ),
    );
  }
}

class BackButton extends StatelessWidget {
  const BackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: IconButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        style: IconButton.styleFrom(
            elevation: 5,
            shadowColor: Colors.black,
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            )),
        icon: const Icon(Icons.keyboard_arrow_left_rounded),
      ),
    );
  }
}

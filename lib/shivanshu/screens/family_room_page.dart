import 'package:flutter/material.dart';
import 'package:spinner_try/shivanshu/utils.dart';

class FamilyRoomPage extends StatelessWidget {
  const FamilyRoomPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Family Name', textScaleFactor: 0.9),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 200,
            childAspectRatio: 1,
            mainAxisSpacing: 3,
            crossAxisSpacing: 4,
          ),
          itemBuilder: (context, index) => Stack(
            children: [
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  clipBehavior: Clip.hardEdge,
                  child: Image.asset(
                    'assets/bg_img.webp',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                left: 10,
                top: 10,
                child: MyRow(
                  children: [
                    Icon(
                      Icons.chat,
                      size: 10.sp,
                      color: Colors.white,
                    ),
                    Text(
                      'Chat',
                      style: TextStyle(fontSize: 10.sp, color: Colors.white),
                    ),
                  ],
                ),
              ),
              Positioned(
                left: 10,
                right: 10,
                bottom: 10,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Status',
                      style: TextStyle(fontSize: 12.sp, color: Colors.white),
                    ),
                    MyRow(
                      children: [
                        Image.asset(
                          'assets/india.png',
                          width: 16.sp,
                          height: 16.sp,
                        ),
                        Text(
                          '4473',
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: SizedBox(
        width: width / 2,
        child: FloatingActionButton.extended(
          onPressed: () {
            showMsg(context, 'Your Tasks');
          },
          backgroundColor: const Color(0xff0085fe),
          foregroundColor: Colors.white,
          isExtended: true,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.sp),
          ),
          label: const Text('Tasks'),
        ),
      ),
    );
  }
}

class ElevatedBackButton extends StatelessWidget {
  final void Function()? onTap;
  const ElevatedBackButton({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: IconButton(
        onPressed: () {
          if (onTap != null) {
            onTap!();
          } else {
            Navigator.of(context).pop();
          }
        },
        style: IconButton.styleFrom(
            elevation: 5,
            shadowColor: Colors.black,
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            )),
        icon: const Icon(
          Icons.keyboard_arrow_left_rounded,
          color: Colors.black,
        ),
      ),
    );
  }
}

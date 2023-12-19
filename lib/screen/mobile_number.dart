import 'package:flutter/material.dart';
import 'package:spinner_try/shivanshu/utils.dart';

class MobileNumber extends StatefulWidget {
  const MobileNumber({super.key});

  @override
  State<MobileNumber> createState() => _MobileNumberState();
}

class _MobileNumberState extends State<MobileNumber> {
  TextEditingController phoneController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: Container(
          margin: const EdgeInsets.only(left: 10),
          child: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
          ),
        ),
        title: const Text(
          "Mobile Number",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
            left: 20.sp,
            right: 20.sp,
            top: 100.sp,
          ),
          child: Column(
            children: [
              Text(
                'Welcome to MastiPlay',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 29.41.sp,
                  fontWeight: FontWeight.w400,
                  height: 0.04,
                ),
              ),
              SizedBox(
                height: 40.sp,
              ),
              Container(
                width: 324.01.sp,
                height: 65.sp,
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(horizontal: 10.sp),
                decoration: ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(width: 1, color: Color(0xFF777777)),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  shadows: const [
                    BoxShadow(
                      color: Color(0x3FD3D1D8),
                      blurRadius: 30,
                      offset: Offset(15, 15),
                      spreadRadius: 0,
                    )
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(
                      'assets/phone1.png',
                      height: 38.sp,
                      width: 38.sp,
                    ),
                    Expanded(
                      child: TextField(
                        controller: phoneController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Phone Number',
                          hintStyle: TextStyle(
                            color: const Color(0xFF777777),
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w400,
                            height: 0.04,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20.sp,
              ),
              Container(
                width: 324.01.sp,
                height: 65.sp,
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(horizontal: 10.sp),
                decoration: ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(width: 1, color: Color(0xFF777777)),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  shadows: const [
                    BoxShadow(
                      color: Color(0x3FD3D1D8),
                      blurRadius: 30,
                      offset: Offset(15, 15),
                      spreadRadius: 0,
                    )
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(
                      'assets/Group.png',
                      height: 38.sp,
                      width: 38.sp,
                    ),
                    SizedBox(
                      width: 5.sp,
                    ),
                    Expanded(
                      child: TextField(
                        controller: otpController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Verification Code',
                          hintStyle: TextStyle(
                            color: const Color(0xFF777777),
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w400,
                            height: 0.04,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: 86.sp,
                      height: 37.sp,
                      padding: EdgeInsets.symmetric(
                          horizontal: 6.sp, vertical: 10.sp),
                      clipBehavior: Clip.antiAlias,
                      decoration: ShapeDecoration(
                        color: const Color(0xFFC2C6CE),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Get Code',
                            style: TextStyle(
                              color: const Color(0xFF828488),
                              fontSize: 17.sp,
                              fontWeight: FontWeight.w400,
                              height: 0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20.sp,
              ),
              Container(
                width: 269,
                height: 65.08,
                decoration: ShapeDecoration(
                  color: const Color(0xFFE05DD3),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(28.50),
                  ),
                  shadows: const [
                    BoxShadow(
                      color: Color(0x287A80BE),
                      blurRadius: 40,
                      offset: Offset(0, 10),
                      spreadRadius: 0,
                    )
                  ],
                ),
                alignment: Alignment.center,
                child: Text(
                  'Coming Soon',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28.sp,
                    fontWeight: FontWeight.w400,
                    letterSpacing: 2.24,
                  ),
                ),
              ),
              SizedBox(
                height: 20.sp,
              ),
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: 'Any problems when login? ',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 12.55.sp,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
                        height: 0.14,
                      ),
                    ),
                    TextSpan(
                      text: 'Try another option',
                      style: TextStyle(
                        color: const Color(0xFFE05DD3),
                        fontSize: 12.55.sp,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
                        height: 0.14,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 40.sp,
              ),
              Stack(
                children: [
                  Image.asset('assets/Game_con.png'),
                  Positioned(
                      top: 100.sp,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(width: 90.sp, child: const Divider()),
                              Text(
                                'Other login option',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14.sp,
                                  fontFamily: 'Sofia Pro',
                                  fontWeight: FontWeight.w400,
                                  height: 0,
                                ),
                              ),
                              SizedBox(width: 90.sp, child: const Divider()),
                            ],
                          ),
                          SizedBox(
                            height: 15.sp,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Image.asset(
                                "assets/row1.png",
                                height: 40.sp,
                              ),
                              Image.asset(
                                "assets/row2.png",
                                height: 40.sp,
                              ),
                              Image.asset(
                                "assets/row3.png",
                                height: 40.sp,
                              ),
                            ],
                          )
                        ],
                      ))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

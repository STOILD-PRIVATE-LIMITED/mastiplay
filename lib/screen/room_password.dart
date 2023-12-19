import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';

class RoomPassword extends StatefulWidget {
  const RoomPassword({super.key});

  @override
  State<RoomPassword> createState() => _RoomPasswordState();
}

class _RoomPasswordState extends State<RoomPassword> {
  OtpFieldController otpFieldController = OtpFieldController();
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            height: height / 1.4,
            width: width,
            padding: EdgeInsets.symmetric(
                horizontal: width / 30, vertical: height / 40),
            decoration: const BoxDecoration(
              color: Color(0xFFCEC3C3),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Room Password",
                  style: TextStyle(
                      fontSize: height / 40, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: height / 5,
                ),
                Text(
                  "Set the Room Password",
                  style: TextStyle(
                    fontSize: height / 40,
                  ),
                ),
                SizedBox(
                  height: height / 40,
                ),
                OTPTextField(
                  length: 6,
                  width: width,
                  fieldWidth: width / 10,
                  style: TextStyle(fontSize: height / 40),
                  textFieldAlignment: MainAxisAlignment.spaceAround,
                  fieldStyle: FieldStyle.box,
                  otpFieldStyle: OtpFieldStyle(
                    backgroundColor: Colors.white,
                    borderColor: Colors.black,
                    focusBorderColor: Colors.black,
                  ),
                  onCompleted: (pin) {
                    if (kDebugMode) {
                      print(pin);
                    }
                  },
                ),
                SizedBox(
                  height: height / 5,
                ),
                Container(
                  width: width / 2,
                  height: height / 15,
                  decoration: BoxDecoration(
                    color: Colors.grey[800],
                    borderRadius: BorderRadius.circular(30),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    "Lock Room",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: height / 40,
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

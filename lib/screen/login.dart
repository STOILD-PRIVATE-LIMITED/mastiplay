import 'package:flutter/material.dart';
import 'package:spinner_try/auth/authfunction.dart';
import 'package:spinner_try/loginorregister.dart';
import 'package:spinner_try/screen/mobile_number.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool isChecked = true;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: DecoratedBox(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/login_page.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: height / 2,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  width: width / 4,
                  child: const Divider(
                    color: Colors.white,
                    thickness: 1,
                  ),
                ),
                Text(
                  "Login With",
                  style: TextStyle(color: Colors.white, fontSize: height / 40),
                ),
                SizedBox(
                  width: width / 4,
                  child: const Divider(
                    color: Colors.white,
                    thickness: 1,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: height / 20,
            ),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    !isChecked
                        ? Container(
                            height: height / 12,
                            width: width / 2.2,
                            padding:
                                EdgeInsets.symmetric(horizontal: width / 30),
                            decoration: BoxDecoration(
                              color: Colors.white38,
                              borderRadius: BorderRadius.circular(40),
                            ),
                            child: Row(
                              children: [
                                Image.asset(
                                  "assets/facebook.png",
                                  height: height / 20,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "FACEBOOK",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: height / 55,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          )
                        : GestureDetector(
                            onTap: () {
                              // signInWithFacebook(context);
                              signInWithGoogle(context);
                            },
                            child: Container(
                              height: height / 12,
                              width: width / 2.2,
                              padding:
                                  EdgeInsets.symmetric(horizontal: width / 30),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(40),
                              ),
                              child: Row(
                                children: [
                                  Image.asset(
                                    "assets/facebook.png",
                                    height: height / 20,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    "FACEBOOK",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: height / 55,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          ),
                    !isChecked
                        ? Container(
                            height: height / 12,
                            width: width / 2.2,
                            padding:
                                EdgeInsets.symmetric(horizontal: width / 30),
                            decoration: BoxDecoration(
                              color: Colors.white38,
                              borderRadius: BorderRadius.circular(40),
                            ),
                            child: Row(
                              children: [
                                Image.asset(
                                  "assets/user.png",
                                  height: height / 20,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "PASSWORD",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: height / 55,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          )
                        : GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) {
                                  return const LoginOrRegister();
                                },
                              ));
                            },
                            child: Container(
                              height: height / 12,
                              width: width / 2.2,
                              padding:
                                  EdgeInsets.symmetric(horizontal: width / 30),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(40),
                              ),
                              child: Row(
                                children: [
                                  Image.asset(
                                    "assets/user.png",
                                    height: height / 20,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    "PASSWORD",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: height / 55,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          ),
                  ],
                ),
                SizedBox(
                  height: height / 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    !isChecked
                        ? Container(
                            height: height / 12,
                            width: width / 2.2,
                            padding:
                                EdgeInsets.symmetric(horizontal: width / 30),
                            decoration: BoxDecoration(
                              color: Colors.white38,
                              borderRadius: BorderRadius.circular(40),
                            ),
                            child: Row(
                              children: [
                                Image.asset(
                                  "assets/phone.png",
                                  height: height / 20,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "PHONE",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: height / 55,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          )
                        : GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) {
                                  return const MobileNumber();
                                },
                              ));
                            },
                            child: Container(
                              height: height / 12,
                              width: width / 2.2,
                              padding:
                                  EdgeInsets.symmetric(horizontal: width / 30),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(40),
                              ),
                              child: Row(
                                children: [
                                  Image.asset(
                                    "assets/phone.png",
                                    height: height / 20,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    "PHONE",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: height / 55,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          ),
                    !isChecked
                        ? Container(
                            height: height / 12,
                            width: width / 2.2,
                            padding:
                                EdgeInsets.symmetric(horizontal: width / 30),
                            decoration: BoxDecoration(
                              color: Colors.white38,
                              borderRadius: BorderRadius.circular(40),
                            ),
                            child: Row(
                              children: [
                                Image.asset(
                                  "assets/google.png",
                                  height: height / 20,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "GOOGLE",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: height / 55,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          )
                        : GestureDetector(
                            onTap: () {
                              signInWithGoogle(context);
                            },
                            child: Container(
                              height: height / 12,
                              width: width / 2.2,
                              padding:
                                  EdgeInsets.symmetric(horizontal: width / 30),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(40),
                              ),
                              child: Row(
                                children: [
                                  Image.asset(
                                    "assets/google.png",
                                    height: height / 20,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    "GOOGLE",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: height / 55,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: height / 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Checkbox(
                    value: isChecked,
                    onChanged: (value) {
                      setState(() {
                        isChecked = value!;
                      });
                    }),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Accept ',
                        style: TextStyle(
                            color: Colors.white, fontSize: height / 45),
                      ),
                      TextSpan(
                        text: 'Terms Of Use',
                        style: TextStyle(
                            color: const Color(0xFFE05DD3),
                            fontSize: height / 45),
                      ),
                      TextSpan(
                        text: ' & ',
                        style: TextStyle(
                            color: Colors.white, fontSize: height / 45),
                      ),
                      TextSpan(
                        text: 'Privacy Policy',
                        style: TextStyle(
                            color: const Color(0xFFE05DD3),
                            fontSize: height / 45),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

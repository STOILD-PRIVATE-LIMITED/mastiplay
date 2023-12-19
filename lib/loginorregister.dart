import 'package:flutter/material.dart';

import 'Register.dart';
import 'login.dart';

class LoginOrRegister extends StatefulWidget {
  const LoginOrRegister({super.key});

  @override
  State<LoginOrRegister> createState() => LoginOrRegisterState();
}

class LoginOrRegisterState extends State<LoginOrRegister> {
  //  initially show login page
  bool showlogin = true;

  // toogle between login and register
  void tooglePages() {
    setState(() {
      showlogin = !showlogin;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showlogin) {
      return Login(
        onTap: tooglePages,
      );
    } else {
      return Register(
        onTap: tooglePages,
      );
    }
  }
}

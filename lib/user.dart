import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:spinner_try/shivanshu/screens/home_live.dart';

class UserHome extends StatefulWidget {
  var name;
  var email;
  var photo;

  UserHome({
    super.key,
    required this.name,
    required this.email,
    required this.photo,
  });

  @override
  State<UserHome> createState() => _UserHomeState();
}

class _UserHomeState extends State<UserHome> {
  @override
  Widget build(BuildContext context) {
    return const HomeLive();
  }
}

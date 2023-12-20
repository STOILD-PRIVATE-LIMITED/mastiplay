import 'package:flutter/material.dart';
import 'package:spinner_try/screen/moments.dart';
import 'package:spinner_try/shivanshu/screens/home_page.dart';
import 'package:spinner_try/shivanshu/screens/messages_screen.dart';
import 'package:spinner_try/shivanshu/widgets/bottom_nav_bar.dart';

import '../../screen/profile_edit.dart';

class HomeLive extends StatefulWidget {
  final String email;
  const HomeLive({super.key, required this.email});

  @override
  State<HomeLive> createState() => _HomeLiveState();
}

class _HomeLiveState extends State<HomeLive> {
  final _pageViewController = PageController();
  int currentPage = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageViewController,
        onPageChanged: (i) {
          setState(() {
            currentPage = i;
          });
        },
        children: [
          HomePage(),
          const Moments(),
          const MessageScreen(),
          const ProfileEdit(),
        ],
      ),
      bottomNavigationBar: BottomNavBar(
        email: widget.email,
        key: UniqueKey(),
        onTap: (i) {
          setState(() {
            _pageViewController.animateToPage(
              i,
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeInOut,
            );
          });
        },
        defaultSelectedIndex: currentPage,
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:spinner_try/shivanshu/screens/add_button_page.dart';
import 'package:spinner_try/shivanshu/utils.dart';

class BottomNavBar extends StatefulWidget {
  final String email;
  final int defaultSelectedIndex;
  final void Function(int index) onTap;
  const BottomNavBar({
    super.key,
    this.defaultSelectedIndex = 0,
    required this.onTap,
    required this.email
  });

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  late int selectedIndex;
  @override
  void initState() {
    super.initState();
    selectedIndex = widget.defaultSelectedIndex;
  }

  @override
  Widget build(BuildContext context) {
    double size = 24;
    final bump = Image.asset(
      'assets/bump.webp',
      fit: BoxFit.fitHeight,
      height: 10,
      width: 20,
    );
    final List<Widget> items = [
      Image.asset(
        'assets/home_grey.png',
        width: size,
        height: size,
      ),
      Image.asset(
        'assets/heart_grey.png',
        width: size,
        height: size,
      ),
      Image.asset(
        'assets/chat_grey.png',
        width: size,
        height: size,
      ),
      Image.asset(
        'assets/profile_nav_bar.png',
        width: size,
        height: size,
      ),
    ];
    final List<Widget> selectedItems = [
      Image.asset(
        'assets/home.png',
        width: size,
        height: size,
      ),
      Image.asset(
        'assets/heart.png',
        width: size,
        height: size,
      ),
      Image.asset(
        'assets/chat.png',
        width: size,
        height: size,
      ),
      Image.asset(
        'assets/profile_nav_bar.png',
        width: size,
        height: size,
      ),
    ];
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Image.asset(
          'assets/nav_bar_bg.png',
          width: MediaQuery.of(context).size.width,
          // height: MediaQuery.of(context).size.height / 5,
          fit: BoxFit.fitWidth,
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              for (int i = 0; i < items.length; ++i)
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    InkWell(
                      onTap: () {
                        setState(() {
                          selectedIndex = i;
                        });
                        widget.onTap(i);
                      },
                      child: selectedIndex == i ? selectedItems[i] : items[i],
                    ),
                    if (selectedIndex == i) const SizedBox(height: 14),
                    if (selectedIndex == i) bump else SizedBox(height: size),
                  ],
                ),
            ]..insert(
                2,
                const SizedBox(
                  width: 30,
                ),
              ),
          ),
        ),
        Positioned(
          bottom: MediaQuery.of(context).size.height / 20,
          child: IconButton(
            onPressed: () {
              navigatorPush(context, AddButtonPage(
                email: widget.email,
              ));
            },
            style: IconButton.styleFrom(
              elevation: 10,
              shadowColor: Colors.black,
              backgroundColor: const Color.fromARGB(255, 224, 93, 211),
            ),
            icon: const Icon(
              Icons.add_rounded,
              color: Colors.white,
              size: 15,
            ),
          ),
        ),
      ],
    );
  }
}

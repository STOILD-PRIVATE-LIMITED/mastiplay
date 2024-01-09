import 'package:flutter/material.dart';
import 'package:spinner_try/shivanshu/games/highlight_wheel.dart';
import 'package:spinner_try/shivanshu/models/globals.dart';
import 'package:spinner_try/shivanshu/utils.dart';
import 'package:spinner_try/shivanshu/utils/loading_widget.dart';

class SpinnerPage extends StatelessWidget {
  const SpinnerPage({super.key});

  @override
  Widget build(BuildContext context) {
    final animals = [
      "assets/games/animals/rabit.png",
      "assets/games/animals/cat.png",
      "assets/games/animals/dog.png",
      "assets/games/animals/monkey.png",
      "assets/games/animals/dolphin.png",
      "assets/games/animals/panda.png",
      "assets/games/animals/eagle.png",
      "assets/games/animals/lion.png",
    ];
    return Card(
      elevation: 0,
      color: Colors.transparent,
      child: Container(
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          image: const DecorationImage(
            image: AssetImage('assets/bg_img.webp'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(width: 5),
                    InkWell(
                      child: Image.asset(
                        "assets/games/menu_buttons/plus.png",
                        width: 24,
                        height: 24,
                      ),
                      onTap: () {},
                    ),
                    const SizedBox(width: 5),
                    InkWell(
                      child: Image.asset(
                        "assets/games/menu_buttons/star.png",
                        width: 24,
                        height: 24,
                      ),
                      onTap: () {},
                    ),
                    const SizedBox(width: 5),
                    // InkWell(
                    //   child: Image.asset(
                    //     "assets/games/menu_buttons/search.png",
                    //     width: 24,
                    //     height: 24,
                    //   ),
                    //   onTap: () {},
                    // ),
                    // SizedBox(width: 5),
                    InkWell(
                      child: Image.asset(
                        "assets/games/menu_buttons/sound.png",
                        width: 24,
                        height: 24,
                      ),
                      onTap: () {},
                    ),
                    const SizedBox(width: 5),
                    InkWell(
                      child: Image.asset(
                        "assets/games/menu_buttons/question.png",
                        width: 24,
                        height: 24,
                      ),
                      onTap: () {},
                    ),
                  ],
                ),
                const FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    'Happy Zoo',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    InkWell(
                      child: Image.asset(
                        "assets/games/menu_buttons/menu.png",
                        width: 24,
                        height: 24,
                      ),
                      onTap: () {},
                    ),
                    const SizedBox(width: 5),
                    InkWell(
                      child: Image.asset(
                        "assets/games/menu_buttons/down.png",
                        width: 24,
                        height: 24,
                      ),
                      onTap: () {},
                    ),
                    const SizedBox(width: 5),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Image.asset(
                        "assets/games/menu_buttons/cross.png",
                        width: 24,
                        height: 24,
                      ),
                    ),
                    const SizedBox(width: 5),
                  ],
                ),
              ],
            ),
            Stack(
              alignment: Alignment.center,
              children: [
                HighlightWheel(
                  childWidth: 100,
                  radius: width / 2 - 5,
                  childHeight: 100,
                  minRotations: 0.5,
                  duration: 10,
                  highlightedItemBuilder: (index) {
                    return Stack(
                      alignment: Alignment.center,
                      children: [
                        // const CircleAvatar(radius: 40),
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.white.withOpacity(0.8),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset: const Offset(
                                    0, 3), // changes position of shadow
                              ),
                            ],
                          ),
                          margin: const EdgeInsets.all(15),
                        ),
                        Image.asset(animals[index]),
                      ],
                    );
                  },
                  onComplete: (index) {
                    showMsg(context, 'You got ${animals[index]}');
                  },
                  items: animals
                      .map(
                        (e) => Stack(
                          alignment: Alignment.center,
                          children: [
                            // const CircleAvatar(radius: 40),
                            Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.2),
                                    spreadRadius: 5,
                                    blurRadius: 7,
                                    offset: const Offset(
                                        0, 3), // changes position of shadow
                                  ),
                                ],
                              ),
                              margin: const EdgeInsets.all(15),
                            ),
                            Image.asset(e),
                          ],
                        ),
                      )
                      .toList(),
                ),
                Positioned(
                  left: 5,
                  bottom: 5,
                  child: InkWell(
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white70,
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          colorFilter: ColorFilter.mode(
                            Colors.white.withOpacity(1),
                            BlendMode.dstATop,
                          ),
                          image: const AssetImage(
                            "assets/games/menu_buttons/people.png",
                          ),
                        ),
                      ),
                      width: 30,
                      height: 30,
                    ),
                    onTap: () {
                      showDialog(
                        barrierDismissible: false,
                        context: context,
                        barrierColor: Colors.black54,
                        builder: (context) {
                          return const Padding(
                            padding: EdgeInsets.symmetric(vertical: 150.0),
                            child: SpinnerPage(),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
            Stack(
              alignment: Alignment.center,
              children: [
                Image.asset(
                  'assets/games/menu_buttons/bottom_bg.png',
                  fit: BoxFit.fitWidth,
                ),
                Row(
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          padding: const EdgeInsets.only(
                            left: 12,
                            top: 4,
                            bottom: 4,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.white.withOpacity(0.2),
                                spreadRadius: 2,
                                blurRadius: 7,
                                offset: const Offset(0, 0),
                              ),
                            ],
                            color: Colors.white24,
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Image.asset(
                                'assets/diamond.png',
                                width: 20,
                                height: 20,
                              ),
                              Text(
                                currentUser.diamonds.toString(),
                                style: const TextStyle(
                                  color: Colors.white,
                                  // fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(width: 10),
                              Image.asset(
                                'assets/chevron down.png',
                                width: 20,
                                height: 20,
                              ),
                            ],
                          ),
                        ),
                        LoadingWidget(
                          onPressed: () async {
                            await Future.delayed(const Duration(seconds: 2));
                          },
                          loadingWidget: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: const Color(0xffe05dd3),
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 30,
                              vertical: 3,
                            ),
                            child: const CircularProgressIndicatorRainbow(
                              width: 10,
                              height: 10,
                            ),
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: const Color(0xffe05dd3),
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: const Text(
                              'REPEAT',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

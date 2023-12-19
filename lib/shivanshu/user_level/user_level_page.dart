import 'package:flutter/material.dart';
import 'package:spinner_try/shivanshu/screens/family_room_page.dart';
import 'package:spinner_try/shivanshu/utils.dart';

class UserLevelPage extends StatefulWidget {
  const UserLevelPage({super.key});

  @override
  State<UserLevelPage> createState() => _UserLevelPageState();
}

class _UserLevelPageState extends State<UserLevelPage>
    with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _pageController = PageController();
  }

  late final _tabController;
  late final PageController _pageController;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        leading: const ElevatedBackButton(),
        title: TabBar(
          onTap: (index) {
            _pageController.animateToPage(index,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeIn);
          },
          controller: _tabController,
          tabs: const [
            Text('Rich Level'),
            Text('Charm Level'),
          ],
        ),
      ),
      body: PageView(
        controller: _pageController,
        children: const [
          RichLevel(),
          CharmLevel(),
        ],
        onPageChanged: (value) {
          _tabController.animateTo(value);
        },
      ),
    );
  }
}

class CharmLevel extends StatelessWidget {
  const CharmLevel({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final List<Color> pinkToPurpleColors = generateGradientColors(10, [
      Colors.cyan,
      Colors.blue,
      Colors.amber,
    ]);
    return SizedBox(
      height: height,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: MyColumn(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Card(
                color: Colors.transparent,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                      textColor: Colors.white,
                      leading: const CircleAvatar(
                        backgroundImage: AssetImage('assets/dummy_person.png'),
                      ),
                      title: const Text(
                        'SR🦅',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      trailing: Stack(
                        alignment: Alignment.center,
                        children: [
                          shaderWidget(
                            context,
                            child: ElevatedButton(
                              onPressed: () {
                                // use the below inkwell for this button, DON'T use this function
                              },
                              child: const Text(
                                'Recharge',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            colors: [Colors.red, Colors.orange],
                          ),
                          InkWell(
                            onTap: () {
                              showMsg(context, 'In Development');
                            },
                            child: const Text(
                              'Recharge',
                              style: TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ],
                      ),
                      subtitle: const Row(
                        children: [
                          Card(
                            color: Color.fromARGB(255, 219, 62, 148),
                            elevation: 0,
                            child: Padding(
                              padding: EdgeInsets.all(2.0),
                              child: MyRow(
                                children: [
                                  Icon(
                                    Icons.dark_mode,
                                    size: 10,
                                    color: Colors.white,
                                  ),
                                  Text(
                                    "43",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Text(
                      'Receive',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    MyRow(
                      children: [
                        Image.asset(
                          'assets/diamond.png',
                          width: 24.sp,
                          height: 24.sp,
                        ),
                        Text(
                          "3168700",
                          style: TextStyle(
                            fontSize: 24.sp,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(width: 10.sp),
                        const Expanded(
                          child: Wrap(
                            children: [
                              Text(
                                "to level up:  ",
                                style: TextStyle(),
                              ),
                              Text(
                                '569497800/57266500',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    shaderWidget(
                      context,
                      child: LinearProgressIndicator(
                        value: 0.5,
                        valueColor: const AlwaysStoppedAnimation<Color>(
                          Colors.transparent,
                        ),
                        backgroundColor: Colors.grey[300],
                        minHeight: 20,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      colors: [Colors.red, Colors.orange],
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                  color: Colors.white,
                ),
                child: SingleChildScrollView(
                  child: MyColumn(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Level Label',
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 20.sp),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10),
                          ),
                          border: Border.all(
                            color: Colors.grey[200]!,
                          ),
                          // color: Colors.grey[200],
                        ),
                        child: MyColumn(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10),
                                ),
                                color: Colors.grey[200],
                              ),
                              width: width,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: MyRow(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Level',
                                      style: TextStyle(
                                          fontSize: 14.sp,
                                          color: Colors.grey[600]),
                                    ),
                                    Text(
                                      'Label',
                                      style: TextStyle(
                                          fontSize: 14.sp,
                                          color: Colors.grey[600]),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            // const SizedBox(height: 10),
                            for (int i = -5; i <= 40; i += 5)
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SizedBox(
                                  width: width,
                                  child: MyRow(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        i < 0
                                            ? 'Lvl 0'
                                            : 'Lvl ${i + 1} - ${i + 5}',
                                        style: TextStyle(
                                            fontSize: 14.sp,
                                            color: Colors.grey[600]),
                                      ),
                                      Card(
                                        color: pinkToPurpleColors[(i + 5) ~/ 5],
                                        child: Padding(
                                          padding: const EdgeInsets.all(2.0),
                                          child: MyRow(
                                            children: [
                                              const Icon(
                                                Icons.dark_mode_rounded,
                                                color: Colors.white,
                                                size: 15,
                                              ),
                                              Text(
                                                '${i + 5}',
                                                style: TextStyle(
                                                  fontSize: 12.sp,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class RichLevel extends StatelessWidget {
  const RichLevel({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final List<Color> pinkToPurpleColors =
        generateGradientColors(10, [Colors.purple, Colors.pink]);
    return SizedBox(
      height: height,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: MyColumn(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Card(
                color: Colors.transparent,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const ListTile(
                      textColor: Colors.white,
                      leading: CircleAvatar(
                        backgroundImage: AssetImage('assets/dummy_person.png'),
                      ),
                      title: Text(
                        'SR🦅',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      subtitle: Row(
                        children: [
                          Card(
                            color: Color.fromARGB(255, 219, 62, 148),
                            elevation: 0,
                            child: Padding(
                              padding: EdgeInsets.all(2.0),
                              child: MyRow(
                                children: [
                                  Icon(
                                    Icons.dark_mode,
                                    size: 10,
                                    color: Colors.white,
                                  ),
                                  Text(
                                    "43",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Text(
                      'Receive',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    MyRow(
                      children: [
                        Image.asset(
                          'assets/diamond.png',
                          width: 24.sp,
                          height: 24.sp,
                        ),
                        Text(
                          "3168700",
                          style: TextStyle(
                            fontSize: 24.sp,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(width: 10.sp),
                        const Expanded(
                          child: Wrap(
                            children: [
                              Text(
                                "to level up:  ",
                                style: TextStyle(),
                              ),
                              Text(
                                '569497800/57266500',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    shaderWidget(
                      context,
                      child: LinearProgressIndicator(
                        value: 0.5,
                        valueColor: const AlwaysStoppedAnimation<Color>(
                          Colors.transparent,
                        ),
                        backgroundColor: Colors.grey[300],
                        minHeight: 20,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      colors: [Colors.pink, Colors.purple],
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                  color: Colors.white,
                ),
                child: SingleChildScrollView(
                  child: MyColumn(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Level Label',
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 20.sp),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10),
                          ),
                          border: Border.all(
                            color: Colors.grey[200]!,
                          ),
                          // color: Colors.grey[200],
                        ),
                        child: MyColumn(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10),
                                ),
                                color: Colors.grey[200],
                              ),
                              width: width,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: MyRow(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Level',
                                      style: TextStyle(
                                          fontSize: 14.sp,
                                          color: Colors.grey[600]),
                                    ),
                                    Text(
                                      'Label',
                                      style: TextStyle(
                                          fontSize: 14.sp,
                                          color: Colors.grey[600]),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            // const SizedBox(height: 10),
                            for (int i = -5; i <= 40; i += 5)
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SizedBox(
                                  width: width,
                                  child: MyRow(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        i < 0
                                            ? 'Lvl 0'
                                            : 'Lvl ${i + 1} - ${i + 5}',
                                        style: TextStyle(
                                            fontSize: 14.sp,
                                            color: Colors.grey[600]),
                                      ),
                                      Card(
                                        color: pinkToPurpleColors[(i + 5) ~/ 5],
                                        child: Padding(
                                          padding: const EdgeInsets.all(2.0),
                                          child: MyRow(
                                            children: [
                                              const Icon(
                                                Icons.dark_mode_rounded,
                                                color: Colors.white,
                                                size: 15,
                                              ),
                                              Text(
                                                '${i + 5}',
                                                style: TextStyle(
                                                  fontSize: 12.sp,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

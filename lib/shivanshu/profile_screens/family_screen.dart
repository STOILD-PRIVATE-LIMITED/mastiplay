import 'package:flutter/material.dart';
import 'package:spinner_try/shivanshu/profile_screens/family_page.dart';
import 'package:spinner_try/shivanshu/profile_screens/status_page.dart';
import 'package:spinner_try/shivanshu/screens/family_info_page.dart';
import 'package:spinner_try/shivanshu/screens/family_room_page.dart';
import 'package:spinner_try/shivanshu/utils.dart';

class FamilyScreen extends StatefulWidget {
  const FamilyScreen({super.key});

  @override
  State<FamilyScreen> createState() => _FamilyScreenState();
}

class _FamilyScreenState extends State<FamilyScreen>
    with TickerProviderStateMixin {
  late final TabController _tabController;
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _pageController = PageController();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(size.width, 150),
        child: AppBar(
          // automaticallyImplyLeading: false,
          leading: ElevatedBackButton(
            onTap: () {
              Navigator.of(context).pop();
            },
          ),
          actions: [
            PopupMenuButton<String>(
              onSelected: (value) {
                if (value == "Family Information") {
                  navigatorPush(context, const FamilyInfo());
                }
              },
              itemBuilder: (BuildContext context) {
                return [
                  const PopupMenuItem<String>(
                    value: 'Family Information',
                    child: Text('Family Information'),
                  ),
                ];
              },
            ),
            IconButton(
              icon: const Icon(Icons.help_rounded),
              onPressed: () {
                showMsg(context, 'Help');
              },
            ),
          ],
          foregroundColor: Colors.white,
          flexibleSpace: FlexibleSpaceBar(
            title: Padding(
              padding: const EdgeInsets.only(top: 50.0),
              child: MyRow(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    clipBehavior: Clip.hardEdge,
                    child: Image.network(
                      'https://t3.ftcdn.net/jpg/06/05/89/02/360_F_605890243_x4byKlOucKh8jQb6fi1x2gwtp9GOzzgB.jpg',
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 10),
                  MyColumn(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Farmer🌾',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      MyRow(
                        children: [
                          const Icon(
                            Icons.person,
                            color: Colors.white,
                            size: 10,
                          ),
                          const Text(
                            '5 / 100',
                            style: TextStyle(
                              fontSize: 10,
                            ),
                          ),
                          const SizedBox(width: 20),
                          Text(
                            'ID dm827940',
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.7),
                              fontSize: 10,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
            background: Stack(
              children: [
                Positioned.fill(
                  child: Image.network(
                    'https://t3.ftcdn.net/jpg/06/05/89/02/360_F_605890243_x4byKlOucKh8jQb6fi1x2gwtp9GOzzgB.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned.fill(
                  child: Container(
                    color: Colors.black45,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          TabBar(
            tabs: const [
              Tab(text: 'Family'),
              Tab(text: 'Room'),
              Tab(text: 'Status'),
            ],
            controller: _tabController,
            onTap: (index) {
              _pageController.animateToPage(
                index,
                duration: const Duration(milliseconds: 300),
                curve: Curves.decelerate,
              );
            },
          ),
          SizedBox(
            height: 555.sp,
            child: PageView(
              controller: _pageController,
              onPageChanged: (index) {
                _tabController.animateTo(index);
              },
              children: const [
                FamilyPage(),
                FamilyRoomPage(),
                StatusPage(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

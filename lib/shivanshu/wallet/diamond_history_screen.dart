import 'package:flutter/material.dart';
import 'package:spinner_try/shivanshu/wallet/income_screen.dart';
import 'package:spinner_try/shivanshu/wallet/outcome_screen.dart';
import 'package:spinner_try/shivanshu/wallet/recharge_screen.dart';

class DiamondHistoryScreen extends StatefulWidget {
  const DiamondHistoryScreen({super.key});

  @override
  State<DiamondHistoryScreen> createState() => _DiamondHistoryScreenState();
}

class _DiamondHistoryScreenState extends State<DiamondHistoryScreen>
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
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          style: IconButton.styleFrom(
            elevation: 5,
            shadowColor: Colors.black,
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
          icon: const Icon(Icons.keyboard_arrow_left_rounded),
        ),
        title: const Text('Details'),
        centerTitle: true,
        bottom: TabBar(
          controller: _tabController,
          onTap: (index) {
            _pageController.animateToPage(
              index,
              duration: const Duration(milliseconds: 400),
              curve: Curves.decelerate,
            );
          },
          tabs: const [
            Tab(text: "Recharge"),
            Tab(text: "Income"),
            Tab(text: "Outcome"),
          ],
        ),
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          _tabController.animateTo(index);
        },
        children: const [
          RechargeScreen(),
          IncomeScreen(),
          OutcomeScreen(),
        ],
      ),
    );
  }
}

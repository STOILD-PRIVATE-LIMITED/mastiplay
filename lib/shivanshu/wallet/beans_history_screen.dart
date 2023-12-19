import 'package:flutter/material.dart';
import 'package:spinner_try/shivanshu/wallet/bean_agent_transfer_screen.dart';
import 'package:spinner_try/shivanshu/wallet/bean_exchange_screen.dart';
import 'package:spinner_try/shivanshu/wallet/bean_income_screen.dart';
import 'package:spinner_try/shivanshu/wallet/bean_cash_out_screen.dart';

class BeanHistoryScreen extends StatefulWidget {
  const BeanHistoryScreen({super.key});

  @override
  State<BeanHistoryScreen> createState() => _BeanHistoryScreenState();
}

class _BeanHistoryScreenState extends State<BeanHistoryScreen>
    with TickerProviderStateMixin {
  late final TabController _tabController;
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
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
        title: const Text('History'),
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
            Tab(text: "Income"),
            Tab(text: "Cash Out"),
            Tab(text: "Agent Transfer"),
            Tab(text: "Exchange"),
          ],
        ),
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          _tabController.animateTo(index);
        },
        children: const [
          BeanIncomeScreen(),
          BeanCashoutScreen(),
          BeanAgentTransferScreen(),
          BeanExchangeScreen(),
        ],
      ),
    );
  }
}

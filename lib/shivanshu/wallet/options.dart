import 'package:flutter/material.dart';
import 'package:spinner_try/shivanshu/screens/main_wallet_page.dart';
import 'package:spinner_try/shivanshu/utils.dart';
import 'package:spinner_try/shivanshu/wallet/agency_screen.dart';
import 'package:spinner_try/shivanshu/wallet/cashout_widget.dart';
import 'package:spinner_try/shivanshu/wallet/exchange_screen.dart';

class WalletOptionsScreen extends StatefulWidget {
  const WalletOptionsScreen({super.key});

  @override
  State<WalletOptionsScreen> createState() => _WalletOptionsScreenState();
}

class _WalletOptionsScreenState extends State<WalletOptionsScreen> {
  final PageController _pageController = PageController();
  int? selectedIndex;

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      if (_pageController.page == 0) {
        setState(() {
          selectedIndex = null;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    int beanBalance = 8000;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Wallet',
          style: textTheme(context).bodyLarge!.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            if (selectedIndex == null) {
              Navigator.of(context).pop();
            } else {
              _pageController.animateToPage(
                0,
                duration: const Duration(milliseconds: 250),
                curve: Curves.bounceIn,
              );
            }
          },
          style: IconButton.styleFrom(
              elevation: 5,
              shadowColor: Colors.black,
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              )),
          icon: const Icon(Icons.keyboard_arrow_left_rounded),
        ),
        actions: [
          TextButton(
            onPressed: () {
              showMsg(context, "History");
            },
            child: Text(
              'History',
              style: textTheme(context).bodyLarge!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
          )
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  color: const Color.fromARGB(255, 255, 244, 192),
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/beans.png',
                        width: 80,
                        height: 80,
                      ),
                      const SizedBox(width: 30),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Balance',
                            style: textTheme(context).bodySmall!.copyWith(
                                // fontWeight: FontWeight.bold,
                                ),
                          ),
                          Wrap(
                            children: [
                              Text(
                                beanBalance.toString(),
                                style: textTheme(context).titleLarge!.copyWith(
                                    // fontWeight: FontWeight.bold,
                                    ),
                              ),
                              Text(
                                ' Beans',
                                style: textTheme(context).titleLarge!.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.all(10),
                  height: constraints.maxHeight - 155,
                  child: PageView(
                    controller: _pageController,
                    children: [
                      MainWalletPage((index) {
                        setState(() {
                          selectedIndex = index;
                        });
                        _pageController.animateToPage(
                          1,
                          duration: const Duration(milliseconds: 250),
                          curve: Curves.bounceIn,
                        );
                      }),
                      if (selectedIndex == 0) const ExchangeScreen(),
                      if (selectedIndex == 1)
                        AgencyScreen(maxBeans: beanBalance),
                      if (selectedIndex == 2)
                        CashoutWidget(
                          totalBeans: beanBalance,
                        ),
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}

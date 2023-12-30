import 'package:flutter/material.dart';
import 'package:spinner_try/shivanshu/models/globals.dart';
import 'package:spinner_try/shivanshu/utils.dart';
import 'package:spinner_try/shivanshu/wallet/agent_screen.dart';
import 'package:spinner_try/shivanshu/wallet/beans_history_screen.dart';
import 'package:spinner_try/shivanshu/wallet/diamond_history_screen.dart';
import 'package:spinner_try/shivanshu/wallet/exchange_screen.dart';
import 'package:spinner_try/shivanshu/wallet/options.dart';

class WalletScreen extends StatelessWidget {
  const WalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width - 30;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Wallet',
          style: textTheme(context).titleLarge!.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        centerTitle: true,
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
              )),
          icon: const Icon(Icons.keyboard_arrow_left_rounded),
        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    SizedBox(
                      width: screenWidth / 2,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black38,
                              blurRadius: 10.0,
                              offset: Offset(0, 0),
                            ),
                          ],
                        ),
                        child: ListTile(
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 4,
                          ),
                          onTap: () {
                            navigatorPush(
                                context, const DiamondHistoryScreen());
                          },
                          trailing:
                              const Icon(Icons.keyboard_arrow_right_rounded),
                          title: const Text('Diamonds'),
                          subtitle: Text(currentUser.diamonds.toString()),
                          leading: Image.asset(
                            'assets/diamond.png',
                            height: 14,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    SizedBox(
                      width: screenWidth / 2,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black38,
                              blurRadius: 10.0,
                              offset: Offset(0, 0),
                            ),
                          ],
                        ),
                        child: ListTile(
                          onTap: () {
                            navigatorPush(context, const WalletOptionsScreen());
                          },
                          trailing:
                              const Icon(Icons.keyboard_arrow_right_rounded),
                          title: const FittedBox(
                              fit: BoxFit.scaleDown,
                              alignment: Alignment.centerLeft,
                              child: Text('Beans')),
                          subtitle: Text(currentUser.beans.toString()),
                          leading: Image.asset(
                            'assets/bean.png',
                            height: 20,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.only(top: 11),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 255, 241, 212),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Diamonds'),
                            InkWell(
                              onTap: () {
                                navigatorPush(
                                    context, const BeanHistoryScreen());
                              },
                              child: const MyRow(
                                // crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    'History',
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 255, 191, 6),
                                    ),
                                  ),
                                  Icon(Icons.keyboard_arrow_right),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: DiamondText(
                          txt: currentUser.diamonds.toString(),
                          size: 37,
                          textStyle: textTheme(context).titleLarge!.copyWith(
                                fontSize: 37,
                              ),
                        ),
                      ),
                      Container(
                        decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 253, 224, 182),
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(20),
                            bottomRight: Radius.circular(20),
                          ),
                        ),
                        padding: const EdgeInsets.only(
                            left: 17, top: 9, bottom: 9, right: 13),
                        child: InkWell(
                          onTap: () {
                            showMsg(context, 'recharge');
                          },
                          child: const MyRow(
                            children: [
                              Expanded(
                                child: Text(
                                  "Recharge diamonds to get points which can be exchanged for privileges",
                                ),
                              ),
                              Icon(Icons.keyboard_arrow_right_rounded),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Image.asset('assets/wallet_screen.png'),
                const SizedBox(height: 20),
                const SizedBox(height: 10),
                ListTile(
                  onTap: () {
                    navigatorPush(context, const AgentScreen());
                  },
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      width: 1,
                      color: Colors.grey.withOpacity(0.2),
                    ),
                  ),
                  tileColor: Colors.white,
                  selectedColor: Colors.white,
                  focusColor: Colors.white,
                  hoverColor: Colors.white,
                  title: const Text(
                    'Agent',
                    textAlign: TextAlign.center,
                  ),
                  leading: Image.asset('assets/agent.png'),
                  trailing: const Icon(Icons.keyboard_arrow_right_rounded),
                ),
                const SizedBox(height: 10),
                ListTile(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      width: 1,
                      color: Colors.grey.withOpacity(0.2),
                    ),
                  ),
                  onTap: () {},
                  tileColor: Colors.white,
                  selectedColor: Colors.white,
                  focusColor: Colors.white,
                  hoverColor: Colors.white,
                  title: const Text(
                    'Credit/Debit Card',
                    textAlign: TextAlign.center,
                  ),
                  leading: Image.asset('assets/atm-card.png'),
                  trailing: const Icon(Icons.keyboard_arrow_right_rounded),
                ),
                const SizedBox(height: 10),
                ListTile(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      width: 1,
                      color: Colors.grey.withOpacity(0.2),
                    ),
                  ),
                  onTap: () {},
                  tileColor: Colors.white,
                  selectedColor: Colors.white,
                  focusColor: Colors.white,
                  hoverColor: Colors.white,
                  title: const Text(
                    'Paytm',
                    textAlign: TextAlign.center,
                  ),
                  leading: Image.asset('assets/paytm.png'),
                  trailing: const Icon(Icons.keyboard_arrow_right_rounded),
                ),
                const SizedBox(height: 10),
                ListTile(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      width: 1,
                      color: Colors.grey.withOpacity(0.2),
                    ),
                  ),
                  onTap: () {},
                  tileColor: Colors.white,
                  selectedColor: Colors.white,
                  focusColor: Colors.white,
                  hoverColor: Colors.white,
                  title: const Text(
                    'Phone Pe',
                    textAlign: TextAlign.center,
                  ),
                  leading: Image.asset('assets/phonepe.png'),
                  trailing: const Icon(Icons.keyboard_arrow_right_rounded),
                ),
                const SizedBox(height: 10),
                ListTile(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      width: 1,
                      color: Colors.grey.withOpacity(0.2),
                    ),
                  ),
                  onTap: () {},
                  tileColor: Colors.white,
                  selectedColor: Colors.white,
                  focusColor: Colors.white,
                  hoverColor: Colors.white,
                  title: const Text(
                    'Google Pay',
                    textAlign: TextAlign.center,
                  ),
                  leading: Image.asset('assets/gpay.png'),
                  trailing: const Icon(Icons.keyboard_arrow_right_rounded),
                ),
                const SizedBox(height: 10),
                ListTile(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      width: 1,
                      color: Colors.grey.withOpacity(0.2),
                    ),
                  ),
                  onTap: () {},
                  tileColor: Colors.white,
                  selectedColor: Colors.white,
                  focusColor: Colors.white,
                  hoverColor: Colors.white,
                  title: const Text(
                    'UPI',
                    textAlign: TextAlign.center,
                  ),
                  leading: Image.asset('assets/bhim.png'),
                  trailing: const Icon(Icons.keyboard_arrow_right_rounded),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

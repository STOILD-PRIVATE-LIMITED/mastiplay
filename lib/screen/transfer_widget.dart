import 'package:flutter/material.dart';
import 'package:spinner_try/screen/exchange_method.dart';
import 'package:spinner_try/screen/recharge_method.dart';
import 'package:spinner_try/screen/transfer_method.dart';
import 'package:spinner_try/user_model.dart';

class TransferWidget extends StatelessWidget {
  final UserModel user;
  const TransferWidget({
    super.key,
    required this.height,
    required this.width,
    required this.user,
  });

  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Padding(
        padding: EdgeInsets.only(
          top: height / 20,
          left: width / 20,
          right: width / 20,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset('assets/diamond.png',
                        height: height / 15, width: width / 15),
                    SizedBox(
                      width: width / 30,
                    ),
                    Text(
                      user.agentData!.diamonds.toString(),
                      style: TextStyle(
                          fontSize: height / 40, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset('assets/bean.png',
                        height: height / 15, width: width / 15),
                    SizedBox(
                      width: width / 30,
                    ),
                    Text(
                      user.beans.toString(),
                      style: TextStyle(
                          fontSize: height / 40, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                // Row(
                //   children: [
                //     const Icon(
                //       Icons.diamond,
                //       color: Colors.pink,
                //     ),
                //     Text(
                //       "CoinSeller",
                //       style: TextStyle(
                //           fontSize: height / 50, fontWeight: FontWeight.bold),
                //     ),
                //     Icon(
                //       Icons.question_mark,
                //       size: height / 60,
                //     )
                //   ],
                // )
              ],
            ),
            SizedBox(
              height: height / 30,
            ),
            TabBar(
              // controller: _tabController,
              labelColor: Colors.black,
              unselectedLabelColor: Colors.grey,
              indicator: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(50),
                color: Colors.pink,
              ),
              tabs: [
                Container(
                  height: height / 20,
                  width: width / 4,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    "Transfer",
                    style:
                        TextStyle(color: Colors.black, fontSize: height / 60),
                  ),
                ),
                Container(
                  height: height / 20,
                  width: width / 4,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    "Recharge",
                    style:
                        TextStyle(color: Colors.black, fontSize: height / 60),
                  ),
                ),
                Container(
                  height: height / 20,
                  width: width / 4,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    "Exchange",
                    style:
                        TextStyle(color: Colors.black, fontSize: height / 60),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: height / 30,
            ),
            Expanded(
              child: TabBarView(
                children: [
                  TransferMethod(
                    height: height,
                    width: width,
                  ),
                  RechargeMethod(
                    height: height,
                    width: width,
                  ),
                  ExchangeMethod(
                    user: user,
                    height: height,
                    width: width,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

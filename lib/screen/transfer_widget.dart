import 'package:flutter/material.dart';
import 'package:spinner_try/screen/exchange_method.dart';
import 'package:spinner_try/screen/recharge_method.dart';
import 'package:spinner_try/screen/transfer_method.dart';

class TransferWidget extends StatefulWidget {
  const TransferWidget({
    super.key,
    required this.height,
    required this.width,
  });

  final double height;
  final double width;

  @override
  State<TransferWidget> createState() => _TransferWidgetState();
}

class _TransferWidgetState extends State<TransferWidget>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    double height = widget.height;
    double width = widget.width;
    return DefaultTabController(
      length: 3,
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: height / 20,
          horizontal: width / 20,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.diamond,
                      color: Colors.pink,
                    ),
                    SizedBox(
                      width: width / 30,
                    ),
                    Text(
                      "999999",
                      style: TextStyle(
                          fontSize: height / 60, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.diamond,
                      color: Colors.pink,
                    ),
                    Text(
                      "CoinSeller",
                      style: TextStyle(
                          fontSize: height / 50, fontWeight: FontWeight.bold),
                    ),
                    Icon(
                      Icons.question_mark,
                      size: height / 60,
                    )
                  ],
                )
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

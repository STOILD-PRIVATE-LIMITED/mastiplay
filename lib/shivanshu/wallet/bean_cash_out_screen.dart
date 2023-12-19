import 'package:flutter/material.dart';
import 'package:spinner_try/shivanshu/utils.dart';

class BeanCashoutScreen extends StatefulWidget {
  const BeanCashoutScreen({super.key});

  @override
  State<BeanCashoutScreen> createState() => _BeanCashoutScreenState();
}

class _BeanCashoutScreenState extends State<BeanCashoutScreen> {
  String currencyType = "Applying";

  @override
  Widget build(BuildContext context) {
    const double iconsize = 20;
    final size = MediaQuery.of(context).size;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DropdownButton(
          elevation: 2,
          // icon: Icon(Icons.keyboard_arrow_down_rounded),
          selectedItemBuilder: (context) {
            return [
              const MyRow(
                children: [
                  Icon(
                    Icons.circle_rounded,
                    color: Colors.purple,
                    size: iconsize,
                  ),
                  Text("Applying"),
                ],
              ),
              const MyRow(
                children: [
                  Icon(
                    Icons.access_time_filled,
                    color: Colors.blue,
                    size: iconsize,
                  ),
                  Text("Pending"),
                ],
              ),
              const MyRow(
                children: [
                  Icon(
                    Icons.check_rounded,
                    color: Colors.green,
                    size: iconsize,
                  ),
                  Text("Success"),
                ],
              ),
              const MyRow(
                children: [
                  Icon(
                    Icons.close_rounded,
                    color: Colors.red,
                    size: iconsize,
                  ),
                  Text("Failed"),
                ],
              ),
            ];
          },
          hint: const Text('View Only'),
          underline: Container(),
          borderRadius: BorderRadius.circular(20),
          value: currencyType,
          items: const [
            DropdownMenuItem(
              value: "Applying",
              child: MyRow(
                children: [
                  Icon(
                    Icons.circle_rounded,
                    color: Colors.purple,
                    size: iconsize,
                  ),
                  Text("Applying"),
                ],
              ),
            ),
            DropdownMenuItem(
              value: "Pending",
              child: MyRow(
                children: [
                  Icon(
                    Icons.access_time_filled,
                    color: Colors.blue,
                    size: iconsize,
                  ),
                  Text("Pending"),
                ],
              ),
            ),
            DropdownMenuItem(
              value: "Success",
              child: MyRow(
                children: [
                  Icon(
                    Icons.check_rounded,
                    color: Colors.green,
                    size: iconsize,
                  ),
                  Text("Success"),
                ],
              ),
            ),
            DropdownMenuItem(
              value: "Failed",
              child: MyRow(
                children: [
                  Icon(
                    Icons.close_rounded,
                    color: Colors.red,
                    size: iconsize,
                  ),
                  Text("Failed"),
                ],
              ),
            ),
          ],
          onChanged: (value) {
            setState(() {
              currencyType = value ?? "INR";
            });
          },
        ),
        SizedBox(
          height: size.height - 185,
          child: ListView.builder(
            shrinkWrap: true,
            itemBuilder: (context, index) => ListTile(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('2,800.00'),
                  Card(
                    elevation: 0,
                    color: Colors.green.withOpacity(0.1),
                    child: const MyRow(
                      children: [
                        Icon(
                          Icons.check_circle_rounded,
                          color: Colors.green,
                          size: 15,
                        ),
                        Text(
                          'Success',
                          style: TextStyle(color: Colors.green, fontSize: 12),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              subtitle: const Text('2023-12-05 22:59:20'),
              // trailing: MyRow(
              //   children: [
              //     const Text('+1000'),
              //     Image.asset(
              //       'assets/atm-card.png',
              //       width: 14,
              //     ),
              //   ],
              // ),
            ),
          ),
        ),
      ],
    );
  }
}

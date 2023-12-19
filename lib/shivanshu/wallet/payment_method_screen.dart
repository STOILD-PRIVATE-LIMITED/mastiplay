import 'package:flutter/material.dart';
import 'package:spinner_try/shivanshu/utils.dart';

class PaymentMethodScreen extends StatefulWidget {
  const PaymentMethodScreen({super.key});

  @override
  State<PaymentMethodScreen> createState() => _PaymentMethodScreenState();
}

class _PaymentMethodScreenState extends State<PaymentMethodScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(),
        title: const Text('Payment method'),
        titleTextStyle: textTheme(context).bodyMedium!.copyWith(
              fontWeight: FontWeight.bold,
            ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.close),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Card(
                elevation: 0,
                color: const Color.fromARGB(255, 255, 240, 201),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Icon(
                            Icons.star_rounded,
                            size: 14,
                            color: Color.fromARGB(255, 250, 184, 82),
                          ),
                          Text(
                            'Coint-Seller Method',
                            style: textTheme(context).bodyMedium!.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color:
                                      const Color.fromARGB(255, 250, 184, 82),
                                ),
                          ),
                          const Icon(
                            size: 14,
                            Icons.question_mark_rounded,
                            color: Color.fromARGB(255, 250, 184, 82),
                          ),
                        ],
                      ),
                      Text(
                        "Lower fees and reviewed within 24 hours",
                        style: textTheme(context).bodySmall!.copyWith(
                              fontWeight: FontWeight.bold,
                              color: const Color.fromARGB(255, 250, 184, 82),
                            ),
                      ),
                      Card(
                        elevation: 0,
                        color: Colors.white,
                        child: Column(
                          children: [
                            ListTile(
                              onTap: () {
                                showMsg(context, 'Bank');
                              },
                              title: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    'Bank',
                                    style:
                                        textTheme(context).bodyMedium!.copyWith(
                                              fontWeight: FontWeight.bold,
                                            ),
                                  ),
                                  const SizedBox(width: 10),
                                  Container(
                                    padding: const EdgeInsets.all(2),
                                    decoration: BoxDecoration(
                                      color: const Color.fromARGB(
                                          255, 233, 237, 242),
                                      borderRadius: BorderRadius.circular(3),
                                    ),
                                    child: Text(
                                      "INR ₹",
                                      style: textTheme(context)
                                          .bodySmall!
                                          .copyWith(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12,
                                            color: const Color.fromARGB(
                                                255, 110, 116, 121),
                                          ),
                                    ),
                                  ),
                                ],
                              ),
                              subtitle: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(2),
                                        decoration: BoxDecoration(
                                          color: const Color.fromARGB(
                                              255, 255, 250, 217),
                                          borderRadius:
                                              BorderRadius.circular(3),
                                        ),
                                        child: Text(
                                          "Fee: 3%+0",
                                          style: textTheme(context)
                                              .bodySmall!
                                              .copyWith(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12,
                                                color: const Color.fromARGB(
                                                    255, 250, 180, 46),
                                              ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    "* Need to manually confirmed",
                                    style:
                                        textTheme(context).bodySmall!.copyWith(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.grey,
                                            ),
                                  ),
                                ],
                              ),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Image.asset("assets/atm-card.png"),
                                  const Icon(
                                    Icons.keyboard_arrow_right_rounded,
                                  ),
                                ],
                              ),
                            ),
                            ListTile(
                              onTap: () {
                                showMsg(context, 'UPI');
                              },
                              title: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    'UPI',
                                    style:
                                        textTheme(context).bodyMedium!.copyWith(
                                              fontWeight: FontWeight.bold,
                                            ),
                                  ),
                                  const SizedBox(width: 10),
                                  Container(
                                    padding: const EdgeInsets.all(2),
                                    decoration: BoxDecoration(
                                      color: const Color.fromARGB(
                                          255, 233, 237, 242),
                                      borderRadius: BorderRadius.circular(3),
                                    ),
                                    child: Text(
                                      "INR ₹",
                                      style: textTheme(context)
                                          .bodySmall!
                                          .copyWith(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12,
                                            color: const Color.fromARGB(
                                                255, 110, 116, 121),
                                          ),
                                    ),
                                  ),
                                ],
                              ),
                              subtitle: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(2),
                                        decoration: BoxDecoration(
                                          color: const Color.fromARGB(
                                              255, 255, 250, 217),
                                          borderRadius:
                                              BorderRadius.circular(3),
                                        ),
                                        child: Text(
                                          "Fee: 3%+0",
                                          style: textTheme(context)
                                              .bodySmall!
                                              .copyWith(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12,
                                                color: const Color.fromARGB(
                                                    255, 250, 180, 46),
                                              ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    "* Need to manually confirmed",
                                    style:
                                        textTheme(context).bodySmall!.copyWith(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.grey,
                                            ),
                                  ),
                                ],
                              ),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const SizedBox(width: 2),
                                  Image.asset(
                                    "assets/bhim.png",
                                    height: 40,
                                    width: 40,
                                  ),
                                  const SizedBox(width: 2),
                                  Image.asset(
                                    "assets/phonepe.png",
                                    height: 15,
                                    width: 15,
                                  ),
                                  const SizedBox(width: 2),
                                  Image.asset(
                                    "assets/paytm.png",
                                    height: 20,
                                    width: 20,
                                  ),
                                  const Icon(
                                    Icons.keyboard_arrow_right_rounded,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Card(
                elevation: 0,
                color: Colors.blue.withOpacity(0.1),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'In-App Withdrawal',
                            style: textTheme(context).bodyMedium!.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                        ],
                      ),
                      Card(
                        elevation: 0,
                        color: Colors.white,
                        child: Column(
                          children: [
                            ListTile(
                              onTap: () {
                                showMsg(context, 'UPI');
                              },
                              title: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    'UPI',
                                    style:
                                        textTheme(context).bodyMedium!.copyWith(
                                              fontWeight: FontWeight.bold,
                                            ),
                                  ),
                                  const SizedBox(width: 10),
                                  Container(
                                    padding: const EdgeInsets.all(2),
                                    decoration: BoxDecoration(
                                      color: const Color.fromARGB(
                                          255, 233, 237, 242),
                                      borderRadius: BorderRadius.circular(3),
                                    ),
                                    child: Text(
                                      "INR ₹",
                                      style: textTheme(context)
                                          .bodySmall!
                                          .copyWith(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12,
                                            color: const Color.fromARGB(
                                                255, 110, 116, 121),
                                          ),
                                    ),
                                  ),
                                ],
                              ),
                              subtitle: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(2),
                                        decoration: BoxDecoration(
                                          color: const Color.fromARGB(
                                              255, 255, 250, 217),
                                          borderRadius:
                                              BorderRadius.circular(3),
                                        ),
                                        child: Text(
                                          "Fee: 3%+0",
                                          style: textTheme(context)
                                              .bodySmall!
                                              .copyWith(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12,
                                                color: const Color.fromARGB(
                                                    255, 250, 180, 46),
                                              ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const SizedBox(width: 2),
                                  Image.asset(
                                    "assets/bhim.png",
                                    height: 40,
                                    width: 40,
                                  ),
                                  const SizedBox(width: 2),
                                  Image.asset(
                                    "assets/phonepe.png",
                                    height: 15,
                                    width: 15,
                                  ),
                                  const SizedBox(width: 2),
                                  Image.asset(
                                    "assets/paytm.png",
                                    height: 20,
                                    width: 20,
                                  ),
                                  const Icon(
                                    Icons.keyboard_arrow_right_rounded,
                                  ),
                                ],
                              ),
                            ),
                            ListTile(
                              onTap: () {
                                showMsg(context, 'Bank');
                              },
                              title: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    'Bank',
                                    style:
                                        textTheme(context).bodyMedium!.copyWith(
                                              fontWeight: FontWeight.bold,
                                            ),
                                  ),
                                  const SizedBox(width: 10),
                                  Container(
                                    padding: const EdgeInsets.all(2),
                                    decoration: BoxDecoration(
                                      color: const Color.fromARGB(
                                          255, 233, 237, 242),
                                      borderRadius: BorderRadius.circular(3),
                                    ),
                                    child: Text(
                                      "INR ₹",
                                      style: textTheme(context)
                                          .bodySmall!
                                          .copyWith(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12,
                                            color: const Color.fromARGB(
                                                255, 110, 116, 121),
                                          ),
                                    ),
                                  ),
                                ],
                              ),
                              subtitle: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(2),
                                        decoration: BoxDecoration(
                                          color: const Color.fromARGB(
                                              255, 255, 250, 217),
                                          borderRadius:
                                              BorderRadius.circular(3),
                                        ),
                                        child: Text(
                                          "Fee: 3%+0",
                                          style: textTheme(context)
                                              .bodySmall!
                                              .copyWith(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12,
                                                color: const Color.fromARGB(
                                                    255, 250, 180, 46),
                                              ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Image.asset("assets/atm-card.png"),
                                  const Icon(
                                    Icons.keyboard_arrow_right_rounded,
                                  ),
                                ],
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

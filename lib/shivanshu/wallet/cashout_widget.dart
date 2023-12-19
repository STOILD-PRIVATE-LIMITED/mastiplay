import 'package:flutter/material.dart';
import 'package:spinner_try/shivanshu/utils.dart';
import 'package:spinner_try/shivanshu/wallet/payment_method_screen.dart';

class CashoutWidget extends StatelessWidget {
  final int totalBeans;
  CashoutWidget({super.key, required this.totalBeans});

  final _beans = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextButton(
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return const Text('Choose a currency type.');
                      },
                    );
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 225, 226, 228),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    foregroundColor: Colors.black,
                    textStyle: textTheme(context).bodyMedium!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('Currency Type'),
                          // Icon(Icons.question_mark, size: 14),
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/india.png',
                            width: 30,
                            fit: BoxFit.contain,
                          ),
                          const Text('INR'),
                          const Icon(
                            Icons.keyboard_arrow_right,
                            color: Color.fromARGB(255, 130, 138, 147),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 15),
                Card(
                  color: const Color.fromARGB(255, 245, 246, 248),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Bean amount for cashing out.',
                          style: textTheme(context).bodyMedium!.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        TextField(
                          controller: _beans,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            icon: Image.asset('assets/bean.png'),
                            suffixIcon: TextButton(
                              style: TextButton.styleFrom(
                                padding: const EdgeInsets.all(0),
                                visualDensity: VisualDensity.compact,
                              ),
                              onPressed: () {
                                _beans.text = totalBeans.toString();
                              },
                              child: const Text('All'),
                            ),
                            hintText: 'Please enter the quantity',
                            // hintStyle: const TextStyle(color: Colors.black),
                            isDense: true,
                            // filled: true,
                            // fillColor: Colors.black12,
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 5,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(3),
                              borderSide: BorderSide.none,
                            ),
                          ),
                          style: const TextStyle(
                            decorationColor: Colors.black12,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextField(
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            icon: Text(
                              'INR: -',
                              style: textTheme(context).bodyMedium!.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                            suffixIcon: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Image.asset(
                                  'assets/bean.png',
                                  height: 10,
                                  width: 10,
                                ),
                                Text(
                                  '10k = ₹100',
                                  style: textTheme(context).bodySmall!.copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: const Color.fromARGB(
                                            255, 141, 148, 162),
                                      ),
                                ),
                              ],
                            ),
                            // hintText: 'Please enter the quantity',
                            // hintStyle: const TextStyle(color: Colors.black),
                            isDense: true,
                            // filled: true,
                            // fillColor: Colors.black12,
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 5,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(3),
                              borderSide: BorderSide.none,
                            ),
                          ),
                          style: const TextStyle(
                            decorationColor: Colors.black12,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                TextButton(
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return const PaymentMethodScreen();
                      },
                    );
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 225, 226, 228),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    foregroundColor: const Color.fromARGB(255, 130, 138, 147),
                    textStyle: textTheme(context).bodyMedium!.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Payment method'),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('Select'),
                          Icon(
                            Icons.keyboard_arrow_right,
                            color: Color.fromARGB(255, 130, 138, 147),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 224, 93, 211),
                  foregroundColor: colorScheme(context).onPrimary,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  )),
              onPressed: () {
                showMsg(context, 'Withdraw');
              },
              child: Text(
                'WITHDRAW',
                style: textTheme(context).titleMedium!.copyWith(
                      fontWeight: FontWeight.bold,
                      color: colorScheme(context).onPrimary,
                    ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

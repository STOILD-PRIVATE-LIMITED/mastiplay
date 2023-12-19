import 'package:flutter/material.dart';
import 'package:spinner_try/shivanshu/utils.dart';
import 'package:spinner_try/shivanshu/wallet/agency_screen.dart';

class AgentScreen extends StatefulWidget {
  const AgentScreen({super.key});

  @override
  State<AgentScreen> createState() => _AgentScreenState();
}

class _AgentScreenState extends State<AgentScreen> {
  String currencyType = "INR";

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
        title: MyRow(
          children: [
            Image.asset(
              'assets/diamond.png',
              width: 24,
            ),
            const Text("Agent"),
          ],
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: ListView.separated(
          separatorBuilder: (context, index) => const SizedBox(height: 10),
          itemCount: 100,
          shrinkWrap: true,
          itemBuilder: (context, index) => index == 0
              ? DropdownButton(
                  elevation: 2,
                  // icon: Icon(Icons.keyboard_arrow_down_rounded),
                  selectedItemBuilder: (context) {
                    return [
                      MyRow(
                        children: [
                          const Text("India-INR"),
                          Image.asset('assets/india.png', width: 20),
                        ],
                      ),
                      MyRow(
                        children: [
                          const Text("HEHE"),
                          Image.asset('assets/india.png', width: 20),
                        ],
                      ),
                      MyRow(
                        children: [
                          const Text("HEHE1"),
                          Image.asset('assets/india.png', width: 20),
                        ],
                      ),
                      MyRow(
                        children: [
                          const Text("HEHE2"),
                          Image.asset('assets/india.png', width: 20),
                        ],
                      ),
                    ];
                  },
                  hint: const Text('View Only'),
                  underline: Container(),
                  borderRadius: BorderRadius.circular(20),
                  value: currencyType,
                  items: [
                    DropdownMenuItem(
                      value: "INR",
                      child: MyRow(
                        children: [
                          const Text("India-INR"),
                          Image.asset('assets/india.png', width: 20),
                        ],
                      ),
                    ),
                    DropdownMenuItem(
                      value: "HEHE",
                      child: MyRow(
                        children: [
                          const Text("HEHE"),
                          Image.asset('assets/india.png', width: 20),
                        ],
                      ),
                    ),
                    DropdownMenuItem(
                      value: "HEHE1",
                      child: MyRow(
                        children: [
                          const Text("HEHE1"),
                          Image.asset('assets/india.png', width: 20),
                        ],
                      ),
                    ),
                    DropdownMenuItem(
                      value: "HEHE2",
                      child: MyRow(
                        children: [
                          const Text("HEHE2"),
                          Image.asset('assets/india.png', width: 20),
                        ],
                      ),
                    ),
                  ],
                  onChanged: (value) {
                    setState(() {
                      currencyType = value ?? "INR";
                    });
                  },
                )
              : const PersonTile(),
        ),
      ),
    );
  }
}

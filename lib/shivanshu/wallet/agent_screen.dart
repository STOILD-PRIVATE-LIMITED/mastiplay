import 'package:flutter/material.dart';
import 'package:spinner_try/shivanshu/models/agent/agent.dart';
import 'package:spinner_try/shivanshu/utils.dart';
import 'package:spinner_try/shivanshu/wallet/agency_screen.dart';
import 'package:spinner_try/shivanshu/widgets/scroll_builder.dart';

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
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: DropdownButton(
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
                // MyRow(
                //   children: [
                //     const Text("HEHE"),
                //     Image.asset('assets/india.png', width: 20),
                //   ],
                // ),
                // MyRow(
                //   children: [
                //     const Text("HEHE1"),
                //     Image.asset('assets/india.png', width: 20),
                //   ],
                // ),
                // MyRow(
                //   children: [
                //     const Text("HEHE2"),
                //     Image.asset('assets/india.png', width: 20),
                //   ],
                // ),
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
              // DropdownMenuItem(
              //   value: "HEHE",
              //   child: MyRow(
              //     children: [
              //       const Text("HEHE"),
              //       Image.asset('assets/india.png', width: 20),
              //     ],
              //   ),
              // ),
              // DropdownMenuItem(
              //   value: "HEHE1",
              //   child: MyRow(
              //     children: [
              //       const Text("HEHE1"),
              //       Image.asset('assets/india.png', width: 20),
              //     ],
              //   ),
              // ),
              // DropdownMenuItem(
              //   value: "HEHE2",
              //   child: MyRow(
              //     children: [
              //       const Text("HEHE2"),
              //       Image.asset('assets/india.png', width: 20),
              //     ],
              //   ),
              // ),
            ],
            onChanged: (value) {
              setState(() {
                currencyType = value ?? "INR";
              });
            },
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: ScrollBuilder2(
          separatorBuilder: (context, index) => const SizedBox(height: 10),
          loader: (start, lastItem) {
            return fetchAgentsAll(start, 20);
          },
          itemBuilder: (context, user) => AgentTile(user: user),
        ),
      ),
    );
  }
}

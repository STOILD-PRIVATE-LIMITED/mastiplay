import 'package:flutter/material.dart';

import 'data_widget.dart';
import 'transfer_widget.dart';

class Agent extends StatefulWidget {
  const Agent({super.key});

  @override
  State<Agent> createState() => _AgentState();
}

class _AgentState extends State<Agent> with SingleTickerProviderStateMixin {


  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            labelColor: Colors.white,
            unselectedLabelColor: Colors.yellow,
            indicator: const BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.all(
                Radius.circular(50),
              ),
              color: Colors.grey,
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
                  "Data",
                  style: TextStyle(color: Colors.black, fontSize: height / 40),
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
                  "Transfer",
                  style: TextStyle(color: Colors.black, fontSize: height / 40),
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(children: [
          DataWidget(height: height, width: width),
          TransferWidget(height: height, width: width),
        ]),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:spinner_try/shivanshu/screens/family_room_page.dart';
import 'package:spinner_try/user_model.dart';

import 'data_widget.dart';
import 'transfer_widget.dart';

class AgentPanel extends StatefulWidget {
  final UserModel user;
  const AgentPanel({super.key, required this.user});

  @override
  State<AgentPanel> createState() => _AgentPanelState();
}

class _AgentPanelState extends State<AgentPanel>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          leading: const ElevatedBackButton(),
          title: TabBar(
            labelColor: Colors.white,
            unselectedLabelColor: Colors.yellow,
            labelPadding: EdgeInsets.zero,
            padding: EdgeInsets.zero,
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
          DataWidget(user: widget.user, height: height, width: width),
          TransferWidget(user: widget.user, height: height, width: width),
        ]),
      ),
    );
  }
}

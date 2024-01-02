import 'package:flutter/material.dart';
import 'package:spinner_try/shivanshu/admin_panel/agency_panel.dart';
import 'package:spinner_try/shivanshu/models/globals.dart';
import 'package:spinner_try/shivanshu/screens/family_room_page.dart';
import 'package:spinner_try/shivanshu/utils.dart';
import 'package:spinner_try/shivanshu/widgets/grid_tile_logo.dart';

class AdminPanel extends StatefulWidget {
  const AdminPanel({super.key});

  @override
  State<AdminPanel> createState() => _AdminPanelState();
}

class _AdminPanelState extends State<AdminPanel> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const ElevatedBackButton(),
        title: Text(
          'Welcome ${currentUser.name}',
          style: textTheme(context).titleLarge,
          textAlign: TextAlign.center,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: GridView.extent(
            shrinkWrap: true,
            maxCrossAxisExtent: 200,
            childAspectRatio: 1.2,
            children: [
              GridTileLogo(
                onTap: () {
                  navigatorPush(context, const AgencyPanel());
                },
                title: "Agency",
                icon: const Icon(Icons.support_agent_rounded, size: 50),
                color: Colors.blue,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

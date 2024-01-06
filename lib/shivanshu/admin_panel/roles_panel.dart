import 'package:flutter/material.dart';
import 'package:spinner_try/shivanshu/admin_panel/agency_panel.dart';
import 'package:spinner_try/shivanshu/admin_panel/agent_panel.dart';
import 'package:spinner_try/shivanshu/models/globals.dart';
import 'package:spinner_try/shivanshu/screens/family_room_page.dart';
import 'package:spinner_try/shivanshu/screens/in_dev_screen.dart';
import 'package:spinner_try/shivanshu/utils.dart';
import 'package:spinner_try/shivanshu/widgets/grid_tile_logo.dart';

class RolesPanel extends StatefulWidget {
  const RolesPanel({super.key});

  @override
  State<RolesPanel> createState() => _RolesPanelState();
}

class _RolesPanelState extends State<RolesPanel> {
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
          child: Column(
            children: [
              SizedBox(
                height: 100,
                width: 150,
                child: GridTileLogo(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  title: "Roles",
                  icon:
                      const Icon(Icons.admin_panel_settings_rounded, size: 50),
                  color: Colors.redAccent,
                ),
              ),
              const SizedBox(height: 25),
              GridView.extent(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                maxCrossAxisExtent: 200,
                childAspectRatio: 1.2,
                crossAxisSpacing: 4,
                mainAxisSpacing: 4,
                children: [
                  GridTileLogo(
                    onTap: () {
                      navigatorPush(context, const AgencyPanel());
                    },
                    title: "Agency",
                    icon: const Icon(Icons.business_rounded, size: 50),
                    color: Colors.blueAccent,
                  ),
                  GridTileLogo(
                    onTap: () {
                      navigatorPush(context, const AgentPanel());
                    },
                    title: "Agent",
                    icon: const Icon(Icons.support_agent_rounded, size: 50),
                    color: Colors.greenAccent,
                  ),
                  GridTileLogo(
                    onTap: () {
                      navigatorPush(context, const InDevScreen());
                    },
                    title: "Admins",
                    icon: const Icon(
                      Icons.admin_panel_settings_rounded,
                      size: 50,
                    ),
                    color: Colors.redAccent,
                  ),
                  GridTileLogo(
                    onTap: () {
                      navigatorPush(context, const InDevScreen());
                    },
                    title: "Super Admins",
                    icon: const Icon(
                      Icons.admin_panel_settings_rounded,
                      size: 50,
                    ),
                    color: Colors.redAccent,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

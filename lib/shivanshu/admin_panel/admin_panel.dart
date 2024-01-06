import 'package:flutter/material.dart';
import 'package:spinner_try/shivanshu/admin_panel/commission_panel.dart';
import 'package:spinner_try/shivanshu/admin_panel/roles_panel.dart';
import 'package:spinner_try/shivanshu/models/globals.dart';
import 'package:spinner_try/shivanshu/screens/family_room_page.dart';
import 'package:spinner_try/shivanshu/screens/in_dev_screen.dart';
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
            crossAxisSpacing: 4,
            mainAxisSpacing: 4,
            children: [
              GridTileLogo(
                onTap: () {
                  navigatorPush(context, const RolesPanel());
                },
                title: "Roles",
                icon: const Icon(Icons.admin_panel_settings_rounded, size: 50),
                color: Colors.redAccent,
              ),
              GridTileLogo(
                onTap: () {
                  navigatorPush(context, const InDevScreen());
                },
                title: "Themes",
                icon: const Icon(
                  Icons.draw_rounded,
                  size: 50,
                ),
                color: Colors.blueAccent,
              ),
              GridTileLogo(
                onTap: () {
                  navigatorPush(context, const InDevScreen());
                },
                title: "Posts",
                icon: const Icon(
                  Icons.portrait_sharp,
                  size: 50,
                ),
                color: Colors.greenAccent,
              ),
              GridTileLogo(
                onTap: () {
                  navigatorPush(context, const InDevScreen());
                },
                title: "All Users",
                icon: const Icon(
                  Icons.person_rounded,
                  size: 50,
                ),
                color: Colors.greenAccent,
              ),
              GridTileLogo(
                onTap: () {
                  navigatorPush(context, const InDevScreen());
                },
                title: "Events",
                icon: const Icon(
                  Icons.emoji_events_rounded,
                  size: 50,
                ),
                color: Colors.yellowAccent,
              ),
              GridTileLogo(
                onTap: () {
                  navigatorPush(context, const CommissionPanel());
                },
                title: "Commissions",
                icon: const Icon(
                  Icons.attach_money_rounded,
                  size: 50,
                ),
                color: Colors.cyanAccent,
              ),
              GridTileLogo(
                onTap: () {
                  navigatorPush(context, const InDevScreen());
                },
                title: "Rooms",
                icon: const Icon(
                  Icons.room_preferences_rounded,
                  size: 50,
                ),
                color: Colors.indigoAccent,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

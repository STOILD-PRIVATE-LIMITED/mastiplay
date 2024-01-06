import 'package:flutter/material.dart';
import 'package:spinner_try/shivanshu/models/globals.dart';
import 'package:spinner_try/shivanshu/screens/family_room_page.dart';
import 'package:spinner_try/shivanshu/screens/in_dev_screen.dart';
import 'package:spinner_try/shivanshu/utils.dart';
import 'package:spinner_try/shivanshu/widgets/grid_tile_logo.dart';

class CommissionPanel extends StatefulWidget {
  const CommissionPanel({super.key});

  @override
  State<CommissionPanel> createState() => _CommissionPanelState();
}

class _CommissionPanelState extends State<CommissionPanel> {
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
                  title: "Commissions",
                  icon: const Icon(
                    Icons.attach_money_rounded,
                    size: 50,
                  ),
                  color: Colors.cyanAccent,
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
                      navigatorPush(context, const InDevScreen());
                    },
                    title: "BD Commission",
                    icon: const Icon(Icons.location_city_rounded, size: 50),
                    color: Colors.blueAccent,
                  ),
                  GridTileLogo(
                    onTap: () {
                      navigatorPush(context, const InDevScreen());
                    },
                    title: "Agency Commission",
                    icon: const Icon(Icons.business_rounded, size: 50),
                    color: Colors.greenAccent,
                  ),
                  GridTileLogo(
                    onTap: () {
                      navigatorPush(context, const InDevScreen());
                    },
                    title: "Host Commission",
                    icon: const Icon(
                      Icons.person_4_rounded,
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

import 'package:flutter/material.dart';
import 'package:spinner_try/shivanshu/admin_panel/agency_panel.dart';
import 'package:spinner_try/shivanshu/models/globals.dart';
import 'package:spinner_try/shivanshu/screens/family_room_page.dart';
import 'package:spinner_try/shivanshu/utils.dart';
import 'package:spinner_try/shivanshu/widgets/grid_tile_logo.dart';

class BDPanel extends StatelessWidget {
  const BDPanel({super.key});

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
                    navigatorPush(context, const BDPanel());
                  },
                  title: "BD",
                  icon: const Icon(Icons.people_alt_rounded, size: 50),
                  color: Colors.greenAccent,
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
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

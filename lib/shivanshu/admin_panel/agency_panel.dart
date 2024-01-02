import 'package:flutter/material.dart';
import 'package:spinner_try/shivanshu/models/agency/agency.dart';
import 'package:spinner_try/shivanshu/screens/family_room_page.dart';
import 'package:spinner_try/shivanshu/utils.dart';
import 'package:spinner_try/shivanshu/utils/loading_elevated_button.dart';
import 'package:spinner_try/shivanshu/utils/profile_image.dart';
import 'package:spinner_try/shivanshu/widgets/grid_tile_logo.dart';
import 'package:spinner_try/user_model.dart';

class AgencyPanel extends StatefulWidget {
  const AgencyPanel({super.key});

  @override
  State<AgencyPanel> createState() => _AgencyPanelState();
}

class _AgencyPanelState extends State<AgencyPanel> {
  final _textController = TextEditingController();
  AgencyData? agencyData;
  UserModel? userData;

  final _userIdController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const ElevatedBackButton(),
        title: const Text('Manage Agencies'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: 150,
                height: 150,
                child: GridTileLogo(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  title: "Agency",
                  icon: const Icon(Icons.support_agent_rounded, size: 50),
                  color: Colors.blue,
                ),
              ),
              const SizedBox(height: 50),
              TextField(
                onChanged: ((value) {
                  setState(() {});
                }),
                controller: _userIdController,
                decoration: InputDecoration(
                  labelText: 'Enter UserId',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(
                      color: colorScheme(context).primary,
                      width: 2,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              if (userData != null)
                ListTile(
                  leading: SizedBox(
                    height: 56,
                    width: 56,
                    child: ProfileImage(user: userData!),
                  ),
                  title: Text(userData!.name),
                  subtitle: Text(userData!.id ?? "No Id"),
                ),
              LoadingElevatedButton(
                enabled: _userIdController.text.isNotEmpty,
                icon: const Icon(Icons.person_search_rounded),
                label: const Text('Search User'),
                onPressed: _searchUser,
              ),
              const SizedBox(height: 20),
              if (userData != null) ...[
                TextField(
                  onChanged: ((value) {
                    setState(() {});
                  }),
                  controller: _textController,
                  decoration: InputDecoration(
                    labelText: 'Enter Agency Id',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(
                        color: colorScheme(context).primary,
                        width: 2,
                      ),
                    ),
                  ),
                ),
                LoadingElevatedButton(
                  enabled: _textController.text.isNotEmpty,
                  icon: const Icon(Icons.search_rounded),
                  label: const Text('Search Agency'),
                  onPressed: _searchAgency,
                ),
              ],
              const SizedBox(height: 20),
              if (userData != null)
                if (agencyData != null) Chip(label: Text(agencyData!.name)),
              if (userData != null)
                LoadingElevatedButton(
                  icon: const Icon(Icons.transfer_within_a_station_rounded),
                  label: const Text('Transfer Ownership'),
                  onPressed: _makeAgencyOwner,
                ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _searchUser() async {
    if (_userIdController.text.isEmpty) {
      showMsg(context, "Please enter user id");
      return;
    }
    userData = await fetchUserWithId(_userIdController.text);
    setState(() {
      userData = userData;
    });
  }

  Future<void> _searchAgency() async {
    if (_textController.text.isEmpty) {
      showMsg(context, "Please enter agency id");
      return;
    }
    agencyData = await getAgencyData(_textController.text);
    setState(() {
      agencyData = agencyData;
    });
  }

  Future<void> _makeAgencyOwner() async {
    if (agencyData == null) {
      final response = await askUser(context, "No Agency is mentioned",
          description: "Do you want to create a new agency?",
          yes: true,
          no: true);
      if (response != 'yes') {
        return;
      }
    }
    await makeAgencyOwner(agencyData?.id, _userIdController.text);
    if (context.mounted) {
      showMsg(context, "Agency Owner Changed");
      Navigator.of(context).pop();
    }
  }
}

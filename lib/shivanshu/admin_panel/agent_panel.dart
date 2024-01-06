import 'package:flutter/material.dart';
import 'package:spinner_try/shivanshu/models/agent/agent.dart';
import 'package:spinner_try/shivanshu/screens/family_room_page.dart';
import 'package:spinner_try/shivanshu/utils.dart';
import 'package:spinner_try/shivanshu/utils/loading_elevated_button.dart';
import 'package:spinner_try/shivanshu/utils/profile_image.dart';
import 'package:spinner_try/shivanshu/widgets/grid_tile_logo.dart';
import 'package:spinner_try/user_model.dart';

class AgentPanel extends StatefulWidget {
  const AgentPanel({super.key});

  @override
  State<AgentPanel> createState() => _AgentPanelState();
}

class _AgentPanelState extends State<AgentPanel> {
  final _userIdController = TextEditingController();
  UserModel? userData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const ElevatedBackButton(),
        title: const Text('Manage Agents'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: 150,
                height: 120,
                child: GridTileLogo(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  title: "Agent",
                  icon: const Icon(Icons.support_agent_rounded, size: 50),
                  color: Colors.greenAccent,
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
              LoadingElevatedButton(
                enabled: _userIdController.text.isNotEmpty,
                icon: const Icon(Icons.person_search_rounded),
                label: const Text('Search User'),
                onPressed: _searchUser,
              ),
              if (userData != null) ...[
                const SizedBox(height: 20),
                Chip(
                  label: ListTile(
                    leading: SizedBox(
                      height: 56,
                      width: 56,
                      child: ProfileImage(user: userData!),
                    ),
                    title: Text(userData!.name),
                    subtitle: Text(userData!.id ?? "No Id"),
                  ),
                ),
                LoadingElevatedButton(
                  icon: const Icon(Icons.support_agent_rounded),
                  label: const Text('Make Agent'),
                  onPressed: _makeAgent,
                ),
              ]
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

  Future<void> _makeAgent() async {
    _userIdController.text = _userIdController.text.replaceAll(' ', '').trim();
    if (_userIdController.text.isEmpty || userData == null) {
      showMsg(context, "Enter id first");
      return;
    }
    final user = await fetchUserWithId(_userIdController.text);
    if (user.role == "agent") {
      showMsg(context, "User is already an agent");
      return;
    }
    await postAgent(AgentData(
        id: userData!.id!,
        paymentMethods: [],
        status: "Hey there, want some diamonds??"));
    setState(() {
      userData = user;
    });
  }
}

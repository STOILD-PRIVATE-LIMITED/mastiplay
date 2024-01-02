import 'package:flutter/material.dart';
import 'package:spinner_try/shivanshu/models/agency/agency.dart';
import 'package:spinner_try/shivanshu/utils.dart';
import 'package:spinner_try/shivanshu/utils/loading_elevated_button.dart';

class BindAgency extends StatefulWidget {
  const BindAgency({super.key});

  @override
  State<BindAgency> createState() => _BindAgencyState();
}

class _BindAgencyState extends State<BindAgency> {
  final _textController = TextEditingController();
  AgencyData? agencyData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bind Agency'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
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
                const SizedBox(height: 20),
                if (agencyData != null)
                  Chip(
                    label: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ListTile(
                          leading: const Icon(Icons.support_agent_rounded),
                          title: Text(agencyData?.name ?? 'Agency Name'),
                          subtitle: Text(agencyData?.id ?? 'Agency Id'),
                        ),
                        LoadingElevatedButton(
                          icon: const Icon(Icons.emoji_people_rounded),
                          label: const Text('Join Agency'),
                          onPressed: _joinAgency,
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _searchAgency() async {
    if (_textController.text.isEmpty) {
      showMsg(context, "Please enter agency id");
      return;
    }
    try {
      agencyData = await getAgencyData(_textController.text);
      setState(() {
        agencyData = agencyData;
      });
    } catch (e) {
      if (context.mounted) {
        showMsg(context, e.toString());
      }
    }
  }

  Future<void> _joinAgency() async {
    if (agencyData == null) {
      showMsg(context, "Agency Doesn't Exist");
      return;
    }
    try {
      await joinAgency(agencyData!.id);
      if (context.mounted) {
        showMsg(context, "Joined Agency");
        Navigator.of(context).pop();
      }
    } catch (e) {
      if (context.mounted) {
        showMsg(context, e.toString());
      }
    }
  }
}

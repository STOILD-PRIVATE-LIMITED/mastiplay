import 'package:flutter/material.dart';
import 'package:spinner_try/shivanshu/models/agent/agent.dart';
import 'package:spinner_try/shivanshu/models/globals.dart';
import 'package:spinner_try/shivanshu/utils.dart';
import 'package:spinner_try/shivanshu/utils/loading_icon_button.dart';
import 'package:spinner_try/shivanshu/utils/loading_widget.dart';
import 'package:spinner_try/shivanshu/utils/profile_image.dart';
import 'package:spinner_try/shivanshu/utils/select_one.dart';
import 'package:spinner_try/user_model.dart';

class TransferMethod extends StatefulWidget {
  final double height;
  final double width;
  const TransferMethod({super.key, required this.height, required this.width});

  @override
  State<TransferMethod> createState() => _TransferMethodState();
}

class _TransferMethodState extends State<TransferMethod> {
  TextEditingController userId = TextEditingController();
  TextEditingController amount = TextEditingController();

  UserModel? userData;

  bool _searchingUser = false;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SelectOne(
            selectedOption: "User",
            allOptions: const {
              "User",
              "Coinseller",
              "NOBEL",
            },
            title: "Sales method",
            subtitle: "Your Method of transfering diamonds",
            onChange: (chosenOption) {
              return chosenOption == "User";
            },
          ),
          // const Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceAround,
          //   children: [
          //     Text("Sales method:"),
          //     Text("User"),
          //     Text("Coinseller"),
          //     Text("NOBEL"),
          //   ],
          // ),
          SizedBox(
            height: widget.height / 30,
          ),
          TextField(
            keyboardType: TextInputType.number,
            controller: userId,
            onSubmitted: (value) => _searchUser(),
            decoration: InputDecoration(
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(100)),
              ),
              labelText: 'Enter User ID',
              suffixIcon: LoadingIconButton(
                loading: _searchingUser ? true : null,
                onPressed: _searchUser,
                icon: const Icon(Icons.search),
              ),
            ),
          ),
          SizedBox(
            height: widget.height / 30,
          ),
          TextField(
            keyboardType: TextInputType.number,
            controller: amount,
            onChanged: (value) {
              setState(() {});
            },
            decoration: InputDecoration(
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(100)),
              labelText: 'Enter Amount',
              hintText: '1000',
            ),
          ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: [
          //     Text(
          //         "Will Receive diamond: ${(int.tryParse(amount.text) ?? 0) * 0.68}"),
          //     const Icon(
          //       Icons.diamond,
          //       color: Colors.pink,
          //     )
          //   ],
          // ),
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
            SizedBox(
              height: widget.height / 60,
            ),
            Align(
              alignment: Alignment.center,
              child: LoadingWidget(
                onPressed: _submit,
                loadingWidget: Container(
                  height: widget.height / 15,
                  width: widget.width / 3,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.pink.withOpacity(0.5),
                  ),
                  child: const Center(
                    child: CircularProgressIndicatorRainbow(),
                  ),
                ),
                child: Container(
                  height: widget.height / 15,
                  width: widget.width / 3,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.pink,
                  ),
                  child: const Center(
                    child: Text(
                      "Transfer",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            )
          ],
        ],
      ),
    );
  }

  Future<void> _searchUser() async {
    userId.text = userId.text.replaceAll(' ', '').trim();
    if (userId.text.isEmpty) {
      showMsg(context, "Please enter user id");
      return;
    }
    setState(() {
      _searchingUser = true;
    });
    try {
      userData = await fetchUserWithId(userId.text);
    } catch (e) {
      if (context.mounted) {
        showMsg(context, e.toString());
      }
    }
    if (context.mounted) {
      setState(() {
        userData = userData;
        _searchingUser = false;
      });
    }
  }

  Future<void> _submit() async {
    amount.text = amount.text.replaceAll(' ', '').trim();
    if (userData == null) {
      showMsg(context, "Please search user first");
      return;
    }
    if (amount.text.isEmpty) {
      showMsg(context, "Please enter amount");
      return;
    }
    if (int.tryParse(amount.text) == null) {
      showMsg(context, "Please enter valid amount");
      return;
    }
    await transferDiamondsFromAgentToUser(
      currentUser.id!,
      userData!.id!,
      int.tryParse(amount.text) ?? 0,
    );
    if (context.mounted) {
      showMsg(context, "Diamonds transfered successfully");
    }
  }
}

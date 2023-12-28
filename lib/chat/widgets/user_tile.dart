import 'package:flutter/material.dart';
import 'package:spinner_try/user_model.dart';

class UserTile extends StatelessWidget {
  final String email;
  final void Function(UserModel user) removeUser;
  const UserTile({
    super.key,
    required this.email,
    required this.removeUser,
  });

  @override
  Widget build(BuildContext context) {
    UserModel user = UserModel(email: email);
    TextStyle style = Theme.of(context).textTheme.bodySmall!;
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            FutureBuilder(
              future: fetchUserWithEmail(email),
              builder: (ctx, snapshot) {
                if (snapshot.hasData) {
                  user = snapshot.data!;
                }
                return Text(
                  user.name.isEmpty ? email : user.name,
                  style: style,
                );
              },
            ),
            IconButton(
              padding: EdgeInsets.zero,
              iconSize: 20,
              visualDensity: VisualDensity.compact,
              onPressed: () => removeUser(user),
              icon: const Icon(
                Icons.close_rounded,
              ),
            )
          ],
        ),
      ),
    );
  }
}

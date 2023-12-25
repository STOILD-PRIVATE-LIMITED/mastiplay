import 'package:flutter/material.dart';
import 'package:spinner_try/user_model.dart';

class ProfileImage extends StatefulWidget {
  final void Function(UserModel user)? onTap;
  final UserModel user;
  const ProfileImage({super.key, this.onTap, required this.user});

  @override
  State<ProfileImage> createState() => _ProfileImageState();
}

class _ProfileImageState extends State<ProfileImage> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Stack(
        fit: StackFit.passthrough,
        alignment: Alignment.center,
        children: [
          Positioned(
            top: 240 / 1080 * constraints.maxHeight,
            bottom: 240 / 1080 * constraints.maxHeight,
            child: Container(
              height: 600 / 1080 * constraints.maxHeight,
              decoration: const BoxDecoration(shape: BoxShape.circle),
              clipBehavior: Clip.hardEdge,
              child: widget.user.photo.isNotEmpty
                  ? Image.network(
                      widget.user.photo,
                      fit: BoxFit.cover,
                    )
                  : Image.asset(
                      'assets/${widget.user.gender == 0 ? 'male' : 'female'}.jpg',
                      fit: BoxFit.cover,
                    ),
            ),
          ),
          Positioned.fill(
            child: Image.asset(
              'assets/Frame ${widget.user.frame}.png',
              fit: BoxFit.cover,
              height: constraints.maxHeight,
            ),
          ),
        ],
      );
    });
  }
}

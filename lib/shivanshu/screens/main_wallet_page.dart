import 'package:flutter/material.dart';
import 'package:spinner_try/shivanshu/utils.dart';

class MainWalletPage extends StatelessWidget {
  const MainWalletPage(this.onPressed, {super.key});

  final void Function(int index) onPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _tile(
          assetImg: 'assets/coin_to_diamond.png',
          onPressed: () {
            onPressed(0);
          },
          title: "Exchange",
        ),
        _tile(
          assetImg: 'assets/banker.png',
          onPressed: () {
            onPressed(1);
          },
          title: "Agency Transfer",
        ),
        _tile(
          assetImg: 'assets/dollar.png',
          onPressed: () {
            onPressed(2);
          },
          title: "Cashout",
        ),
      ],
    );
  }
}

class _tile extends StatelessWidget {
  final String assetImg;
  final String title;
  final void Function() onPressed;

  const _tile(
      {required this.assetImg, required this.title, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5),
      margin: const EdgeInsets.symmetric(vertical: 7, horizontal: 2),
      decoration: BoxDecoration(
        color: colorScheme(context).onPrimary,
        boxShadow: const [
          BoxShadow(
            color: Colors.black38,
            blurRadius: 2.0,
          ),
        ],
      ),
      child: ListTile(
        onTap: onPressed,
        contentPadding: const EdgeInsets.only(left: 15, right: 2),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(2),
          // side: const BorderSide(
          //     // width: 1,
          //     // color: Color.fromARGB(255, 200, 200, 200),
          //     ),
        ),
        leading: Image.asset(assetImg),
        // titleAlignment: ListTileTitleAlignment.,
        title: Text(
          title,
          style: textTheme(context).bodyMedium!.copyWith(
                fontWeight: FontWeight.bold,
              ),
          textAlign: TextAlign.center,
        ),
        trailing: const Icon(
          Icons.keyboard_arrow_right_rounded,
        ),
      ),
    );
  }
}

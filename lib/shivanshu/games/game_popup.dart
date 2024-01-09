import 'package:flutter/material.dart';

late OverlayEntry entry;

Future<dynamic> showGamePopup(BuildContext context, Widget gameWidget) async {
  entry = OverlayEntry(
    builder: (context) {
      return gameWidget;
    },
  );
  Overlay.of(context).insert(entry);
  // myOverlayEntry.remove();
}

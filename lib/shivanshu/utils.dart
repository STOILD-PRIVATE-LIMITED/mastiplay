import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:intl/intl.dart';

Widget shaderWidget(
  BuildContext context, {
  required Widget child,
  TextStyle? style,
  colors = const [
    Colors.deepPurpleAccent,
    Colors.blue,
  ],
}) {
  return ShaderMask(
    blendMode: BlendMode.srcATop,
    shaderCallback: (rect) {
      return LinearGradient(colors: colors).createShader(rect);
    },
    child: child,
  );
}

/// shows a text in word art, you can customize the colors in it
/// and the text style as well
Widget shaderText(
  BuildContext context, {
  required String title,
  TextStyle? style,
  colors = const [Colors.deepPurpleAccent, Colors.blue],
}) {
  return ShaderMask(
    blendMode: BlendMode.srcATop,
    shaderCallback: (rect) {
      return LinearGradient(colors: colors).createShader(rect);
    },
    child: Text(
      title,
      style: style,
    ),
  );
}

/// shows a quick message with a cross button
void showMsg(BuildContext context, Object message, {Icon? icon}) {
  showSnackBar(
    context,
    SnackBar(content: Text(message.toString()), showCloseIcon: true),
  );
}

/// clears current snackbar and shows a new one
showSnackBar(BuildContext context, SnackBar snackBar) {
  ScaffoldMessenger.of(context).clearSnackBars();
  return ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

Color colorPickerAttendance(String resp) {
  switch (resp) {
    case 'present':
      return Colors.greenAccent;

    case 'absent':
      return Colors.redAccent;

    case 'onInternship':
      return Colors.orangeAccent;

    case 'onLeave':
      return Colors.cyanAccent;

    default:
      return Colors.yellowAccent;
  }
}

/// Glass Widget
class GlassWidget extends StatelessWidget {
  final double radius;
  final Widget child;
  final double blur;
  const GlassWidget(
      {super.key, this.radius = 0, required this.child, this.blur = 15});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
        child: child,
      ),
    );
  }
}

List<Color> colorList = const [
  Colors.pinkAccent,
  Colors.purpleAccent,
  Colors.cyanAccent,
  Colors.greenAccent,
  Colors.orangeAccent,
  Colors.blueAccent,
  Colors.deepOrangeAccent,
  Colors.yellowAccent,
  Colors.tealAccent,
  Colors.limeAccent,
  Colors.lightGreenAccent,
  Colors.indigoAccent,
  Colors.deepPurpleAccent,
  Colors.amberAccent
];

Future<dynamic> navigatorPush(BuildContext context, Widget page) async {
  return await Navigator.of(context).push(MaterialPageRoute(
    builder: (context) => page,
  ));
}

ColorScheme colorScheme(BuildContext context) {
  return Theme.of(context).colorScheme;
}

TextTheme textTheme(BuildContext context) {
  return Theme.of(context).textTheme;
}

class MyRow extends StatelessWidget {
  final MainAxisSize mainAxisSize;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;
  final List<Widget> children;
  const MyRow({
    super.key,
    this.mainAxisSize = MainAxisSize.min,
    this.mainAxisAlignment = MainAxisAlignment.start,
    required this.children,
    this.crossAxisAlignment = CrossAxisAlignment.center,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: mainAxisSize,
      mainAxisAlignment: mainAxisAlignment,
      crossAxisAlignment: crossAxisAlignment,
      children: children,
    );
  }
}

class MyColumn extends StatelessWidget {
  final MainAxisSize mainAxisSize;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;
  final List<Widget> children;
  const MyColumn({
    super.key,
    this.mainAxisSize = MainAxisSize.min,
    this.mainAxisAlignment = MainAxisAlignment.center,
    required this.children,
    this.crossAxisAlignment = CrossAxisAlignment.center,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: crossAxisAlignment,
      mainAxisSize: mainAxisSize,
      mainAxisAlignment: mainAxisAlignment,
      children: children,
    );
  }
}

Future<String?> askUser(
  context,
  String msg, {
  String? description,
  bool yes = false,
  bool ok = false,
  bool no = false,
  bool cancel = false,
  Map<String, Icon>? custom,
}) async {
  List<Widget> buttons = [
    if (ok == true)
      TextButton.icon(
        label: const Text("OK"),
        onPressed: () {
          Navigator.of(context).pop("ok");
        },
        icon: const Icon(Icons.check_rounded),
      ),
    if (yes == true)
      TextButton.icon(
        label: const Text("Yes"),
        onPressed: () {
          Navigator.of(context).pop("yes");
        },
        icon: const Icon(Icons.check_rounded),
      ),
    if (no == true)
      TextButton.icon(
        label: const Text("No"),
        onPressed: () {
          Navigator.of(context).pop("no");
        },
        icon: const Icon(Icons.close_rounded),
      ),
    if (cancel == true)
      TextButton.icon(
        label: const Text("Cancel"),
        onPressed: () {
          Navigator.of(context).pop("cancel");
        },
        icon: const Icon(Icons.close_rounded),
      ),
    if (custom != null)
      ...custom.entries.map(
        (entry) => TextButton.icon(
          label: Text(entry.key.toPascalCase()),
          onPressed: () {
            Navigator.of(context).pop(entry.key);
          },
          icon: entry.value,
        ),
      ),
  ];
  if (buttons.isEmpty) {
    buttons.add(
      TextButton.icon(
        label: const Text("OK"),
        onPressed: () {
          Navigator.of(context).pop("ok");
        },
        icon: const Icon(Icons.check_rounded),
      ),
    );
  }
  return await Navigator.push(
    context,
    DialogRoute(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(msg),
        content: description != null ? Text(description) : null,
        actions: buttons,
        actionsAlignment: MainAxisAlignment.spaceAround,
      ),
    ),
  );
}

extension IntExtension on int {
  double get dp {
    return toDouble() *
        MediaQuery.of(navigatorKey.currentContext!).devicePixelRatio;
  }

  double get sp {
    return toDouble() *
        (MediaQuery.of(navigatorKey.currentContext!).textScaleFactor);
  }
}

extension DoubleExtension on double {
  double get dp {
    return toDouble() *
        MediaQuery.of(navigatorKey.currentContext!).devicePixelRatio;
  }

  double get sp {
    return toDouble() *
        (MediaQuery.of(navigatorKey.currentContext!).textScaleFactor);
  }
}

double get height => MediaQuery.of(navigatorKey.currentContext!).size.height;
double get width => MediaQuery.of(navigatorKey.currentContext!).size.width;

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

/// A widget which is primarily used to show a [CircularProgressIndicator]
/// in a sizedbox
SizedBox circularProgressIndicator({
  double? height = 16,
  double? width = 16,
}) {
  final widget = Animate(
    onComplete: (controller) {
      controller.repeat();
    },
  ).custom(
      duration: const Duration(seconds: 2), // Adjust the duration as needed
      curve: Curves.linear,
      builder: (context, value, child) {
        final colors = <Color>[
          Colors.blue,
          Colors.red,
          Colors.orange,
          Colors.yellow,
          Colors.green,
          Colors.cyan,
          Colors.indigo,
          Colors.purple,
        ];

        return CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(
            colors[(value * colors.length).floor() % colors.length],
          ),
        );
      });
  widget.onComplete;
  return SizedBox(
    height: height,
    width: width,
    child: widget,
  );
}

/// contains validating functions for input text fields
class Validate {
  static String? email(String? email, {bool required = true}) {
    if (email != null) email = email.trim();
    if (email == null || email.isEmpty) {
      return required ? "Email is required" : null;
    }
    if (!(email.contains('@') && email.contains('.'))) {
      return "Enter a valid email";
    }
    return null;
  }

  static String? name(String? name, {bool required = true}) {
    if (name != null) name = name.trim();
    if (name == null || name.isEmpty) {
      return required ? "Username is required" : null;
    }
    for (final ch in name.characters) {
      if (!(ch.compareTo('a') >= 0 && ch.compareTo('z') <= 0) &&
          !(ch.compareTo('A') >= 0 && ch.compareTo('Z') <= 0) &&
          ch.compareTo(' ') != 0) {
        return "Enter a valid name";
      }
    }
    return null;
  }

  static String? text(String? txt, {bool required = true}) {
    if (txt != null) txt = txt.trim();
    if (txt == null || txt.isEmpty) {
      return required ? "This is required" : null;
    }
    return null;
  }

  static String? phone(String? phoneNumber, {bool required = true}) {
    if (phoneNumber != null) {
      String newPhoneNumber = "";
      for (final ch in phoneNumber.characters) {
        if (ch.compareTo(' ') == 0) continue;
        newPhoneNumber += ch;
      }
      phoneNumber = newPhoneNumber;
    }
    if (phoneNumber == null || phoneNumber.isEmpty) {
      return required ? "Phone Number is required" : null;
    }
    bool firstCharacter = true;
    for (final ch in phoneNumber.characters) {
      if (firstCharacter && ch.compareTo('+') == 0) {
      } else if (!(ch.compareTo('0') >= 0 && ch.compareTo('9') <= 0)) {
        return "Enter a valid number";
      }
      firstCharacter = false;
    }
    return null;
  }

  static String? integer(String? number, {bool required = true}) {
    if (number == null || number.isEmpty) {
      return required ? "This is required" : null;
    }
    for (final ch in number.characters) {
      if (!(ch.compareTo('0') >= 0 && ch.compareTo('9') <= 0)) {
        return "Enter a valid integer";
      }
    }
    return null;
  }

  static String? password(String? pwd, {bool required = true}) {
    if (pwd == null || pwd.isEmpty) {
      return required ? "Password is required" : null;
    }
    bool small = false, big = false, num = false, special = false;
    if (pwd.length < 8) return "Password is too short";
    for (final ch in pwd.characters) {
      if (ch.compareTo('a') >= 0 && ch.compareTo('z') <= 0) {
        small = true;
      } else if (ch.compareTo('A') >= 0 && ch.compareTo('Z') <= 0) {
        big = true;
      } else if (ch.compareTo('0') >= 0 && ch.compareTo('9') <= 0) {
        num = true;
      } else {
        special = true;
      }
    }
    if (!small) {
      return "Password must contain a small letter";
    }
    if (!big) {
      return "Password must contain a capital letter";
    }
    if (!num) {
      return "Password must contain a number";
    }
    if (!special) {
      return "Password must contain a special character";
    }
    return null;
  }
}

List<Color> generateGradientColors(int count, List<Color> colors) {
  List<Color> gradientColors = [];

  for (int i = 0; i < count; i++) {
    double ratio = i / (count - 1);
    Color color = interpolateColors(ratio, colors);
    gradientColors.add(color);
  }

  return gradientColors;
}

Color interpolateColors(double ratio, List<Color> colors) {
  if (ratio <= 0) {
    return colors.first;
  } else if (ratio >= 1) {
    return colors.last;
  }

  double segment = 1 / (colors.length - 1);
  int i = (ratio / segment).floor();
  double localRatio = (ratio - i * segment) / segment;

  return Color.lerp(colors[i], colors[i + 1], localRatio)!;
}

extension StringExtensions on String {
  String toPascalCase() {
    if (isEmpty) return this;

    // Split the string by whitespace and capitalize the first letter of each word
    return split(' ').map((word) {
      if (word.isNotEmpty) {
        return '${word[0].toUpperCase()}${word.substring(1)}';
      }
      return '';
    }).join(' ');
  }
}

Future<void> shareRoomLink(String roomID) async {
  return shareLink(
    "https://mastiplay.com/room/?id=$roomID",
    true
        ? roomID
        : "Join my room at Masti Play. Click on the below link to join. Or enter room id: $roomID manually",
  );
}

Future<void> shareLink(String link, [String? msg]) async {
  msg ??= "Masti Play.";
  if (true) {
    await FlutterShare.share(title: 'Share App', text: msg);
  } else {
    await FlutterShare.share(title: 'Share App', text: msg, linkUrl: link);
  }
}

/// A function to show date in this format
String ddmmyyyy(DateTime dateTime) {
  return DateFormat.yMMMMd().format(dateTime);
}

/// A function to show time in a certain format
String timeFrom(DateTime dateTime) {
  return "${dateTime.hour > 12 ? dateTime.hour - 12 : dateTime.hour}:${dateTime.minute.toString().padLeft(2, '0')} ${dateTime.hour < 12 ? 'am' : 'pm'}";
}

extension DateTimeExtensions on DateTime {
  int toJson() {
    return millisecondsSinceEpoch ~/ 1000;
  }
}

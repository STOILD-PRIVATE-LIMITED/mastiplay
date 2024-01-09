import 'package:flutter/material.dart';

// ignore: must_be_immutable
class AnotherView extends StatefulWidget {
  final List<Widget> items;
  final List<Widget> selectedItems;
  final void Function(int index) onTap;
  final Widget separation;
  int defaultSelected;
  final bool underline;
  AnotherView({
    super.key,
    required this.items,
    required this.selectedItems,
    this.defaultSelected = 0,
    required this.onTap,
    this.underline = true,
    this.separation = const SizedBox(width: 5),
  });

  @override
  State<AnotherView> createState() => _AnotherViewState();
}

class _AnotherViewState extends State<AnotherView> {
  late int selected;
  @override
  void initState() {
    super.initState();
    selected = widget.defaultSelected;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        for (int i = 0; i < widget.items.length; ++i)
          Row(
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  InkWell(
                    child: i == selected
                        ? widget.selectedItems[i]
                        : widget.items[i],
                    onTap: () {
                      setState(() {
                        selected = i;
                      });
                      widget.onTap(i);
                    },
                  ),
                ],
              ),
              widget.separation,
            ],
          ),
      ],
    );
  }
}

import 'package:flutter/material.dart';

class TabView extends StatefulWidget {
  final List<Widget> items;
  final List<Widget> selectedItems;
  final void Function(int index) onTap;
  final Widget separation;
  int defaultSelected;
  final bool underline;
  TabView({
    super.key,
    required this.items,
    required this.selectedItems,
    this.defaultSelected = 0,
    required this.onTap,
    this.underline = true,
    this.separation = const SizedBox(width: 5),
  });

  @override
  State<TabView> createState() => _TabViewState();
}

class _TabViewState extends State<TabView> {
  late int selected;
  @override
  void initState() {
    super.initState();
    selected = widget.defaultSelected;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        for (int i = 0; i < widget.items.length; ++i)
          Row(
            mainAxisSize: MainAxisSize.min,
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
                  const SizedBox(height: 2),
                  if (i == selected && widget.underline)
                    Image.asset('assets/underline.png'),
                ],
              ),
              widget.separation,
            ],
          ),
      ],
    );
  }
}

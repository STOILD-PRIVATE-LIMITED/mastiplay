import 'dart:math';

import 'package:flutter/material.dart';

class HighlightWheel extends StatefulWidget {
  HighlightWheel({
    super.key,
    this.radius = 100,
    this.childHeight = 100,
    this.childWidth = 100,
    this.duration = 5,
    this.minRotations = 2,
    this.curve = Curves.easeInOut,
    required this.items,
    required this.highlightedItemBuilder,
    required this.onComplete,
  });
  final double radius;
  final double minRotations;
  final double childHeight;
  final double childWidth;
  final int duration;
  final Curve curve;
  final Widget Function(int index) highlightedItemBuilder;
  final void Function(int index) onComplete;
  final List<Widget> items;
  final random = Random();

  @override
  State<HighlightWheel> createState() => _HighlightWheelState();
}

class _HighlightWheelState extends State<HighlightWheel>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  Widget? highlightedWidget;
  int? selectedIndex;
  int? oldSelectedIndex;

  @override
  void initState() {
    super.initState();
    int n = widget.items.length;
    double theta = 2 * pi / n;

    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: widget.duration),
    );

    _controller.addListener(() {
      setState(() {
        double v = _animation.value * 2 * pi;
        selectedIndex = (v % (2 * pi)) ~/ theta;
        if (oldSelectedIndex != selectedIndex) {
          highlightedWidget = widget.highlightedItemBuilder(selectedIndex!);
          oldSelectedIndex = selectedIndex;
        }
      });
    });

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        double v = _animation.value * 2 * pi;
        selectedIndex = (v % (2 * pi)) ~/ theta;
        widget.onComplete(selectedIndex!);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    int i = 0;
    int n = widget.items.length;
    double theta = 2 * pi / n;
    return SizedBox(
      width: widget.radius * 2,
      height: widget.radius * 2,
      child: Stack(
        clipBehavior: Clip.none,
        fit: StackFit.loose,
        alignment: Alignment.center,
        children: [
          Image.asset('assets/games/animals/bg_circle.png'),
          ...widget.items.map(
            (e) {
              i += 1;
              return Positioned(
                top: (widget.radius - widget.childHeight / 2) *
                        sin(theta * (i - 1) - pi / 2) +
                    widget.radius -
                    widget.childHeight / 2,
                left: (widget.radius - widget.childWidth / 2) *
                        cos(theta * (i - 1) - pi / 2) +
                    widget.radius -
                    widget.childWidth / 2,
                child: SizedBox(
                  width: widget.childWidth,
                  height: widget.childHeight,
                  child: selectedIndex == i - 1 ? highlightedWidget : e,
                ),
              );
            },
          ),
          // Timer(
          //   startTime: DateTime.now(),
          //   style: const TextStyle(
          //     color: Colors.white,
          //     fontSize: 30,
          //   ),
          // ),
          Positioned(
            // left: widget.radius - 20,
            // top: widget.radius - 20,
            child: IconButton(
              onPressed: () {
                _animation = Tween<double>(
                  begin: 0,
                  end: widget.random.nextDouble() * pi * 2 +
                      2 * pi * widget.minRotations,
                ).animate(
                  CurvedAnimation(
                    parent: _controller,
                    curve: Curves.easeInOut,
                  ),
                );
                _controller.reset();
                _controller.forward();
              },
              color: Colors.white,
              icon: const Icon(Icons.rotate_right),
            ),
          ),
        ],
      ),
    );
  }
}

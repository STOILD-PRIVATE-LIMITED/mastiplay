import 'dart:math';

import 'package:flutter/material.dart';

class SpinWheel extends StatefulWidget {
  const SpinWheel({
    super.key,
    this.radius = 100,
    this.childHeight = 30,
    this.childWidth = 30,
    this.duration = 5,
    this.arrowHeight = 20,
    this.curve = Curves.easeInOut,
    required this.items,
  });
  final double radius;
  final double arrowHeight;
  final double childHeight;
  final double childWidth;
  final int duration;
  final Curve curve;
  final List<Widget> items;

  @override
  State<SpinWheel> createState() => _SpinWheelState();
}

class _SpinWheelState extends State<SpinWheel> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: widget.duration),
    );

    _animation = Tween<double>(
      begin: 0,
      end: Random().nextDouble() * 6 * pi,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: widget.curve,
      ),
    )..addListener(() {});
  }

  @override
  Widget build(BuildContext context) {
    int i = 0;
    int n = widget.items.length;
    double theta = 2 * pi / n;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            RotationTransition(
              turns: _animation,
              child: Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.center,
                children: [
                  Container(
                    width: widget.radius * 2,
                    height: widget.radius * 2,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      // color: Theme.of(context).colorScheme.primary,
                    ),
                    child: CustomPaint(
                      painter: _SlicePainter(sliceCount: n),
                    ),
                  ),
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
                        child: Transform.rotate(
                          angle: theta * (i - 1),
                          child: SizedBox(
                            width: widget.childWidth,
                            height: widget.childHeight,
                            child: e,
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            Positioned(
              left: widget.radius,
              // left: 0,
              top: 0,
              child: CustomPaint(
                painter: _Arrow(widget.arrowHeight),
              ),
            ),
          ],
        ),
        ElevatedButton.icon(
          onPressed: () {
            _controller.reset();
            _controller.forward();
          },
          icon: const Icon(Icons.rotate_left),
          label: const Text('Spin the wheel!'),
        ),
      ],
    );
  }
}

class _Arrow extends CustomPainter {
  final double height;

  const _Arrow(this.height);

  @override
  void paint(Canvas canvas, Size size) {
    final double radius = height;
    final double centerX = size.width / 2;
    final double centerY = size.height / 2;

    const double startAngle = -pi / 10 - pi / 2;
    const double endAngle = pi / 10 - pi / 2;
    final Paint paint = Paint()..color = Colors.black;
    final Path path = Path()
      ..moveTo(centerX, centerY)
      ..lineTo(centerX + radius * cos(startAngle),
          centerY + radius * sin(startAngle))
      ..arcTo(
        Rect.fromCircle(center: Offset(centerX, centerY), radius: radius),
        startAngle,
        endAngle - startAngle,
        false,
      )
      ..lineTo(centerX, centerY);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class _SlicePainter extends CustomPainter {
  final int sliceCount;

  _SlicePainter({required this.sliceCount});

  @override
  void paint(Canvas canvas, Size size) {
    final double radius = size.width / 2;
    final double centerX = size.width / 2;
    final double centerY = size.height / 2;
    Random random = Random(20);
    double theta = 2 * pi / sliceCount;

    for (int i = 0; i < sliceCount; i++) {
      final Paint paint = Paint()
        ..color = Color.fromARGB(
          255,
          random.nextInt(255),
          random.nextInt(255),
          random.nextInt(255),
        );
      final double startAngle = (theta) * i - theta / 2 - pi / 2;
      final double endAngle = (theta) * (i + 1) - theta / 2 - pi / 2;

      final Path path = Path()
        ..moveTo(centerX, centerY)
        ..lineTo(centerX + radius * cos(startAngle),
            centerY + radius * sin(startAngle))
        ..arcTo(
          Rect.fromCircle(center: Offset(centerX, centerY), radius: radius),
          startAngle,
          endAngle - startAngle,
          false,
        )
        ..lineTo(centerX, centerY);

      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

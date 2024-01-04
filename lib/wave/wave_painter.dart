import 'dart:async';
import 'package:flutter/material.dart';

class EmptyEffect extends StatefulWidget {
  Widget child;
  double outerMostCircleStartRadius;
  double outerMostCircleEndRadius;
  double startOpacity;
  Duration animationTime;
  int numberOfCircles;
  double borderWidth;
  Color borderColor;
  double gap;
  Duration delay;

  EmptyEffect({
    super.key,
    required this.child,
    required this.borderColor,
    required this.outerMostCircleEndRadius,
    required this.outerMostCircleStartRadius,
    this.startOpacity = .1,
    this.numberOfCircles = 2,
    this.delay = const Duration(seconds: 2),
    this.animationTime = const Duration(seconds: 1),
    this.borderWidth = 8.0,
    this.gap = 15.0,
  }) {
    assert(numberOfCircles > 0);
    assert(gap > 0);
    assert(outerMostCircleStartRadius > 0);
    assert(outerMostCircleEndRadius > 0);
    assert(startOpacity > 0);
    assert(delay >= animationTime);

    child = child;
    outerMostCircleStartRadius = outerMostCircleStartRadius;
    outerMostCircleEndRadius = outerMostCircleEndRadius;
    startOpacity = startOpacity;
    animationTime = animationTime;
    numberOfCircles = numberOfCircles;
    borderWidth = borderWidth;
    borderColor = borderColor;
    gap = gap;
    delay = delay;
  }
  @override
  _EmptyEffectState createState() => _EmptyEffectState();
}

class _EmptyEffectState extends State<EmptyEffect>
    with TickerProviderStateMixin {
  AnimationController? _radiusOpacityController;
  Animation? _radiusAnimation;
  Animation? _opacityAnimation;

  @override
  void initState() {
    super.initState();

    _radiusOpacityController = AnimationController(
      vsync: this,
      duration: widget.animationTime,
    )..addListener(() {
        setState(() {});
      });

    Timer.periodic(widget.delay, (_) {
      _radiusOpacityController?.reset();
      _radiusOpacityController?.forward();
    });

    _radiusAnimation = Tween(
            begin: widget.outerMostCircleStartRadius,
            end: widget.outerMostCircleEndRadius)
        .animate(
      CurvedAnimation(
        parent: _radiusOpacityController!,
        curve: Curves.linear,
      ),
    );

    _opacityAnimation = Tween(begin: widget.startOpacity, end: 0.0).animate(
        CurvedAnimation(
            parent: _radiusOpacityController!, curve: Curves.linear));
  }

  @override
  void dispose() {
    super.dispose();
    _radiusOpacityController?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Opacity(
          opacity: _opacityAnimation!.value,
          child: CustomPaint(
            painter: _CustomPainter(
              numberOfCircles: widget.numberOfCircles,
              borderWidth: widget.borderWidth,
              borderColor: widget.borderColor,
              gap: widget.gap,
              outermostCircleRadius: _radiusAnimation!.value,
            ),
          ),
        ),
        widget.child,
      ],
    );
  }
}

class _CustomPainter extends CustomPainter {
  int? _numberOfCircles;
  double? _borderWidth;
  Color? _borderColor;
  double? _gap;
  double? _outermostCircleRadius;

  _CustomPainter({
    required int numberOfCircles,
    required double borderWidth,
    required Color borderColor,
    required double gap,
    required double outermostCircleRadius,
  }) {
    _numberOfCircles = numberOfCircles;
    _borderWidth = borderWidth;
    _borderColor = borderColor;
    _outermostCircleRadius = outermostCircleRadius;
    _gap = gap;
  }

  @override
  void paint(Canvas canvas, Size size) {
    final borderPaint = Paint()
      ..color = _borderColor!
      ..strokeWidth = _borderWidth!
      ..style = PaintingStyle.stroke;

    var center = Offset(size.width / 2, size.height / 2);

    //We draw from outermost to innermost possible circle
    int circleNum = 0;
    while (circleNum != _numberOfCircles &&
        (_outermostCircleRadius! - _gap! * circleNum) > 0) {
      canvas.drawCircle(
          center, _outermostCircleRadius! - _gap! * circleNum, borderPaint);
      circleNum += 1;
    }
  }

  @override
  bool shouldRepaint(_CustomPainter oldDelegate) {
    if (oldDelegate._outermostCircleRadius == _outermostCircleRadius) {
      return false;
    }
    return true;
  }
}
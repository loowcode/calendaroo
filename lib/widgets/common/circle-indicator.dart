import 'dart:math';

import 'package:flutter/material.dart';
import 'package:vector_math/vector_math.dart' show radians;

class CircleIndicator extends StatefulWidget {
  @override
  _CircleIndicatorState createState() => _CircleIndicatorState();
}

class _CircleIndicatorState extends State<CircleIndicator> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      height: 150,
      child: CustomPaint(
        size: Size(150, 150),
        painter: CircleIndicatorPainter(10),
      ),
    );
  }
}

class CircleIndicatorPainter extends CustomPainter {
  final double _strokeWidth;

  CircleIndicatorPainter(this._strokeWidth);

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromCircle(
      center: Offset(size.width / 2, size.height / 2),
      radius: min(size.width, size.height) - _strokeWidth,
    );

    var startAngle = _clampAngle(0.0 - _strokeWidth / 2);
    var endAngle = _clampAngle(45.0 + _strokeWidth / 2);

    // Swap angles if end angle is less than start angle
    if (endAngle < startAngle) {
        /*var tmp = startAngle;
        startAngle = endAngle;
        endAngle = tmp;*/
        endAngle += 360;
    }

    print(startAngle);
    print(endAngle);

    final gradient = SweepGradient(
        colors: [
          Colors.lime,
          Colors.cyan,
        ],
        startAngle: radians(15), //radians(_clampAngle(startAngle)),
        endAngle: radians(350), //radians(_clampAngle(endAngle)),
        );

    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = _strokeWidth
      ..strokeCap = StrokeCap.round
      ..shader = gradient.createShader(rect);

    canvas.drawArc(Rect.fromLTWH(0, 0, size.width, size.height), 0.0,
        radians(45.0), false, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }

  double _clampAngle(double angle) {
    var clampedAngle = angle % 360;
    return clampedAngle < 0 ? (360 - clampedAngle) : clampedAngle;
  }
}

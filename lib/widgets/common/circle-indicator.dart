import 'dart:math';

import 'package:calendaroo/colors.dart';
import 'package:flutter/material.dart';
import 'package:vector_math/vector_math.dart' show radians;

class CircleIndicator extends StatefulWidget {
  final double width;
  final double height;
  final List<CircleIndicatorItem> items;
  final double strokeWidth;

  CircleIndicator({
    this.items,
    this.width,
    this.height,
    this.strokeWidth = 10.0,
  });

  @override
  _CircleIndicatorState createState() => _CircleIndicatorState();
}

class _CircleIndicatorState extends State<CircleIndicator> {
  @override
  Widget build(BuildContext context) {
    var segments = [
          CircleIndicatorSegment(
              width: widget.width,
              height: widget.height,
              startAngle: 0,
              endAngle: 380,
              startColor: transparentGrey,
              endColor: transparentGrey,
              strokeWidth: widget.strokeWidth)
        ] +
        widget.items
            .map((element) => CircleIndicatorSegment(
                width: widget.width,
                height: widget.height,
                startAngle: element.startAngle,
                endAngle: element.endAngle + 1,
                startColor: element.startColor,
                endColor: element.endColor,
                strokeWidth: widget.strokeWidth))
            .toList();

    return RotatedBox(
      quarterTurns: 3,
      child: Center(
        child: Stack(
          children: segments,
        ),
      ),
    );
  }
}

class CircleIndicatorItem {
  final double startAngle;
  final double endAngle;
  final Color startColor;
  final Color endColor;

  CircleIndicatorItem({
    this.startAngle,
    this.endAngle,
    this.startColor,
    this.endColor,
  });
}

class CircleIndicatorSegment extends StatefulWidget {
  final double width;
  final double height;
  final double startAngle;
  final double endAngle;
  final Color startColor;
  final Color endColor;
  final double strokeWidth;

  CircleIndicatorSegment(
      {this.width,
      this.height,
      this.startAngle,
      this.endAngle,
      this.startColor,
      this.endColor,
      this.strokeWidth = 10.0});

  @override
  _CircleIndicatorSegmentState createState() => _CircleIndicatorSegmentState();
}

class _CircleIndicatorSegmentState extends State<CircleIndicatorSegment> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 160,
        width: 160,
        child: CustomPaint(
          size: Size(widget.width - widget.strokeWidth,
              widget.height - widget.strokeWidth),
          painter: CircleIndicatorPainter(
            startAngle: widget.startAngle,
            endAngle: widget.endAngle,
            startColor: widget.startColor,
            endColor: widget.endColor,
            strokeWidth: widget.strokeWidth,
          ),
        ),
      ),
    );
  }
}

class CircleIndicatorPainter extends CustomPainter {
  final double strokeWidth;
  final double startAngle;
  final double endAngle;
  final Color startColor;
  final Color endColor;

  CircleIndicatorPainter(
      {double startAngle,
      double endAngle,
      this.startColor,
      this.endColor,
      this.strokeWidth})
      : startAngle = radians(startAngle),
        endAngle = radians(endAngle);

  @override
  void paint(Canvas canvas, Size size) {
    final radius = min(size.width, size.height) / 2;

    final rect = Rect.fromCircle(
      center: Offset(size.width / 2, size.height / 2),
      radius: radius,
    );

    final gradient = SweepGradient(
      colors: [
        startColor,
        endColor,
      ],
      startAngle: startAngle,
      endAngle: endAngle,
      tileMode: TileMode.repeated,
    );

    var capAngle = (strokeWidth / 2) / radius;
    var realStartAngle = startAngle + capAngle;
    var sweepAngle = endAngle - startAngle - (2 * capAngle);

    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..shader = gradient.createShader(rect);

    canvas.drawArc(Rect.fromLTWH(0, 0, size.width, size.height), realStartAngle,
        sweepAngle, false, paint);
  }

  @override
  bool shouldRepaint(CircleIndicatorPainter oldDelegate) {
    return oldDelegate.strokeWidth != strokeWidth ||
        oldDelegate.startAngle != startAngle ||
        oldDelegate.endAngle != endAngle ||
        oldDelegate.startColor != startColor ||
        oldDelegate.endColor != endColor;
  }
}

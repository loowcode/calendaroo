import 'dart:math';

import 'package:calendaroo/model/event-instance.model.dart';
import 'package:calendaroo/widgets/common/circle-indicator.dart';
import 'package:flutter/material.dart';

class TodayCompletionCircle extends StatefulWidget {
  final List<EventInstance> events;

  TodayCompletionCircle({this.events});

  @override
  _TodayCompletionCircleState createState() => _TodayCompletionCircleState();
}

class _TodayCompletionCircleState extends State<TodayCompletionCircle> {
  @override
  Widget build(BuildContext context) {
    var nowAngleNormalized = dateToAngle(DateTime.now()) / 360;

    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: SizedBox(
        width: 150,
        height: 150,
        child: ShaderMask(
          shaderCallback: (bounds) {
            return SweepGradient(
              startAngle: -pi / 2,
              endAngle: -pi / 2 + 2 * pi,
              center: Alignment.center,
              colors: <Color>[
                Colors.grey,
                Colors.grey,
                Colors.black.withAlpha(0),
                Colors.black.withAlpha(0),
              ],
              stops: [
                0.0,
                nowAngleNormalized,
                nowAngleNormalized,
                1,
              ],
              tileMode: TileMode.repeated,
            ).createShader(bounds);
          },
          child: CircleIndicator(
            items: widget.events
                .map((event) => CircleIndicatorItem(
                      startAngle: dateToAngle(event.start),
                      endAngle: dateToAngle(event.end),
                      // TODO: colors?
                      startColor: Colors.green,
                      endColor: Colors.red,
                    ))
                .toList(),
            width: 150,
            height: 150,
            strokeWidth: 10,
          ),
          blendMode: BlendMode.srcATop,
        ),
      ),
    );
  }
}

double dateToAngle(DateTime dateTime) {
  final maxDuration = Duration(hours: 24).inMinutes;
  var duration = dateTime
      .difference(DateTime(dateTime.year, dateTime.month, dateTime.day));
  var angle = 360.0 * duration.inMinutes / maxDuration;
  return angle;
}

import 'dart:math';

import 'package:calendaroo/colors.dart';
import 'package:calendaroo/model/event-instance.model.dart';
import 'package:calendaroo/widgets/common/circle-indicator.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TodayCompletionCircle extends StatefulWidget {
  final List<EventInstance> events;

  TodayCompletionCircle({this.events});

  @override
  _TodayCompletionCircleState createState() => _TodayCompletionCircleState();
}

class _TodayCompletionCircleState extends State<TodayCompletionCircle> {
  @override
  Widget build(BuildContext context) {
    var time = DateTime.now();
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: SizedBox(
        width: 150,
        height: 150,
        child: Stack(
          children: <Widget>[
            Center(
                child: Text(
              '${DateFormat.Hm().format(time)}',
              style:
                  Theme.of(context).textTheme.subtitle1.copyWith(color: blue),
            )),
            CircleIndicator(
              items: widget.events
                  .map((event) => CircleIndicatorItem(
                        startAngle: dateToAngle(event.start),
                        endAngle: dateToAngle(event.end),
                        startColor: blueGradient[0],
                        endColor: blueGradient[1],
                      ))
                  .toList(),
              width: 150,
              height: 150,
              strokeWidth: 10,
            ),
            markerHour(),
          ],
        ),
      ),
    );
  }

  Transform markerHour() {
    var nowAngle = dateToAngle(DateTime.now());
    return Transform.rotate(
      angle: (nowAngle - 90) / 180 * pi,
      child: Padding(
        padding: const EdgeInsets.only(left: 86.0),
        child: Center(
          child: Transform.rotate(
            angle: 0 / 180 * pi,
            child: Container(
                height: 5,
                width: 30,
                decoration: BoxDecoration(
                    color: red,
                    borderRadius: BorderRadius.all(Radius.circular(20)))),
          ),
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

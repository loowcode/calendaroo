import 'package:calendaroo/widgets/common/circle-indicator.dart';
import 'package:flutter/material.dart';

class TodayCompletionCircle extends StatefulWidget {
  @override
  _TodayCompletionCircleState createState() => _TodayCompletionCircleState();
}

class _TodayCompletionCircleState extends State<TodayCompletionCircle> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: CircleIndicator(),
    );
  }
}

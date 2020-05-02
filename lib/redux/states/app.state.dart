import 'package:flutter/cupertino.dart';

import 'calendar.state.dart';
import 'lifecycle.state.dart';

@immutable
abstract class State {}

class AppState extends State {
  final LifecycleState lifecycleState;
  final CalendarState calendarState;

  AppState({@required this.lifecycleState, @required this.calendarState});

  factory AppState.initial() {
    return AppState(
        lifecycleState: LifecycleState.initial(),
        calendarState: CalendarState.initial());
  }

  AppState copyWith(
      {LifecycleState lifecycleState, CalendarState calendarState}) {
    return AppState(
        lifecycleState: lifecycleState ?? this.lifecycleState,
        calendarState: calendarState ?? this.calendarState);
  }
}

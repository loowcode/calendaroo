import 'package:flutter/cupertino.dart';

import 'calendar.state.dart';
import 'app-status.state.dart';

@immutable
class AppState {
  final AppStatusState appStatusState;
  final CalendarState calendarState;

  AppState({@required this.appStatusState, @required this.calendarState});

  factory AppState.initial() {
    return AppState(
        appStatusState: AppStatusState.initial(),
        calendarState: CalendarState.initial());
  }

  AppState copyWith(
      {AppStatusState lifecycleState, CalendarState calendarState}) {
    return AppState(
        appStatusState: lifecycleState ?? this.appStatusState,
        calendarState: calendarState ?? this.calendarState);
  }
}

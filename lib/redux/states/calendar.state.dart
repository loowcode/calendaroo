import 'package:calendaroo/model/event.dart';
import 'package:flutter/cupertino.dart';


@immutable
class CalendarState {
  final List<Event> events;

  CalendarState({this.events});

  factory CalendarState.initial() {
    return CalendarState(events: List<Event>());
  }

  CalendarState copyWith({List<Event> events}) {
    return CalendarState(
      events: events ?? this.events,
    );
  }
}

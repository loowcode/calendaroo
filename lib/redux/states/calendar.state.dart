import 'package:calendaroo/model/event.dart';
import 'package:flutter/cupertino.dart';


@immutable
class CalendarState {
  final List<Event> events;
  final Event showEvent;

  CalendarState({this.events, this.showEvent});

  factory CalendarState.initial() {
    return CalendarState(events: List<Event>());
  }

  CalendarState copyWith({List<Event> events, Event showEvent}) {
    return CalendarState(
      events: events ?? this.events,
      showEvent: showEvent ?? this.showEvent,
    );
  }
}

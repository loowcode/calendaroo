import 'package:calendaroo/model/event.dart';
import 'package:flutter/cupertino.dart';


@immutable
class CalendarState {
  final List<Event> events;
  final Event showEvent;
  final DateTime selectedDay;

  CalendarState({this.events, this.showEvent, this.selectedDay});

  factory CalendarState.initial() {
    return CalendarState(events: List<Event>());
  }

  CalendarState copyWith({List<Event> events, DateTime selectedDay,Event showEvent}) {
    return CalendarState(
      events: events ?? this.events,
      showEvent: showEvent ?? this.showEvent,
      selectedDay: selectedDay ?? this.selectedDay,
    );
  }
}

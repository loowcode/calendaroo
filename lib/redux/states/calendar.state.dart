import 'package:calendaroo/model/event.dart';
import 'package:flutter/cupertino.dart';


@immutable
class CalendarState {
  final List<Event> events;
  final Event newEventCached;

  CalendarState({this.events, this.newEventCached});

  factory CalendarState.initial() {
    return CalendarState(events: List<Event>());
  }

  CalendarState copyWith({List<Event> events, Event newEventCached}) {
    return CalendarState(
      events: events ?? this.events,
      newEventCached: newEventCached ?? this.newEventCached,
    );
  }
}

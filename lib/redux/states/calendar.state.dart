import 'dart:collection';

import 'package:calendaroo/model/event.model.dart';
import 'package:flutter/cupertino.dart';

@immutable
class CalendarState {
  final List<Event> events; //TODO: remove this duplicated info
  final SplayTreeMap<DateTime, List<Event>> eventMapped;
  final Event showEvent; //TODO: remove this unused info
  final DateTime selectedDay;

  CalendarState(
      {this.events, this.eventMapped, this.showEvent, this.selectedDay});

  factory CalendarState.initial() {
    return CalendarState(events: List<Event>(), eventMapped: SplayTreeMap());
  }

  CalendarState copyWith({List<Event> events,
    SplayTreeMap<DateTime, List<Event>> eventMapped,
    DateTime selectedDay,
    Event showEvent}) {
    return CalendarState(
      events: events ?? this.events,
      eventMapped: eventMapped ?? this.eventMapped,
      showEvent: showEvent ?? this.showEvent,
      selectedDay: selectedDay ?? this.selectedDay,
    );
  }
}

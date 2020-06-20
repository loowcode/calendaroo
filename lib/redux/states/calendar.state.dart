import 'dart:collection';

import 'package:calendaroo/model/date.dart';
import 'package:calendaroo/model/event-instance.model.dart';
import 'package:calendaroo/model/event.model.dart';
import 'package:flutter/cupertino.dart';

@immutable
class CalendarState {
  final List<Event> events;
  final SplayTreeMap<Date, List<EventInstance>> eventMapped;
  final Event showEvent;
  final DateTime selectedDay;

  CalendarState(
      {this.events, this.eventMapped, this.showEvent, this.selectedDay});

  factory CalendarState.initial() {
    return CalendarState(events: <Event>[], eventMapped: SplayTreeMap());
  }

  CalendarState copyWith(
      {List<Event> events,
      SplayTreeMap<Date, List<EventInstance>> eventMapped,
      DateTime selectedDay,
      Event showEvent}) {
    return CalendarState(
      events: events ?? this.events,
      eventMapped: eventMapped ?? this.eventMapped,
      showEvent: showEvent ?? this.showEvent,
      selectedDay: selectedDay ?? this.selectedDay,
    );
  }

  // TODO: there is a better solution?
  CalendarState copyWithAdmitNull(Event showEvent) {
    return CalendarState(
      events: events,
      eventMapped: eventMapped,
      showEvent: showEvent,
      selectedDay: selectedDay,
    );
  }
}

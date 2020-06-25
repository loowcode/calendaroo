import 'dart:collection';

import 'package:calendaroo/model/date.dart';
import 'package:calendaroo/model/event-instance.model.dart';
import 'package:calendaroo/model/event.model.dart';
import 'package:flutter/cupertino.dart';

@immutable
class CalendarState {
  final SplayTreeMap<Date, List<EventInstance>> eventsMapped;
  final Event focusedEvent;
  final Date selectedDay;

  CalendarState(
      {this.eventsMapped, this.focusedEvent, this.selectedDay});

  factory CalendarState.initial() {
    return CalendarState(eventsMapped: SplayTreeMap());
  }

  CalendarState copyWith(
      {SplayTreeMap<Date, List<EventInstance>> eventsMapped,
      Date selectedDay,
      Event focusedEvent}) {
    return CalendarState(
      eventsMapped: eventsMapped ?? this.eventsMapped,
      focusedEvent: focusedEvent ?? this.focusedEvent,
      selectedDay: selectedDay ?? this.selectedDay,
    );
  }

  // TODO: there is a better solution?
  CalendarState copyWithAdmitNull(Event focusedEvent) {
    return CalendarState(
      eventsMapped: eventsMapped,
      focusedEvent: focusedEvent,
      selectedDay: selectedDay,
    );
  }
}

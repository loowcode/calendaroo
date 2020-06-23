import 'dart:collection';

import 'package:calendaroo/model/date.dart';
import 'package:calendaroo/model/event-instance.model.dart';
import 'package:calendaroo/model/event.model.dart';
import 'package:flutter/cupertino.dart';

@immutable
class CalendarState {
  final SplayTreeMap<Date, List<EventInstance>> eventsMapped;
  final Event showEvent;
  final Date selectedDay;

  CalendarState(
      {this.eventsMapped, this.showEvent, this.selectedDay});

  factory CalendarState.initial() {
    return CalendarState(eventsMapped: SplayTreeMap());
  }

  CalendarState copyWith(
      {SplayTreeMap<Date, List<EventInstance>> eventsMapped,
      Date selectedDay,
      Event showEvent}) {
    return CalendarState(
      eventsMapped: eventsMapped ?? this.eventsMapped,
      showEvent: showEvent ?? this.showEvent,
      selectedDay: selectedDay ?? this.selectedDay,
    );
  }

  // TODO: there is a better solution?
  CalendarState copyWithAdmitNull(Event showEvent) {
    return CalendarState(
      eventsMapped: eventsMapped,
      showEvent: showEvent,
      selectedDay: selectedDay,
    );
  }
}

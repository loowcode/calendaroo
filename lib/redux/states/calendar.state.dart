import 'dart:collection';

import 'package:calendaroo/model/date.model.dart';
import 'package:calendaroo/model/event-instance.model.dart';
import 'package:calendaroo/model/event.model.dart';
import 'package:flutter/cupertino.dart';

@immutable
class CalendarState {
  final SplayTreeMap<Date, List<EventInstance>> eventsMapped;
  final Event focusedEvent;
  final Date selectedDay;
  final Date startRange;
  final Date endRange;

  CalendarState(
      {this.eventsMapped,
      this.focusedEvent,
      this.selectedDay,
      this.startRange,
      this.endRange});

  factory CalendarState.initial() {
    return CalendarState(
      eventsMapped: SplayTreeMap(),
      selectedDay: Date.today(),
      startRange:
          Date.convertToDate(DateTime.now().subtract(Duration(days: 60))),
      endRange: Date.convertToDate(DateTime.now().add(Duration(days: 60))),
    );
  }

  CalendarState copyWith(
      {SplayTreeMap<Date, List<EventInstance>> eventsMapped,
      Date selectedDay,
      Date startRange,
      Date endRange,
      Event focusedEvent}) {
    return CalendarState(
      eventsMapped: eventsMapped ?? this.eventsMapped,
      focusedEvent: focusedEvent ?? this.focusedEvent,
      selectedDay: selectedDay ?? this.selectedDay,
      startRange: startRange ?? this.startRange,
      endRange: endRange ?? this.endRange,
    );
  }

}

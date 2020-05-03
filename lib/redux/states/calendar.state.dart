import 'package:calendaroo/model/event.dart';

import 'app.state.dart';

class CalendarState extends State {
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

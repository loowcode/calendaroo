import 'app.state.dart';

class CalendarState extends State {
  final List<String> events;

  CalendarState({this.events});

  factory CalendarState.initial() {
    return CalendarState(events: List<String>());
  }

  CalendarState copyWith({List<String> events}) {
    return CalendarState(
      events: events ?? this.events,
    );
  }
}

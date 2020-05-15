import 'dart:collection';

import 'package:calendaroo/model/event.model.dart';
import 'package:calendaroo/redux/actions/calendar.actions.dart';
import 'package:calendaroo/redux/states/app.state.dart';
import 'package:redux/redux.dart';

class CalendarViewModel {
  final List<Event> events;
  final SplayTreeMap<DateTime, List<Event>> eventMapped;

  final Function(DateTime) selectDay;

  CalendarViewModel({this.events, this.eventMapped, this.selectDay});

  static CalendarViewModel fromStore(Store<AppState> store) {
    return CalendarViewModel(
      events: store.state.calendarState.events,
      eventMapped: store.state.calendarState.eventMapped,
      selectDay: (day) => store.dispatch(SelectDay(day)),
    );
  }
}

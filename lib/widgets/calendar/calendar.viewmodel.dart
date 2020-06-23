import 'dart:collection';

import 'package:calendaroo/model/date.dart';
import 'package:calendaroo/model/event-instance.model.dart';
import 'package:calendaroo/model/event.model.dart';
import 'package:calendaroo/redux/actions/calendar.actions.dart';
import 'package:calendaroo/redux/states/app.state.dart';
import 'package:redux/redux.dart';

class CalendarViewModel {
  final Date selectedDay;
  final List<Event> events;
  final SplayTreeMap<Date, List<EventInstance>> eventMapped;

  final Function(Date) selectDay;

  CalendarViewModel({this.selectedDay, this.events, this.eventMapped, this.selectDay});

  static CalendarViewModel fromStore(Store<AppState> store) {
    return CalendarViewModel(
      selectedDay: store.state.calendarState.selectedDay,
      eventMapped: store.state.calendarState.eventsMapped,
      selectDay: (day) => store.dispatch(SelectDay(day)),
    );
  }
}

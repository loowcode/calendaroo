import 'dart:collection';

import 'package:calendaroo/model/date.model.dart';
import 'package:calendaroo/model/event-instance.model.dart';
import 'package:calendaroo/redux/actions/calendar.actions.dart';
import 'package:calendaroo/redux/states/app.state.dart';
import 'package:redux/redux.dart';

class CalendarViewModel {
  final Date selectedDay;
  final SplayTreeMap<Date, List<EventInstance>> eventMapped;
  final Date startRange;
  final Date endRange;

  final Function(Date) selectDay;
  final Function(Date, Date) expandRange;

  CalendarViewModel(
      {this.selectedDay,
      this.eventMapped,
      this.startRange,
      this.endRange,
      this.selectDay,
      this.expandRange});

  static CalendarViewModel fromStore(Store<AppState> store) {
    return CalendarViewModel(
      selectedDay: store.state.calendarState.selectedDay,
      eventMapped: store.state.calendarState.eventsMapped,
      startRange: store.state.calendarState.startRange,
      endRange: store.state.calendarState.endRange,
      expandRange: (first, last) => store.dispatch(ExpandRange(first, last)),
      selectDay: (day) => store.dispatch(SelectDay(day)),
    );
  }
}

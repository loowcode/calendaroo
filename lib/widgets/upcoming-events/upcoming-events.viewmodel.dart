import 'dart:collection';

import 'package:calendaroo/model/event.model.dart';
import 'package:calendaroo/redux/actions/calendar.actions.dart';
import 'package:calendaroo/redux/states/app.state.dart';
import 'package:redux/redux.dart';

class UpcomingEventsViewModel {
  final DateTime selectedDay;
  final List<Event> events;
  final SplayTreeMap<DateTime, List<Event>> eventMapped;

  final Function(Event) openEvent;

  UpcomingEventsViewModel({this.selectedDay, this.events,this.eventMapped, this.openEvent});

  static UpcomingEventsViewModel fromStore(Store<AppState> store) {
    return UpcomingEventsViewModel(
      selectedDay: store.state.calendarState.selectedDay,
      events: store.state.calendarState.events,
      eventMapped: store.state.calendarState.eventMapped,
      openEvent: (event) => store.dispatch(new OpenEvent(event)),
    );
  }
}

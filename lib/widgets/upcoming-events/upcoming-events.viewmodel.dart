import 'dart:collection';

import 'package:calendaroo/model/date.dart';
import 'package:calendaroo/model/event-instance.model.dart';
import 'package:calendaroo/model/event.model.dart';
import 'package:calendaroo/redux/actions/calendar.actions.dart';
import 'package:calendaroo/redux/states/app.state.dart';
import 'package:redux/redux.dart';

class UpcomingEventsViewModel {
  final Date selectedDay;
  final List<Event> events;
  final SplayTreeMap<Date, List<EventInstance>> eventMapped;

  final Function(Event) openEvent;

  UpcomingEventsViewModel({this.selectedDay, this.events,this.eventMapped, this.openEvent});

  static UpcomingEventsViewModel fromStore(Store<AppState> store) {
    return UpcomingEventsViewModel(
      selectedDay: store.state.calendarState.selectedDay,
      eventMapped: store.state.calendarState.eventsMapped,
      openEvent: (event) => store.dispatch(OpenEvent(event)),
    );
  }
}

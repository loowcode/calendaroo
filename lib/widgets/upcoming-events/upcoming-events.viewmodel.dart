import 'package:calendaroo/model/event.dart';
import 'package:calendaroo/redux/actions/calendar.actions.dart';
import 'package:calendaroo/redux/states/app.state.dart';
import 'package:redux/redux.dart';

class UpcomingEventsViewModel {
  final List<Event> events;

  final Function(Event) openEvent;

  UpcomingEventsViewModel({this.events, this.openEvent});

  static UpcomingEventsViewModel fromStore(Store<AppState> store) {
    return UpcomingEventsViewModel(
      events: store.state.calendarState.events,
      openEvent: (event) => store.dispatch(new OpenEvent(event)),
    );
  }
}

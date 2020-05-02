import 'package:calendaroo/redux/actions.dart';
import 'package:calendaroo/redux/state.dart';


class CalendarReducer {

  static AppState addEvent(AppState state, dynamic action) {
    if (action is AddEvent) {
      state.calendarState.events.add(action.event);
    }
    if (action is LoadedEventsList) {
      state.calendarState.events = action.events;
    }
    if (action is RemoveEvent) {
      state.calendarState.events.removeAt(action.id);
    }

    return state;
  }
}

import 'package:calendaroo/redux/actions.dart';
import 'package:calendaroo/redux/state.dart';


class CalendarReducer {

  static AppState addEvent(AppState state, dynamic action) {
    if (action is AddEvent) {
      return CalendarState(List());
    }

    return null;
  }
}

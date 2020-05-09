import 'package:calendaroo/model/event.dart';
import 'package:calendaroo/redux/actions/calendar.actions.dart';
import 'package:calendaroo/redux/states/app.state.dart';
import 'package:redux/redux.dart';

class CalendarViewModel {
  final List<Event> events;

  final Function(DateTime) selectDay;

  CalendarViewModel({this.events, this.selectDay});

  static CalendarViewModel fromStore(Store<AppState> store) {
    return CalendarViewModel(
      events: store.state.calendarState.events,
      selectDay: (day) => store.dispatch(SelectDay(day)),
    );
  }
}

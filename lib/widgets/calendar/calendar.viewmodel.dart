import 'package:calendaroo/model/event.dart';
import 'package:calendaroo/redux/actions/calendar.actions.dart';
import 'package:calendaroo/redux/states/app.state.dart';
import 'package:calendaroo/widgets/calendar/calendar.widget.dart';
import 'package:calendaroo/widgets/calendar/calendar.widget.dart';
import 'package:calendaroo/widgets/calendar/calendar.widget.dart';
import 'package:calendaroo/widgets/calendar/calendar.widget.dart';
import 'package:redux/redux.dart';

class CalendarViewModel {
  final List<Event> events;


  CalendarViewModel({this.events});

  static CalendarViewModel fromStore(Store<AppState> store) {
    return CalendarViewModel(
      events: store.state.calendarState.events,
    );
  }
}

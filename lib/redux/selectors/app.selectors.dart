import 'package:calendaroo/redux/states/app.state.dart';
import 'package:calendaroo/redux/states/calendar.state.dart';
import 'package:calendaroo/redux/states/app-status.state.dart';

CalendarState calendarSelector(AppState state) => state.calendarState;
AppStatusState lifecycleSelector(AppState state) => state.appStatusState;
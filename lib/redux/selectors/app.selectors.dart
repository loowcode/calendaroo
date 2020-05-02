import 'package:calendaroo/redux/states/app.state.dart';
import 'package:calendaroo/redux/states/calendar.state.dart';
import 'package:calendaroo/redux/states/lifecycle.state.dart';

CalendarState calendarSelector(AppState state) => state.calendarState;
LifecycleState flowSelector(AppState state) => state.lifecycleState;
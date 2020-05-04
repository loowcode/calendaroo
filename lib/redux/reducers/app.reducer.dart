import 'package:calendaroo/redux/reducers/app-status.reducer.dart';
import 'package:calendaroo/redux/reducers/calendar.reducer.dart';
import 'package:calendaroo/redux/states/app.state.dart';



AppState appReducer(AppState state, action) {
  return AppState(
    appStatusState: appStatusReducer(state.appStatusState, action),
    calendarState: calendarReducer(state.calendarState, action),
  );
}

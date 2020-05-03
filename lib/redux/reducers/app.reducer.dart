import 'package:calendaroo/redux/reducers/calendar.reducer.dart';
import 'package:calendaroo/redux/states/app.state.dart';


AppState appReducer(AppState state, action) {
  return AppState(
    calendarState: calendarReducer(state.calendarState, action),
  );
}

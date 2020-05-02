import 'package:calendaroo/redux/actions/calendar.actions.dart';
import 'package:calendaroo/redux/states/calendar.state.dart';
import 'package:redux/redux.dart';


final calendarReducer = combineReducers<CalendarState>([
  TypedReducer<CalendarState, AddEvent>(_addEvent),
  TypedReducer<CalendarState, LoadedEventsList>(_loadedEventsList),
  TypedReducer<CalendarState, RemoveEvent>(_removeEvent),
]);

CalendarState _addEvent(CalendarState state, AddEvent action) {
  final newEvents = List.from(state.events)..add(action.event);
  return state.copyWith(events: newEvents);
}

CalendarState _removeEvent(CalendarState state, RemoveEvent action) {
  final newEvents = List.from(state.events)
    ..removeWhere((el) => action.id == el);
  return state.copyWith(events: newEvents);
}

CalendarState _loadedEventsList(CalendarState state, LoadedEventsList action) {
  return state.copyWith(events: action.events);
}

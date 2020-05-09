import 'package:calendaroo/model/event.dart';
import 'package:calendaroo/redux/actions/calendar.actions.dart';
import 'package:calendaroo/redux/states/calendar.state.dart';
import 'package:redux/redux.dart';


final calendarReducer = combineReducers<CalendarState>([
  TypedReducer<CalendarState, AddEvent>(_addEvent),
  TypedReducer<CalendarState, OpenEvent>(_openEvent),
  TypedReducer<CalendarState, SelectDay>(_selectDay),
  TypedReducer<CalendarState, LoadedEventsList>(_loadedEventsList),
  TypedReducer<CalendarState, RemoveEvent>(_removeEvent),
]);

CalendarState _addEvent(CalendarState state, AddEvent action) {
  final newEvents = List<Event>.from(state.events)..add(action.event);
  return state.copyWith(events: newEvents);
}

CalendarState _openEvent(CalendarState state, OpenEvent action) {
  return state.copyWith(showEvent: action.event);
}

CalendarState _selectDay(CalendarState state, SelectDay action) {
  return state.copyWith(selectedDay: action.day);
}

CalendarState _removeEvent(CalendarState state, RemoveEvent action) {
  final newEvents = List.from(state.events)
    ..removeWhere((el) => action.event.id == el.id);
  return state.copyWith(events: newEvents);
}

CalendarState _loadedEventsList(CalendarState state, LoadedEventsList action) {
  return state.copyWith(events: action.events);
}

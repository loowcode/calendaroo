import 'package:calendaroo/model/event.model.dart';
import 'package:calendaroo/redux/actions/calendar.actions.dart';
import 'package:calendaroo/redux/states/calendar.state.dart';
import 'package:calendaroo/services/calendar.service.dart';
import 'package:redux/redux.dart';

final calendarReducer = combineReducers<CalendarState>([
  TypedReducer<CalendarState, AddEvent>(_addEvent),
  TypedReducer<CalendarState, OpenEvent>(_openEvent),
  TypedReducer<CalendarState, SelectDay>(_selectDay),
  TypedReducer<CalendarState, LoadedEventsList>(_loadedEventsList),
  TypedReducer<CalendarState, RemoveEvent>(_removeEvent),
  TypedReducer<CalendarState, EditEvent>(_editEvent),
]);

CalendarState _addEvent(CalendarState state, AddEvent action) {
  _saveIntoStore(state, action.event);
  final newEvents = state.events..add(action.event);
  return state.copyWith(events: newEvents);
}

CalendarState _editEvent(CalendarState state, EditEvent action) {
  _editIntoStore(state, action.oldEvent, action.newEvent);

  final indexList =
      state.events.indexWhere((element) => element.id == action.oldEvent.id);
  state.events[indexList] = action.newEvent;
  return state;
}

CalendarState _openEvent(CalendarState state, OpenEvent action) {
  return state.copyWith(showEvent: action.event);
}

CalendarState _selectDay(CalendarState state, SelectDay action) {
  return state.copyWith(selectedDay: action.day);
}

CalendarState _removeEvent(CalendarState state, RemoveEvent action) {
  _removeFromStore(state, action.event);

  final newEvents = state.events..removeWhere((el) => action.event.id == el.id);
  return state.copyWith(events: newEvents);
}

CalendarState _loadedEventsList(CalendarState state, LoadedEventsList action) {
  return state.copyWith(
      events: action.events,
      eventMapped: CalendarService().toMap(action.events));
}

// utils

void _saveIntoStore(CalendarState state, Event event) {
  DateTime first = CalendarService().removeTime(event.start);
  DateTime index = CalendarService().removeTime(event.start);
  DateTime last = CalendarService().removeTime(event.end);
  for (var i = 0; i <= last.difference(first).inDays; i++) {
    _saveOneEvent(state, index, event);
    index = index.add(Duration(days: 1));
  }
}

void _saveOneEvent(CalendarState state, DateTime date, Event event) {
  var start = CalendarService().removeTime(date);
  state.eventMapped
      .update(start, (value) => value..add(event), ifAbsent: () => [event]);
}

void _editIntoStore(CalendarState state, Event oldEvent, Event newEvent) {
  _removeFromStore(state, oldEvent);
  _saveIntoStore(state, newEvent);
}

void _removeFromStore(CalendarState state, Event event) {
  DateTime first = CalendarService().removeTime(event.start);
  DateTime index = CalendarService().removeTime(event.start);
  DateTime last = CalendarService().removeTime(event.end);
  for (var i = 0; i <= last.difference(first).inDays; i++) {
    _removeOneEvent(state, index, event);
    index = index.add(Duration(days: 1));
  }
}

void _removeOneEvent(CalendarState state, DateTime date, Event event) {
  var key = CalendarService().removeTime(date);
  if (state.eventMapped.containsKey(key)) {
    state.eventMapped[key].removeWhere((element) => event.id == element.id);
    if (state.eventMapped[key].length == 0) {
      state.eventMapped.remove(key);
    }
  }
}

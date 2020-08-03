import 'package:calendaroo/model/date.model.dart';
import 'package:calendaroo/model/event.model.dart';
import 'package:calendaroo/redux/actions/calendar.actions.dart';
import 'package:calendaroo/redux/states/calendar.state.dart';
import 'package:calendaroo/utils/calendar.utils.dart';
import 'package:redux/redux.dart';

final calendarReducer = combineReducers<CalendarState>([
  TypedReducer<CalendarState, AddEvent>(_addEvent),
  TypedReducer<CalendarState, OpenEvent>(_openEvent),
  TypedReducer<CalendarState, SelectDay>(_selectDay),
  TypedReducer<CalendarState, LoadedEventsList>(_loadedEventsList),
  TypedReducer<CalendarState, RemoveEvent>(_removeEvent),
  TypedReducer<CalendarState, EditEvent>(_editEvent),
  TypedReducer<CalendarState, ExpandRange>(_expandRange),
]);

CalendarState _addEvent(CalendarState state, AddEvent action) {
  _addIntoStore(state, action.event);
  return state;
}

CalendarState _editEvent(CalendarState state, EditEvent action) {
  _removeFromStore(state, action.event);
  _addIntoStore(state, action.event);
  return state;
}

CalendarState _openEvent(CalendarState state, OpenEvent action) {
  return state.copyWith(focusedEvent: action.event);
}

CalendarState _selectDay(CalendarState state, SelectDay action) {
  return state.copyWith(selectedDay: action.day);
}

CalendarState _removeEvent(CalendarState state, RemoveEvent action) {
  _removeFromStore(state, action.event);
  return state;
}

CalendarState _loadedEventsList(CalendarState state, LoadedEventsList action) {
  return state.copyWith(
      eventsMapped: CalendarUtils.toMappedInstances(action.events));
}

CalendarState _expandRange(CalendarState state, ExpandRange action) {
  return state.copyWith(startRange: action.first, endRange: action.last);
}

// utils

void _addIntoStore(CalendarState state, Event event) {
  var rangeStart = state.selectedDay.subtract(Duration(days: 60));
  var rangeEnd = state.selectedDay.add(Duration(days: 60));

  var newInstances = CalendarUtils.createNearInstances(
      event, Date.convertToDate(rangeStart), Date.convertToDate(rangeEnd));

  newInstances.forEach((elem) {
    var start = Date.convertToDate(elem.start);
    state.eventsMapped
        .update(start, (value) => value..add(elem), ifAbsent: () => [elem]);
  });
}

void _removeFromStore(CalendarState state, Event event) {
  var keys = state.eventsMapped.keys.toList();
  keys.forEach((date) {
    _removeOneEvent(state, date, event);
  });
}

void _removeOneEvent(CalendarState state, DateTime date, Event event) {
  var key = Date.convertToDate(date);
  if (state.eventsMapped.containsKey(key)) {
    state.eventsMapped[key]
        .removeWhere((element) => event.id == element.eventId);
    if (state.eventsMapped[key].isEmpty) {
      state.eventsMapped.remove(key);
    }
  }
}

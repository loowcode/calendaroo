import 'package:calendaroo/model/date.dart';
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
]);

CalendarState _addEvent(CalendarState state, AddEvent action) {
  var event = action.event;
  var rangeStart = state.selectedDay.subtract(Duration(days: 60));
  var rangeEnd = state.selectedDay.add(Duration(days: 60));

  var newInstances = CalendarUtils.createNearInstances(
      event, Date.convertToDate(rangeStart), Date.convertToDate(rangeEnd));

  newInstances.forEach((elem) {
    var start = Date.convertToDate(elem.start);
    state.eventsMapped
        .update(start, (value) => value..add(elem), ifAbsent: () => [elem]);
  });

  return state;
}

CalendarState _editEvent(CalendarState state, EditEvent action) {
//  _editIntoStore(state, action.oldEvent, action.newEvent);
// TODO
  return state.copyWith(showEvent: action.newEvent);
}

CalendarState _openEvent(CalendarState state, OpenEvent action) {
  return state.copyWithAdmitNull(action.event);
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

// utils

void _removeFromStore(CalendarState state, Event event) {
  var first = CalendarUtils.removeTime(event.start);
  var index = CalendarUtils.removeTime(event.start);
  var last = CalendarUtils.removeTime(event.end);
  for (var i = 0; i <= last.difference(first).inDays; i++) {
    _removeOneEvent(state, index, event);
    index = index.add(Duration(days: 1));
  }
}

void _removeOneEvent(CalendarState state, DateTime date, Event event) {
  var key = CalendarUtils.removeTime(date);
  if (state.eventsMapped.containsKey(key)) {
    state.eventsMapped[key].removeWhere((element) => event.id == element.id);
    if (state.eventsMapped[key].isEmpty) {
      state.eventsMapped.remove(key);
    }
  }
}

import 'package:calendaroo/model/event-instance.model.dart';
import 'package:calendaroo/model/event.model.dart';
import 'package:calendaroo/redux/actions/calendar.actions.dart';
import 'package:calendaroo/redux/states/calendar.state.dart';
import 'package:calendaroo/utils/calendar.utils.dart';
import 'package:redux/redux.dart';
import 'package:uuid/uuid.dart';

final calendarReducer = combineReducers<CalendarState>([
  TypedReducer<CalendarState, AddEvent>(_addEvent),
  TypedReducer<CalendarState, OpenEvent>(_openEvent),
  TypedReducer<CalendarState, SelectDay>(_selectDay),
  TypedReducer<CalendarState, LoadedEventsList>(_loadedEventsList),
  TypedReducer<CalendarState, RemoveEvent>(_removeEvent),
  TypedReducer<CalendarState, EditEvent>(_editEvent),
]);

CalendarState _addEvent(CalendarState state, AddEvent action) {
  final _uuid = Uuid();

  var event = action.event;
  var first = CalendarUtils.removeTime(event.start);
  var index = CalendarUtils.removeTime(event.start);
  var last = CalendarUtils.removeTime(event.end);

  var daySpan = last.difference(first).inDays;
  for (var i = 0; i <= daySpan; i++) {
    var instance = EventInstance(
      id: null,
      uuid: _uuid.v4(),
      eventId: event.id,
      start: DateTime(
        index.year,
        index.month,
        index.day,
        i == 0 ? event.start.hour : 0,
        i == 0 ? event.start.minute : 0,
      ),
      end: DateTime(
        index.year,
        index.month,
        index.day,
        i == daySpan ? event.end.hour : 23,
        i == daySpan ? event.end.minute : 59,
      ),
    );
    // TODO pick only near eventInstances and save them into eventsMapped
    index = index.add(Duration(days: 1));
  }
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
  return state.copyWith(eventsMapped: CalendarUtils.toMappedInstances(action.events));
}

// utils

//void _saveIntoStore(CalendarState state, Event event) {
//  var first = CalendarUtils.removeTime(event.start);
//  var index = CalendarUtils.removeTime(event.start);
//  var last = CalendarUtils.removeTime(event.end);
//  for (var i = 0; i <= last.difference(first).inDays; i++) {
//    _saveOneEvent(state, index, event);
//    index = index.add(Duration(days: 1));
//  }
//}
//
//void _saveOneInstance(CalendarState state, Date date, Event event) {
//  var start = CalendarUtils.removeTime(date);
//  state.eventsMapped
//      .update(start, (value) => value..add(event), ifAbsent: () => [event]);
//}

//void _editIntoStore(CalendarState state, Event oldEvent, Event newEvent) {
//  _removeFromStore(state, oldEvent);
//  _saveIntoStore(state, newEvent);
//}

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

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
  var start = CalendarService().removeTime(action.event.start);
  state.eventMapped.update(start, (value) => value..add(action.event),
      ifAbsent: () => [action.event]);
  final newEvents = state.events..add(action.event);
  return state.copyWith(events: newEvents);
}

CalendarState _editEvent(CalendarState state, EditEvent action) {
  var start = CalendarService().removeTime(action.event.start);
  state.eventMapped.update(start, (value) {
    final index = value.indexWhere((element) => element.id == action.event.id);
    value[index] = action.event;
    return value;
  }, ifAbsent: () => [action.event]);
  final index =
      state.events.indexWhere((element) => element.id == action.event.id);
  state.events[index] = action.event;
  return state;
}

CalendarState _openEvent(CalendarState state, OpenEvent action) {
  return state.copyWith(showEvent: action.event);
}

CalendarState _selectDay(CalendarState state, SelectDay action) {
  return state.copyWith(selectedDay: action.day);
}

CalendarState _removeEvent(CalendarState state, RemoveEvent action) {
  final newEvents = state.events..removeWhere((el) => action.event.id == el.id);
  var date = CalendarService().removeTime(action.event.start);
  if (state.eventMapped.containsKey(date)) {
    state.eventMapped[date]
        .removeWhere((element) => action.event.id == element.id);
    if (state.eventMapped[date].length == 0) {
      state.eventMapped.remove(date);
    }
  }
  return state.copyWith(events: newEvents);
}

CalendarState _loadedEventsList(CalendarState state, LoadedEventsList action) {
  return state.copyWith(
      events: action.events,
      eventMapped: CalendarService().toMap(action.events));
}

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
  _saveEvent(state, action.event);
  final newEvents = state.events..add(action.event);
  return state.copyWith(events: newEvents);
}

_inserIntoStore(CalendarState state, Event event) {
  var start = CalendarService().removeTime(event.start);
  state.eventMapped
      .update(start, (value) => value..add(event), ifAbsent: () => [event]);
}

Event _saveEvent(CalendarState state, Event event) {
  DateTime index = CalendarService().removeTime(event.start);
  DateTime first = CalendarService().removeTime(event.start);
  DateTime last = CalendarService().removeTime(event.start);
  while (index.isBefore(last)) {
    // if event has a multidays duration
    if (index.difference(first).inDays == 0) {
      // if first day
      _inserIntoStore(
          state,
          _createNewEvent(
              event.title,
              event.description,
              DateTime(event.start.year, event.start.month, event.start.day,
                  event.start.hour, event.start.minute),
              DateTime(event.start.year, event.start.month, event.start.day, 23,
                  59)));
    } else {
      // if middle days
      _inserIntoStore(
          state,
          _createNewEvent(
              event.title,
              event.description,
              DateTime(index.year, index.month, index.day, 0, 0),
              DateTime(index.year, index.month, index.day, 23, 59)));
    }

    index = index.add(Duration(days: 1));
  }
  var hour;
  var minute;
  if (first.difference(last).inDays == 0) {
    // event with a one day duration
    hour = event.start.hour;
    minute = event.start.minute;
  } else {
    // if last day of a multidays event
    hour = 0;
    minute = 0;
  }
  _inserIntoStore(
      state,
      _createNewEvent(
          event.title,
          event.description,
          DateTime(index.year, index.month, index.day, hour, minute),
          DateTime(event.end.year, event.end.month, event.end.day,
              event.end.hour, event.end.minute)));
}

Event _createNewEvent(
    String title, String description, DateTime start, DateTime end) {
  return Event(
      id: null, title: title, description: description, start: start, end: end);
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

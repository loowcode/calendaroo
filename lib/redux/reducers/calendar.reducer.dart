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
]);

CalendarState _addEvent(CalendarState state, AddEvent action) {
  var id = state.events.last.id + 1;
  final newEvents = state.events..add(action.event.setId(id));
  return state.copyWith(events: newEvents);
}

CalendarState _openEvent(CalendarState state, OpenEvent action) {
  return state.copyWith(showEvent: action.event);
}

CalendarState _selectDay(CalendarState state, SelectDay action) {
  return state.copyWith(selectedDay: action.day);
}

CalendarState _removeEvent(CalendarState state, RemoveEvent action) {
  final newEvents = state.events..removeWhere((el) => action.event.id == el.id);
  var date =
      state.eventMapped[CalendarService().removeTime(action.event.start)];
  state.eventMapped.forEach((key, value) {
    value.removeWhere((element) => action.event.id == element.id);
  });

  return state.copyWith(events: newEvents);
}

CalendarState _loadedEventsList(CalendarState state, LoadedEventsList action) {
  return state.copyWith(
      events: action.events,
      eventMapped: CalendarService().toMapIndexed(action.events));
}

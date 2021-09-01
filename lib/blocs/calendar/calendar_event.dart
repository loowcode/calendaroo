part of 'calendar_bloc.dart';

abstract class CalendarEvent extends Equatable {
  const CalendarEvent();
}

class CalendarLoadEvent extends CalendarEvent {
  @override
  List<Object> get props => [];
}

class CalendarDaySelectedEvent extends CalendarEvent {
  final Date selectedDay;

  CalendarDaySelectedEvent(this.selectedDay);

  @override
  List<Object> get props => [selectedDay];
}

class CalendarCreateEvent extends CalendarEvent {
  final CalendarItemModel calendarItem;

  CalendarCreateEvent(this.calendarItem);

  @override
  List<Object> get props => [calendarItem];
}

class CalendarUpdateEvent extends CalendarEvent {
  final CalendarItemModel calendarItem;

  CalendarUpdateEvent(this.calendarItem);

  @override
  List<Object> get props => [calendarItem];
}

class CalendarDeleteEvent extends CalendarEvent {
  final int id;

  CalendarDeleteEvent(this.id);

  @override
  List<Object> get props => [id];
}
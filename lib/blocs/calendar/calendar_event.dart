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
  List<Object> get props => [];
}

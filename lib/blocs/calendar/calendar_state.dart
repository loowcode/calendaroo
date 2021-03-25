part of 'calendar_bloc.dart';

abstract class CalendarState extends Equatable {
  const CalendarState();
}

class CalendarInitial extends CalendarState {
  @override
  List<Object> get props => [];
}

class CalendarLoading extends CalendarState {
  @override
  List<Object> get props => [];
}

class CalendarLoaded extends CalendarState {
  final Date selectedDay;
  final Date startRange;
  final Date endRange;
  final SplayTreeMap<Date, List<EventInstance>> mappedCalendarItems;

  CalendarLoaded({
    this.selectedDay,
    this.startRange,
    this.endRange,
    this.mappedCalendarItems,
  });

  @override
  List<Object> get props => [mappedCalendarItems];
}

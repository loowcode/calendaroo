part of 'calendar_bloc.dart';

abstract class CalendarState extends Equatable {
  final Date selectedDay;
  final Date startRange;
  final Date endRange;

  const CalendarState({
    this.selectedDay,
    this.startRange,
    this.endRange,
  });
}

class CalendarInitial extends CalendarState {
  CalendarInitial({
    Date selectedDay,
    Date startRange,
    Date endRange,
  }) : super(
          selectedDay: selectedDay,
          startRange: startRange,
          endRange: endRange,
        );

  @override
  List<Object> get props => [
        selectedDay,
        startRange,
        endRange,
      ];
}

class CalendarLoading extends CalendarState {
  CalendarLoading({
    Date selectedDay,
    Date startRange,
    Date endRange,
  }) : super(
          selectedDay: selectedDay,
          startRange: startRange,
          endRange: endRange,
        );

  factory CalendarLoading.fromState(CalendarState state) {
    return CalendarLoading(
      selectedDay: state.selectedDay,
      startRange: state.startRange,
      endRange: state.endRange,
    );
  }

  @override
  List<Object> get props => [
        selectedDay,
        startRange,
        endRange,
      ];
}

class CalendarLoaded extends CalendarState {
  final SplayTreeMap<Date, List<CalendarItem>> mappedCalendarItems;

  CalendarLoaded({
    Date selectedDay,
    Date startRange,
    Date endRange,
    this.mappedCalendarItems,
  }) : super(
          selectedDay: selectedDay,
          startRange: startRange,
          endRange: endRange,
        );

  @override
  List<Object> get props => [
        selectedDay,
        startRange,
        endRange,
        mappedCalendarItems,
      ];
}

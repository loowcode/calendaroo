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
  final CalendarItemMap calendarItemMap;

  CalendarLoaded({
    Date selectedDay,
    Date startRange,
    Date endRange,
    this.calendarItemMap,
  }) : super(
          selectedDay: selectedDay,
          startRange: startRange,
          endRange: endRange,
        );

  factory CalendarLoaded.fromState(CalendarState state) {
    return CalendarLoaded(
      selectedDay: state.selectedDay,
      startRange: state.startRange,
      endRange: state.endRange,
      calendarItemMap: state is CalendarLoaded ? state.calendarItemMap : null,
    );
  }

  CalendarLoaded copyWith({
    Date selectedDay,
    Date startRange,
    Date endRange,
    CalendarItemMap calendarItemMap,
  }) {
    return CalendarLoaded(
      selectedDay: selectedDay ?? this.selectedDay,
      startRange: startRange ?? this.startRange,
      endRange: endRange ?? this.endRange,
      calendarItemMap: calendarItemMap ?? this.calendarItemMap,
    );
  }

  @override
  List<Object> get props => [
        selectedDay,
        startRange,
        endRange,
        calendarItemMap,
      ];
}

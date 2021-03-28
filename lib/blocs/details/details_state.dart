part of 'details_bloc.dart';

class DetailsState extends Equatable {
  final String title;
  final String description;
  final DateTime startDate;
  final DateTime endDate;
  final DateTime startTime;
  final DateTime endTime;
  final bool allDay;
  final Repeat repeat;
  final List<Alarm> alarms;
  final CalendarItem calendarItem;
  final bool edited;

  const DetailsState({
    this.title,
    this.description,
    this.startDate,
    this.endDate,
    this.startTime,
    this.endTime,
    this.allDay,
    this.repeat,
    this.alarms,
    this.calendarItem,
    this.edited = false,
  });

  DetailsState copyWith({
    String title,
    String description,
    DateTime startDate,
    DateTime endDate,
    DateTime startTime,
    DateTime endTime,
    bool allDay,
    Repeat repeat,
    List<Alarm> alarms,
    CalendarItem calendarItem,
    bool edited,
  }) {
    return DetailsState(
      title: title ?? this.title,
      description: description ?? this.description,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      allDay: allDay ?? this.allDay,
      repeat: repeat ?? this.repeat,
      alarms: alarms ?? this.alarms,
      calendarItem: calendarItem ?? this.calendarItem,
      edited: edited ?? this.edited,
    );
  }

  @override
  List<Object> get props => [
        title,
        description,
        startDate,
        endDate,
        startTime,
        endTime,
        allDay,
        repeat,
        alarms,
        calendarItem,
        edited,
      ];
}

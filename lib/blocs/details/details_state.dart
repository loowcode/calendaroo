part of 'details_bloc.dart';

class DetailsState extends Equatable {
  final int calendarItemId;
  final String title;
  final String description;
  final DateTime startDate;
  final DateTime endDate;
  final DateTime startTime;
  final DateTime endTime;
  final bool allDay;
  final Repeat repeat;

  // TODO spostare until in repeat?
  final DateTime until;
  final List<Alarm> alarms;
  final bool edited;

  const DetailsState({
    this.calendarItemId,
    this.title,
    this.description,
    this.startDate,
    this.endDate,
    this.startTime,
    this.endTime,
    this.allDay,
    this.repeat,
    this.until,
    this.alarms,
    this.edited = false,
  });

  DetailsState copyWith({
    int calendarItemId,
    String title,
    String description,
    DateTime startDate,
    DateTime endDate,
    DateTime startTime,
    DateTime endTime,
    bool allDay,
    Repeat repeat,
    DateTime until,
    List<Alarm> alarms,
    bool edited,
  }) {
    return DetailsState(
      calendarItemId: calendarItemId ?? this.calendarItemId,
      title: title ?? this.title,
      description: description ?? this.description,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      allDay: allDay ?? this.allDay,
      repeat: repeat ?? this.repeat,
      until: until ?? this.until,
      alarms: alarms ?? this.alarms,
      edited: edited ?? this.edited,
    );
  }

  @override
  List<Object> get props => [
        calendarItemId,
        title,
        description,
        startDate,
        endDate,
        startTime,
        endTime,
        allDay,
        repeat,
        until,
        alarms,
        edited,
      ];
}

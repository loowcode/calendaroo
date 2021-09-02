part of 'details_bloc.dart';

// TODO: aggiungere alarms
abstract class DetailsEvent extends Equatable {
  const DetailsEvent();
}

class DetailsValuesChangedEvent extends DetailsEvent {
  final int calendarItemId;
  final String title;
  final String description;
  final DateTime startDate;
  final DateTime endDate;
  final DateTime startTime;
  final DateTime endTime;
  final bool allDay;
  final Repeat repeat;
  final DateTime until;

  DetailsValuesChangedEvent({
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
  });

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
      ];
}

class DetailsSaveEvent extends DetailsEvent {
  @override
  List<Object> get props => [];
}

class DetailsDeleteEvent extends DetailsEvent {
  @override
  List<Object> get props => [];
}

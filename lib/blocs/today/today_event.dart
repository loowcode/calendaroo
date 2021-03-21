part of 'today_bloc.dart';

abstract class TodayEvent extends Equatable {
  const TodayEvent();
}

class TodayLoadEvent extends TodayEvent {
  @override
  List<Object> get props => [];
}

class TodayChangedEvent extends TodayEvent {
  final List<CalendarItem> todayCalendarItems;

  TodayChangedEvent(this.todayCalendarItems);

  @override
  List<Object> get props => [todayCalendarItems];
}

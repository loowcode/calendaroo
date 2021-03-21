part of 'today_bloc.dart';

abstract class TodayState extends Equatable {
  const TodayState();
}

class TodayInitial extends TodayState {
  @override
  List<Object> get props => [];
}


class TodayLoading extends TodayState {
  @override
  List<Object> get props => [];
}

class TodayUpdated extends TodayState {
  final List<CalendarItem> todayCalendarItems;

  TodayUpdated(this.todayCalendarItems);

  @override
  List<Object> get props => [todayCalendarItems];
}
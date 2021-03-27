import 'package:equatable/equatable.dart';
import 'package:calendaroo/models/calendar_item.model.dart';

class TodayCalendarItems extends Equatable {
  final List<CalendarItem> calendarItems;

  TodayCalendarItems(this.calendarItems);

  @override
  List<Object> get props => [calendarItems];
}

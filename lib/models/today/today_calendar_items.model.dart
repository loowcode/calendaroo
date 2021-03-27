import 'package:calendaroo/models/calendar_item/calendar_item.model.dart';
import 'package:equatable/equatable.dart';

class TodayCalendarItems extends Equatable {
  final List<CalendarItem> calendarItems;

  TodayCalendarItems(this.calendarItems);

  @override
  List<Object> get props => [calendarItems];
}

import 'package:equatable/equatable.dart';
import 'file:///C:/Users/jack1/OneDrive/Desktop/git/calendaroo/lib/models/calendar_item/calendar_item.model.dart';

class TodayCalendarItems extends Equatable {
  final List<CalendarItem> calendarItems;

  TodayCalendarItems(this.calendarItems);

  @override
  List<Object> get props => [calendarItems];
}

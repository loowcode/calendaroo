import 'file:///C:/Users/jack1/OneDrive/Desktop/git/calendaroo/lib/models/calendar_item/calendar_item.model.dart';

abstract class CalendarRepository {
  Future<List<CalendarItem>> findAll();
}

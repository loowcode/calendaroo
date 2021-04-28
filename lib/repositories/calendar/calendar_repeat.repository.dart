import 'package:calendaroo/entities/calendar_item_repeat.entity.dart';

abstract class CalendarItemRepeatRepository {
  Future<CalendarItemRepeat> findByCalendarItemId(int calendarItemId);

  Future<int> add(CalendarItemRepeat calendarItemRepeat);

  Future<void> delete(int id);
}

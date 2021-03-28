import 'package:calendaroo/models/calendar_item/calendar_item.model.dart';

abstract class CalendarRepository {
  Future<List<CalendarItem>> findAll();

  Future<int> add(CalendarItem calendarItem);

  Future<int> update(CalendarItem calendarItem);

  Future<void> delete(int id);
}

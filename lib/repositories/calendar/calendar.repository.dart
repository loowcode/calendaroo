import 'package:calendaroo/entities/calendar_item.entity.dart';
import 'package:calendaroo/models/date.model.dart';

abstract class CalendarRepository {
  Future<CalendarItem> findById(int id);

  Future<List<CalendarItem>> findByDate(Date date);

  Future<int> add(CalendarItem calendarItem);

  Future<int> update(CalendarItem calendarItem);

  Future<void> delete(int id);
}

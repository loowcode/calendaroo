import 'package:calendaroo/dao/calendar_item.dao.dart';
import 'package:calendaroo/entities/calendar_item.entity.dart';
import 'package:calendaroo/models/date.model.dart';
import 'package:calendaroo/repositories/calendar/calendar.repository.dart';

class CalendarLocalRepository extends CalendarRepository {
  final dao = CalendarItemDao();

  @override
  Future<List<CalendarItem>> findByDate(Date date) async {
    return dao.calendarItems(date);
  }

  @override
  Future<int> add(CalendarItem calendarItem) {
    return dao.insertCalendarItem(calendarItem);
  }

  @override
  Future<int> update(CalendarItem calendarItem) {
    return dao.updateCalendarItem(calendarItem);
  }

  @override
  Future<void> delete(int id) async {
    return dao.deleteCalendarItem(id);
  }
}

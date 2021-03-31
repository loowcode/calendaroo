import 'package:calendaroo/dao/calendar_item.dao.dart';
import 'package:calendaroo/models/calendar_item/calendar_item.model.dart';
import 'package:calendaroo/repositories/calendar/calendar.repository.dart';

class CalendarLocalRepository extends CalendarRepository {
  final dao = CalendarItemDao();

  @override
  Future<List<CalendarItem>> findByDate(DateTime date) async {
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

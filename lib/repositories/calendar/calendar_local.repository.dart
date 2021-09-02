import 'package:calendaroo/dao/calendar_item.dao.dart';
import 'package:calendaroo/entities/calendar_item.entity.dart';
import 'package:calendaroo/models/date.model.dart';
import 'package:calendaroo/repositories/calendar/calendar.repository.dart';

class CalendarLocalRepository extends CalendarRepository {
  final dao = CalendarItemDao();

  @override
  Future<CalendarItem> findById(int id) {
    return dao.findById(id);
  }

  @override
  Future<List<CalendarItem>> findByDate(Date date) async {
    return dao.findByDate(date);
  }

  @override
  Future<int> add(CalendarItem calendarItem) {
    return dao.insert(calendarItem);
  }

  @override
  Future<int> update(CalendarItem calendarItem) {
    return dao.update(calendarItem);
  }

  @override
  Future<void> delete(int id) async {
    return dao.delete(id);
  }
}

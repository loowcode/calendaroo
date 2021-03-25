import 'package:calendaroo/dao/calendar_item.dao.dart';
import 'package:calendaroo/models/calendar_item.model.dart';
import 'package:calendaroo/repositories/calendar/calendar.repository.dart';

class CalendarLocalRepository extends CalendarRepository {
  final dao = CalendarItemDao();

  @override
  Future<List<CalendarItem>> findAll() async {
    return dao.calendarItems();
  }
}
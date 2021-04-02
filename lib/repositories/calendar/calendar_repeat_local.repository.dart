import 'package:calendaroo/dao/calendar_item_repeat.dao.dart';
import 'package:calendaroo/entities/calendar_item_repeat.entity.dart';
import 'package:calendaroo/repositories/calendar/calendar_repeat.repository.dart';

class CalendarItemRepeatLocalRepository extends CalendarItemRepeatRepository {
  final dao = CalendarItemRepeatDao();

  @override
  Future<int> add(CalendarItemRepeat calendarItemRepeat) {
    return dao.insert(calendarItemRepeat);
  }
}

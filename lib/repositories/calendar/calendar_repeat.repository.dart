import 'package:calendaroo/entities/calendar_item_repeat.entity.dart';

abstract class CalendarItemRepeatRepository {
  Future<int> add(CalendarItemRepeat calendarItemRepeat);
}

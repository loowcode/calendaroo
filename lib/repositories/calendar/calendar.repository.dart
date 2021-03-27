import 'package:calendaroo/models/calendar_item/calendar_item.model.dart';

abstract class CalendarRepository {
  Future<List<CalendarItem>> findAll();
}
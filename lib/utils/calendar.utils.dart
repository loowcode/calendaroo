import 'dart:collection';

import 'package:calendaroo/model/date.dart';
import 'package:calendaroo/model/event-instance.model.dart';
import 'package:calendaroo/model/event.model.dart';

class CalendarUtils {
  static SplayTreeMap<Date, List<EventInstance>> toMap(
      List<EventInstance> events) {
    var map = SplayTreeMap<Date, List<EventInstance>>();
    events.forEach((EventInstance elem) {
      var first = CalendarUtils.removeTime(elem.start);
      var index = CalendarUtils.removeTime(elem.start);
      var last = CalendarUtils.removeTime(elem.end);
      for (var i = 0; i <= first.difference(last).inDays; i++) {
        _insertIntoMap(map, index, elem);
        index = index.add(Duration(days: 1));
      }
    });
    return map;
  }

  static void _insertIntoMap(SplayTreeMap<DateTime, List<EventInstance>> map,
      DateTime date, EventInstance event) {
    if (map.containsKey(date)) {
      var list = map[date];
      list.add(event);
      list.sort((a, b) => a.start.isBefore(b.start) ? 1 : 0);
      map[date] = list;
    } else {
      map.putIfAbsent(date, () => [event]);
    }
  }

  static int getIndex(Map<DateTime, List<Event>> days, DateTime day) {
    if (days.keys.length == null || days.keys.isEmpty) return 0;

    return days.keys.toList().indexOf(day);
  }

  static DateTime removeTime(DateTime input) {
    return DateTime(input.year, input.month, input.day);
  }

  static DateTime removeDate(DateTime input) {
    return DateTime(input.hour, input.minute, input.second);
  }
}

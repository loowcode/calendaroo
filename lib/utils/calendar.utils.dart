import 'dart:collection';

import 'package:calendaroo/model/event.model.dart';

class CalendarUtils {
  static SplayTreeMap<DateTime, List<Event>> toMap(List<Event> events) {
    var result = SplayTreeMap<DateTime, List<Event>>();
    events.forEach((Event elem) {
      var first = CalendarUtils.removeTime(elem.start);
      var index = CalendarUtils.removeTime(elem.start);
      var last = CalendarUtils.removeTime(elem.end);
      for (var i = 0; i <= first.difference(last).inDays; i++) {
        _insertIntoStore(result, index, elem);
        index = index.add(Duration(days: 1));
      }
    });
    return result;
  }

  static void _insertIntoStore(
      SplayTreeMap<DateTime, List<Event>> map, DateTime date, Event event) {
    if (map.containsKey(date)) {
      var list = map[date];
      list.add(event);
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

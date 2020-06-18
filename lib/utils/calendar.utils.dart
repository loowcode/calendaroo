import 'dart:collection';

import 'package:calendaroo/model/event.model.dart';

class CalendarUtils {

  static Map<DateTime, List<Event>> toMap(List<Event> events) {
    SplayTreeMap<DateTime, List<Event>> result = SplayTreeMap();
    events.forEach((Event elem) {
      DateTime first = CalendarUtils.removeTime(elem.start);
      DateTime index = CalendarUtils.removeTime(elem.start);
      DateTime last = CalendarUtils.removeTime(elem.end);
      for (var i = 0; i <= first.difference(last).inDays; i++) {
        _insertIntoStore(result, index, elem);
        index = index.add(Duration(days: 1));
      }
    });
    return result;
  }

  static  _insertIntoStore(SplayTreeMap<DateTime, List<Event>>  map, date, event) {
    if (map.containsKey(date)) {
      var list = map[date];
      list.add(event);
      map[date] = list;
    } else {
      map.putIfAbsent(date, () => [event]);
    }
  }


  static int getIndex(Map<DateTime, List<Event>> days, DateTime day) {
    if (days.keys.length == null || days.keys.length == 0) return 0;
    
    return days.keys.toList().indexOf(day);
  }

  static  DateTime removeTime(DateTime input) {
    return DateTime(input.year, input.month, input.day);
  }

  static  DateTime removeDate(DateTime input) {
    return DateTime(input.hour, input.minute, input.second);
  }
}

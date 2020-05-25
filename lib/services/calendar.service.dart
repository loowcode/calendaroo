import 'dart:collection';

import 'package:calendaroo/constants.dart';
import 'package:calendaroo/environments/environment.dart';
import 'package:calendaroo/model/event.model.dart';
import 'package:calendaroo/model/mocks/eventsList.mock.dart';

class CalendarService {
  static final CalendarService _instance = CalendarService._();

  CalendarService._();

  factory CalendarService() {
    return _instance;
  }

  List<Event> eventsList() {
    if (Environment().environment == DEVELOP) {
      return eventsListMock;
    } else {
      return List<Event>();
    }
  }

  Map<DateTime, List<Event>> toMap(List<Event> events) {
    SplayTreeMap<DateTime, List<Event>> result = new SplayTreeMap();
    events.forEach((Event elem) {
      DateTime first = CalendarService().removeTime(elem.start);
      DateTime index = CalendarService().removeTime(elem.start);
      DateTime last = CalendarService().removeTime(elem.end);
      for (var i = 0; i <= first.difference(last).inDays; i++) {
        _insertIntoStore(result, index, elem);
        index = index.add(Duration(days: 1));
      }
    });
    return result;
  }

  _insertIntoStore(SplayTreeMap<DateTime, List<Event>>  map, date, event) {
    if (map.containsKey(date)) {
      var list = map[date];
      list.add(event);
      map[date] = list;
    } else {
      map.putIfAbsent(date, () => [event]);
    }
  }

//  SplayTreeMap<DateTime, List<Event>> toMapIndexed(List<Event> events) {
//    SplayTreeMap<DateTime, List<Event>> result = new SplayTreeMap();
//    var i = 0;
//    events.forEach((Event elem) {
//      var date = removeTime(elem.start);
//      var index = DateTime(i, date);
//      if (result.containsKey(index)) {
//        var list = result[index];
//        list.add(elem);
//        result[index] = list;
//      } else {
//        result.putIfAbsent(index, () => [elem]);
//      }
//      i++;
//    });
//    return result;
//  }

  int getIndex(Map<DateTime, List<Event>> days, DateTime day) {
    if (days.keys.length == null || days.keys.length == 0) return 0;
    
    return days.keys.toList().indexOf(day);
  }

  DateTime removeTime(DateTime input) {
    return DateTime(input.year, input.month, input.day);
  }

  DateTime removeDate(DateTime input) {
    return DateTime(input.hour, input.minute, input.second);
  }
}

import 'dart:collection';

import 'package:calendaroo/environments/environment.dart';
import 'package:calendaroo/model/event.model.dart';
import 'package:calendaroo/model/event-index.model.dart';
import 'package:calendaroo/model/mocks/eventsList.mock.dart';

class CalendarService {
  List<Event> eventsList() {
    if (Environment().environment == 'develop') {
      return eventsListMock;
    } else {
      return List<Event>();
    }
  }

  Map<DateTime, List<Event>> toMap(List<Event> events) {
    SplayTreeMap<DateTime, List<Event>> result = new SplayTreeMap();
    events.forEach((Event elem) {
//      var date = elem.start;
      var date = DateTime(elem.start.year, elem.start.month, elem.start.day);
      if (result.containsKey(date)) {
        var list = result[date];
        list.add(elem);
        result[date] = list;
      } else {
        result.putIfAbsent(date, () => [elem]);
      }
    });
    return result;
  }

  SplayTreeMap<EventIndex, List<Event>> toMapIndexed(List<Event> events) {
    SplayTreeMap<EventIndex, List<Event>> result = new SplayTreeMap();
    var i = 0;
    events.forEach((Event elem) {
      var date = removeTime(elem.start);
      var index = EventIndex(i, date);
      if (result.containsKey(index)) {
        var list = result[index];
        list.add(elem);
        result[index] = list;
      } else {
        result.putIfAbsent(index, () => [elem]);
      }
      i++;
    });
    return result;
  }

  int getIndex(Map<EventIndex, List<Event>> days, DateTime day) {
    if (days.keys.length == null || days.keys.length == 0) return 0;
    EventIndex index = days.keys.firstWhere((elem) {
      return elem.dateTime.compareTo(removeTime(day)) == 0;
    });
    return index.index;
  }

  DateTime removeTime(DateTime input) {
    return DateTime(input.year, input.month, input.day);
  }

  DateTime removeDate(DateTime input) {
    return DateTime(input.hour, input.minute, input.second);
  }
}

CalendarService calendarService = CalendarService();

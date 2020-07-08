import 'dart:collection';

import 'package:calendaroo/model/date.model.dart';
import 'package:calendaroo/model/event-instance.model.dart';
import 'package:calendaroo/model/event.model.dart';
import 'package:calendaroo/model/repeat.model.dart';
import 'package:uuid/uuid.dart';

class CalendarUtils {
  static SplayTreeMap<Date, List<EventInstance>> toMappedInstances(
      List<Event> events) {
    var map = SplayTreeMap<Date, List<EventInstance>>();
    events.forEach((Event event) {
      createInstance(event).forEach((elem) {
        var first = Date.convertToDate(elem.start);
        var index = Date.convertToDate(elem.start);
        var last = Date.convertToDate(elem.end);
        for (var i = 0; i <= first.difference(last).inDays; i++) {
          _insertIntoMap(map, index, elem);
          index = Date.convertToDate(index.add(Duration(days: 1)));
        }
      });
    });
    return map;
  }

  static SplayTreeMap<Date, List<EventInstance>> toNearMappedInstances(
      List<Event> events, Date rangeStart, Date rangeEnd) {
    var map = SplayTreeMap<Date, List<EventInstance>>();
    events.forEach((Event event) {
      createInstance(event).forEach((elem) {
        var first = Date.convertToDate(elem.start);
        var index = Date.convertToDate(elem.start);
        var last = Date.convertToDate(elem.end);
        for (var i = 0; i <= first.difference(last).inDays; i++) {
          _insertIntoMap(map, index, elem);
          index = Date.convertToDate(index.add(Duration(days: 1)));
        }
      });
    });
    return map;
  }

  static List<EventInstance> createInstance(Event event) {
    var instances = <EventInstance>[];
    var _uuid = Uuid();
    var first = CalendarUtils.removeTime(event.start);
    var index = CalendarUtils.removeTime(event.start);
    var last = CalendarUtils.removeTime(event.end);

    var daySpan = last.difference(first).inDays;
    for (var i = 0; i <= daySpan; i++) {
      var instance = EventInstance(
        id: null,
        uuid: _uuid.v4(),
        eventId: event.id,
        title: event.title,
        start: DateTime(
          index.year,
          index.month,
          index.day,
          i == 0 ? event.start.hour : 0,
          i == 0 ? event.start.minute : 0,
        ),
        end: DateTime(
          index.year,
          index.month,
          index.day,
          i == daySpan ? event.end.hour : 23,
          i == daySpan ? event.end.minute : 59,
        ),
      );
      instances.add(instance);
      index = index.add(Duration(days: 1));
    }
    return instances;
  }

  static List<EventInstance> createNearInstances(
      Event event, Date rangeStart, Date rangeEnd) {
    var instances = <EventInstance>[];
    var _uuid = Uuid();
    var first = CalendarUtils.removeTime(event.start);
    var index = CalendarUtils.removeTime(event.start);
    var last = CalendarUtils.removeTime(event.end);

    var daySpan = last.difference(first).inDays;
    for (var i = 0; i <= daySpan; i++) {
      if (index.isAfter(rangeStart) && index.isBefore(rangeEnd)) {
        var instance = EventInstance(
          id: null,
          uuid: _uuid.v4(),
          eventId: event.id,
          title: daySpan > 0
              ? '${event.title} (${i + 1}/${daySpan + 1})'
              : '${event.title}',
          start: DateTime(
            index.year,
            index.month,
            index.day,
            i == 0 ? event.start.hour : 0,
            i == 0 ? event.start.minute : 0,
          ),
          end: DateTime(
            index.year,
            index.month,
            index.day,
            i == daySpan ? event.end.hour : 23,
            i == daySpan ? event.end.minute : 59,
          ),
        );
        if (event.allDay) {
          instance.start = removeTime(instance.start);
          instance.end = instance.start.add(Duration(hours: 23, minutes: 59));
        }
        instances.add(instance);
        if (event.repeat.type != RepeatType.never) {
          var duplicator = instance.start;
          var span = instance.end.difference(instance.start);
          while (duplicator.isBefore(rangeEnd) &&
              duplicator.isBefore(event.until ?? rangeEnd)) {
            switch (event.repeat.type) {
              case RepeatType.daily:
                duplicator = duplicator.add(Duration(days: 1));
                break;
              case RepeatType.weekly:
                duplicator = duplicator.add(Duration(days: 7));
                break;
              case RepeatType.monthly:
                duplicator = DateTime(
                    duplicator.year, duplicator.month + 1, duplicator.day);
                break;
              case RepeatType.yearly:
                duplicator = DateTime(
                    duplicator.year + 1, duplicator.month, duplicator.day);
                break;
              case RepeatType.never:
                break;
            }

            instances.add(instance.copyWith(
                start: duplicator, end: duplicator.add(span)));
          }
        }
        index = index.add(Duration(days: 1));
      }
    }
    return instances;
  }

  static SplayTreeMap<Date, List<EventInstance>> toMap(
      List<EventInstance> events) {
    var map = SplayTreeMap<Date, List<EventInstance>>();
    events.forEach((EventInstance elem) {
      var first = Date.convertToDate(elem.start);
      var index = Date.convertToDate(elem.start);
      var last = Date.convertToDate(elem.end);
      for (var i = 0; i <= first.difference(last).inDays; i++) {
        _insertIntoMap(map, index, elem);
        index = Date.convertToDate(index.add(Duration(days: 1)));
      }
    });
    return map;
  }

  static void _insertIntoMap(SplayTreeMap<Date, List<EventInstance>> map,
      Date date, EventInstance event) {
    if (map.containsKey(date)) {
      var list = map[date];
      list.add(event);
      list.sort((a, b) => a.start.isBefore(b.start) ? 1 : 0);
      map[date] = list;
    } else {
      map.putIfAbsent(date, () => [event]);
    }
  }

  static int getIndex(Map<Date, List<EventInstance>> map, Date day) {
//    if (map.keys.length == null || map.keys.isEmpty) return 0;
    // TODO if no event go to near day with events
    return map.keys.toList().indexOf(day);
  }

  static DateTime removeTime(DateTime input) {
    return DateTime(input.year, input.month, input.day);
  }

  static DateTime removeDate(DateTime input) {
    return DateTime(input.hour, input.minute, input.second);
  }
}

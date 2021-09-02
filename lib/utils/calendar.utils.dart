import 'dart:collection';

import 'package:calendaroo/model/event-instance.model.dart';
import 'package:calendaroo/model/event.model.dart';
import 'package:calendaroo/model/repeat.model.dart';
import 'package:calendaroo/models/date.model.dart';
import 'package:flutter/cupertino.dart';
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
        if (event.repeat != Repeat.never) {
          var duplicator = instance.start;
          var span = instance.end.difference(instance.start);
          while (duplicator.isBefore(rangeEnd) &&
              duplicator.isBefore(event.until ?? rangeEnd)) {
            switch (event.repeat) {
              case Repeat.daily:
                duplicator = duplicator.add(Duration(days: 1));
                break;
              case Repeat.weekly:
                duplicator = duplicator.add(Duration(days: 7));
                break;
              case Repeat.monthly:
                duplicator = DateTime(
                    duplicator.year, duplicator.month + 1, duplicator.day);
                break;
              case Repeat.yearly:
                duplicator = DateTime(
                    duplicator.year + 1, duplicator.month, duplicator.day);
                break;
              case Repeat.never:
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

  static int getIndex(Map<Date, List<int>> map, Date day) {
    var list = map.keys.toList();
    var index = list.indexOf(day);
    if (index < 0) {
      for (var key in list) {
        if (day.isBefore(key)) {
          index = list.indexOf(key);
          break;
        }
      }
    }
    return index;
  }

  static DateTime removeTime(DateTime input) {
    return DateTime(input.year, input.month, input.day);
  }

  static DateTime removeDate(DateTime input) {
    return DateTime(1000, 1, 1, input.hour, input.minute, input.second);
  }

  static DateTime getFirstMondayInMonth({
    @required int month,
    @required int year,
  }) {
    var firstDayOfMonth = DateTime(year, month, 1);
    return firstDayOfMonth.add(Duration(
        days: (DateTime.daysPerWeek + 1 - firstDayOfMonth.weekday) %
            DateTime.daysPerWeek));
  }

  static int getWeekInMonth(Date input) {
    var firstMondayOfMonth = getFirstMondayInMonth(
      year: input.year,
      month: input.month,
    );

    return (input.day - firstMondayOfMonth.day) ~/ DateTime.daysPerWeek + 1;
  }
}

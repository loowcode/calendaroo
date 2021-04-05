import 'package:calendaroo/entities/calendar_item.entity.dart';
import 'package:calendaroo/models/date.model.dart';
import 'package:calendaroo/utils/calendar.utils.dart';
import 'package:sqflite/sqflite.dart';

import '../services/local_storage.service.dart';

class CalendarItemDao {
  Future<int> insertCalendarItem(CalendarItem calendarItem) async {
    var client = await LocalStorageService().db;

    return await client.insert(
      'calendar_item',
      calendarItem.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<int> updateCalendarItem(CalendarItem newCalendarItem) async {
    var client = await LocalStorageService().db;

    return client.update('calendar_item', newCalendarItem.toMap(),
        where: 'id = ?',
        whereArgs: [newCalendarItem.id],
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> deleteCalendarItem(int id) async {
    var client = await LocalStorageService().db;

    return client.delete('calendar_item', where: 'id = ?', whereArgs: [id]);
  }

  Future<CalendarItem> calendarItem(int id) async {
    var client = await LocalStorageService().db;
    final maps =
        await client.query('calendar_item', where: 'id = ?', whereArgs: [id]);

    return CalendarItem.fromMap(maps[0]);
  }

  Future<List<CalendarItem>> calendarItems(Date date) async {
    final client = await LocalStorageService().db;

    final repeatYear = date.year;
    final repeatMonth = date.month;
    final repeatWeek = CalendarUtils.getWeekInMonth(date);
    final repeatWeekDay = date.weekday;
    final repeatDay = date.day;
    final repeatFrom = date.toIso8601String();
    final repeatUntil = date.toIso8601String();

    List<Map<String, dynamic>> result = await client.rawQuery('''
    SELECT C.*
    FROM calendar_item_repeat CR
    LEFT JOIN calendar_item C ON CR.calendar_item_id = C.id
    WHERE C.id IS NOT NULL
    AND (repeat_year = ? OR repeat_year = '*')
    AND (repeat_month = ? OR repeat_month = '*')
    AND (repeat_week = ? OR repeat_week = '*')
    AND (repeat_weekday = ? OR repeat_weekday = '*')
    AND (repeat_day = ? OR repeat_day = '*')
    AND repeat_from <= ?
    AND (repeat_until IS NULL OR repeat_until >= ?); 
    ''', [
      repeatYear,
      repeatMonth,
      repeatWeek,
      repeatWeekDay,
      repeatDay,
      repeatFrom,
      repeatUntil,
    ]);

    return List.generate(result.length, (i) {
      return CalendarItem.fromMap(result[i]);
    });
  }

  Future<List<CalendarItem>> nearCalendarItems(
      Date rangeStart, Date rangeEnd) async {
    final client = await LocalStorageService().db;
    // final maps = await client.query('events',
    //     where: 'start > ? and end < ?',
    //     whereArgs: [rangeStart.toIso8601String(), rangeEnd.toIso8601String()]);
    final maps = await client.query('calendar_item');
    return List.generate(maps.length, (i) {
      return CalendarItem.fromMap(maps[i]);
    });
  }
}

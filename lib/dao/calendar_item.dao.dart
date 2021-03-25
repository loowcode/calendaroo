import 'package:calendaroo/model/date.model.dart';
import 'package:calendaroo/models/calendar_item.model.dart';
import 'package:sqflite/sqflite.dart';

import '../services/local-storage.service.dart';

class CalendarItemDao {
  Future<int> insertCalendarItem(CalendarItem calendarItem) async {
    var client = await LocalStorageService().db;

    return await client.insert(
      'events',
      calendarItem.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<int> updateCalendarItem(CalendarItem newCalendarItem) async {
    var client = await LocalStorageService().db;

    return client.update('events', newCalendarItem.toMap(),
        where: 'id = ?',
        whereArgs: [newCalendarItem.id],
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> deleteCalendarItem(int id) async {
    var client = await LocalStorageService().db;

    return client.delete('events', where: 'id = ?', whereArgs: [id]);
  }

  Future<CalendarItem> calendarItem(int id) async {
    var client = await LocalStorageService().db;
    final maps = await client.query('events', where: 'id = ?', whereArgs: [id]);

    return CalendarItem.fromMap(maps[0]);
  }

  Future<List<CalendarItem>> calendarItems() async {
    final client = await LocalStorageService().db;

    final maps = await client.query('events');
    return List.generate(maps.length, (i) {
      return CalendarItem.fromMap(maps[i]);
    });
  }

  Future<List<CalendarItem>> nearCalendarItems(Date rangeStart, Date rangeEnd) async {
    final client = await LocalStorageService().db;
    // final maps = await client.query('events',
    //     where: 'start > ? and end < ?',
    //     whereArgs: [rangeStart.toIso8601String(), rangeEnd.toIso8601String()]);
    final maps = await client.query('events');
    return List.generate(maps.length, (i) {
      return CalendarItem.fromMap(maps[i]);
    });
  }
}

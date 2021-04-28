import 'package:calendaroo/entities/calendar_item_repeat.entity.dart';
import 'package:sqflite/sqflite.dart';

import '../services/local_storage.service.dart';

class CalendarItemRepeatDao {
  Future<CalendarItemRepeat> findByCalendarItemId(int calendarItemId) async {
    var client = await LocalStorageService().db;
    final maps = await client.query(
      'calendar_item_repeat',
      where: 'calendar_item_id = ?',
      whereArgs: [calendarItemId],
    );

    return CalendarItemRepeat.fromMap(maps[0]);
  }

  Future<int> insert(CalendarItemRepeat calendarItemRepeat) async {
    var client = await LocalStorageService().db;

    return await client.insert(
      'calendar_item_repeat',
      calendarItemRepeat.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> delete(int id) async {
    var client = await LocalStorageService().db;

    return client.delete(
      'calendar_item_repeat',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}

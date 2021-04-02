import 'package:calendaroo/entities/calendar_item_repeat.entity.dart';
import 'package:sqflite/sqflite.dart';

import '../services/local_storage.service.dart';

class CalendarItemRepeatDao {
  Future<int> insert(CalendarItemRepeat calendarItemRepeat) async {
    var client = await LocalStorageService().db;

    return await client.insert(
      'calendar_item_repeat',
      calendarItemRepeat.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
}

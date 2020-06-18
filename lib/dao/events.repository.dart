import 'package:calendaroo/model/event.model.dart';
import 'package:sqflite/sqflite.dart';

import '../services/local-storage.service.dart';

class EventsRepository {
  Future<int> insertEvent(Event event) async {
    // Get a reference to the database.
    var client = await LocalStorageService().db;

    return await client.insert(
      'events',
      event.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<int> updateEvent(Event newEvent) async {
    var client = await LocalStorageService().db;
    return client.update('events', newEvent.toMap(),
        where: 'id = ?',
        whereArgs: [newEvent.id],
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> deleteEvent(int id) async {
    var client = await LocalStorageService().db;
    return client.delete('events', where: 'id = ?', whereArgs: [id]);
  }

  Future<Event> event(int id) async {
    var client = await LocalStorageService().db;
    final maps =
        await client.query('events', where: 'id = ?', whereArgs: [id]);
    return Event(
      id: maps[0]['id'] as int,
      title: maps[0]['title'] as String,
      uuid: maps[0]['uuid'] as String,
      description: maps[0]['description'] as String,
      start: DateTime.parse(maps[0]['start'] as String),
      end: DateTime.parse(maps[0]['end'] as String),
    );
  }

  Future<List<Event>> events() async {
    final client = await LocalStorageService().db;

    final maps = await client.query('events');
    return List.generate(maps.length, (i) {
      return Event(
        id: maps[i]['id'] as int,
        title: maps[i]['title'] as String,
        uuid: maps[i]['uuid'] as String,
        description: maps[i]['description'] as String,
        start: DateTime.parse(maps[i]['start'] as String),
        end: DateTime.parse(maps[i]['end'] as String),
      );
    });
  }
}

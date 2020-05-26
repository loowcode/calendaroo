import 'package:calendaroo/model/event.model.dart';
import 'package:sqflite/sqflite.dart';

import 'local-storage.service.dart';

class EventsRepository{

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
    final List<Map<String, dynamic>> maps = await client.query('events', where: 'id = ?', whereArgs: [id]);
    return Event(
      id: maps[0]['id'],
      title: maps[0]['title'],
      uuid: maps[0]['uuid'],
      description: maps[0]['description'],
      start: DateTime.parse(maps[0]['start']),
      end: DateTime.parse(maps[0]['end']),
    );
  }

  Future<List<Event>> events() async {
    final Database client = await LocalStorageService().db;

    final List<Map<String, dynamic>> maps = await client.query('events');
    return List.generate(maps.length, (i) {
      return Event(
        id: maps[i]['id'],
        title: maps[i]['title'],
        uuid: maps[i]['uuid'],
        description: maps[i]['description'],
        start: DateTime.parse(maps[i]['start']),
        end: DateTime.parse(maps[i]['end']),
      );
    });
  }

}
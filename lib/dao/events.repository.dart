import 'package:calendaroo/model/date.model.dart';
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
    final maps = await client.query('events', where: 'id = ?', whereArgs: [id]);

    return Event.fromMap(maps[0]);
  }

  Future<List<Event>> events() async {
    final client = await LocalStorageService().db;

    final maps = await client.query('events');
    return List.generate(maps.length, (i) {
      return Event.fromMap(maps[i]);
    });
  }

  Future<List<Event>> nearEvents(Date rangeStart, Date rangeEnd) async {
    final client = await LocalStorageService().db;
    // final maps = await client.query('events',
    //     where: 'start > ? and end < ?',
    //     whereArgs: [rangeStart.toIso8601String(), rangeEnd.toIso8601String()]);
    final maps = await client.query('events');
    return List.generate(maps.length, (i) {
      return Event.fromMap(maps[i]);
    });
  }
}

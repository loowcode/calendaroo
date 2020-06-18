import 'package:calendaroo/model/event-instance.model.dart';
import 'package:sqflite/sqflite.dart';

import '../services/local-storage.service.dart';

class EventInstanceRepository {
  Future<int> insertInstance(EventInstance instance) async {
    var client = await LocalStorageService().db;

    return await client.insert(
      'eventInstances',
      instance.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<int> updateInstance(EventInstance newInstance) async {
    var client = await LocalStorageService().db;
    return client.update('eventInstances', newInstance.toMap(),
        where: 'id = ?',
        whereArgs: [newInstance.id],
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> deleteInstance(int id) async {
    var client = await LocalStorageService().db;
    return client.delete('eventInstances', where: 'id = ?', whereArgs: [id]);
  }

  Future<EventInstance> instance(int id) async {
    var client = await LocalStorageService().db;
    final maps =
        await client.query('eventInstances', where: 'id = ?', whereArgs: [id]);
    return EventInstance(
      id: maps[0]['id'] as int,
      uuid: maps[0]['uuid'] as String,
      eventId: maps[0]['eventId'] as int,
      start: DateTime.parse(maps[0]['start'] as String),
      end: DateTime.parse(maps[0]['end'] as String),
    );
  }

  Future<List<EventInstance>> Instances() async {
    final client = await LocalStorageService().db;

    final maps = await client.query('eventInstances');
    return List.generate(maps.length, (i) {
      return EventInstance(
        id: maps[i]['id'] as int,
        uuid: maps[i]['uuid'] as String,
        eventId: maps[i]['eventId'] as int,
        start: DateTime.parse(maps[i]['start'] as String),
        end: DateTime.parse(maps[i]['end'] as String),
      );
    });
  }
}

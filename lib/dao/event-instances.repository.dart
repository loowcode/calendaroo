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
    final List<Map<String, dynamic>> maps =
        await client.query('eventInstances', where: 'id = ?', whereArgs: [id]);
    return EventInstance(
      id: maps[0]['id'],
      uuid: maps[0]['uuid'],
      eventId: maps[0]['eventId'],
      start: DateTime.parse(maps[0]['start']),
      end: DateTime.parse(maps[0]['end']),
    );
  }

  Future<List<EventInstance>> Instances() async {
    final Database client = await LocalStorageService().db;

    final List<Map<String, dynamic>> maps = await client.query('eventInstances');
    return List.generate(maps.length, (i) {
      return EventInstance(
        id: maps[i]['id'],
        uuid: maps[i]['uuid'],
        eventId: maps[0]['eventId'],
        start: DateTime.parse(maps[i]['start']),
        end: DateTime.parse(maps[i]['end']),
      );
    });
  }
}

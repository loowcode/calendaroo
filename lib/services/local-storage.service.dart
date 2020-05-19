import 'dart:async';
import 'dart:io';

import 'package:calendaroo/constants.dart';
import 'package:calendaroo/environments/environment.dart';
import 'package:calendaroo/model/event.model.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class LocalStorageService {
  static final LocalStorageService _instance = LocalStorageService._();
  static Database _database;

  static const int DB_VERSION = 1;

  LocalStorageService._();

  factory LocalStorageService() {
    return _instance;
  }

  Future<Database> get db async {
    if (_database != null) {
      return _database;
    }
    _database = await _init();

    return _database;
  }

  Future<Database> _init() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String dbPath = join(directory.path, 'database.db');
    var database = openDatabase(dbPath,
        version: DB_VERSION,
        onConfigure: _onConfigure,
        onCreate: _onCreate,
        onUpgrade: _onUpgrade);
    return database;
  }

  FutureOr<void> _onCreate(Database db, int version) async {
    await db.execute('''
    CREATE TABLE events(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      title TEXT,
      uuid TEXT,
      description TEXT,
      start TEXT,
      end TEXT
      )
  ''');
    print("Database was created!");
  }

  void _onUpgrade(Database db, int oldVersion, int newVersion) async {
    // Run migration according database versions
    for (var i = oldVersion - 1; i <= newVersion - 1; i++) {
//      await db.execute(migrationScripts[i]);
    }
  }

  // TODO creare repository Event
  Future<int> insertEvent(Event event) async {
    // Get a reference to the database.
    var client = await db;

    return await client.insert(
      'events',
      event.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<int> updateEvent(Event newEvent) async {
    var client = await db;
    return client.update('events', newEvent.toMap(),
        where: 'id = ?',
        whereArgs: [newEvent.id],
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> deleteEvent(int id) async {
    var client = await db;
    return client.delete('events', where: 'id = ?', whereArgs: [id]);
  }

  Future<List<Event>> events() async {
    final Database client = await db;

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

  FutureOr<void> _onConfigure(Database db) async {
    var env = Environment().environment;
    if (env == DEVELOP) {
      await db.execute("drop table if exists events");
      _onCreate(db, DB_VERSION);
      print('DB deleted');
    }
  }
}

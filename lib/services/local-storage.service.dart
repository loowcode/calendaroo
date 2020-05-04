import 'dart:io';
import 'dart:async';
import 'package:calendaroo/model/event.dart';
import 'package:path/path.dart';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class LocalStorageService {
  static final LocalStorageService _instance = LocalStorageService._();
  static Database _database;

  LocalStorageService._();

  factory LocalStorageService() {
    return _instance;
  }

  Future<Database> get db async {
    if (_database != null) {
      return _database;
    }
    _database = await init();

    return _database;
  }

  Future<Database> init() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String dbPath = join(directory.path, 'database.db');
    var database = openDatabase(dbPath,
        version: 1, onCreate: _onCreate, onUpgrade: _onUpgrade);
    return database;
  }

  void _onCreate(Database db, int version) {
    db.execute('''
    CREATE TABLE event(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      title TEXT,
      description TEXT,
      )
  ''');
    print("Database was created!");
  }

  void _onUpgrade(Database db, int oldVersion, int newVersion) async{
    // Run migration according database versions
    for (var i = oldVersion - 1; i <= newVersion - 1; i++) {
//      await db.execute(migrationScripts[i]);
    }
  }

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
    return client.update('event', newEvent.toMap(),
        where: 'id = ?',
        whereArgs: [newEvent.id],
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> deleteEvent(int id) async {
    var client = await db;
    return client.delete('event', where: 'id = ?', whereArgs: [id]);
  }
}

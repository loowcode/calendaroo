import 'dart:async';

import 'package:flutter/cupertino.dart';
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
    var directory = await getApplicationDocumentsDirectory();
    var dbPath = join(directory.path, 'database.db');
    var database = openDatabase(dbPath,
        version: DB_VERSION,
        onConfigure: _onConfigure,
        onCreate: _onCreate,
        onUpgrade: _onUpgrade);
    return database;
  }

  FutureOr<void> _onCreate(Database db, int version) async {
    try {
      await createTable(db);
      debugPrint('Database was created!');
    } catch (e) {
      debugPrint('error during creation db: ${e.toString()}');
    }
  }

  Future createTable(Database db) async {
    await db.execute('''create TABLE events(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          title TEXT,
          uuid TEXT,
          description TEXT,
          start TEXT,
          end TEXT,
          allDay INTEGER,
          repeat INTEGER,
          until TEXT,
          alarms TEXT
      );''');
    await db.execute('''create TABLE eventInstances(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        uuid TEXT,
        eventId INTEGER NOT NULL,
        start TEXT,
        end TEXT,
        FOREIGN KEY (eventId) REFERENCES events (id)
          ON DELETE NO ACTION ON UPDATE NO ACTION
    );''');
  }

  void _onUpgrade(Database db, int oldVersion, int newVersion) async {
    // Run migration according database versions
    for (var i = oldVersion - 1; i <= newVersion - 1; i++) {
//      await db.execute(migrationScripts[i]);
    }
  }

  FutureOr<void> _onConfigure(Database db) async {
//    try {
//      var env = Environment().environment;
//      if (env == DEVELOP) {
//        await db.execute("drop table if exists events;");
//        await db.execute("drop table if exists eventInstances;");
//        debugPrint('DB deleted');
//      }
//    } catch (e) {
//      debugPrint("error during drop db: ${e.toString()}");
//    }
  }

  FutureOr<void> dropTable(Database db) async {
    await db.execute('drop table if exists events;');
    await db.execute('drop table if exists eventInstances;');
    await createTable(db);
  }
}

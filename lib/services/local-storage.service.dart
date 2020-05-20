import 'dart:async';
import 'dart:io';

import 'package:calendaroo/constants.dart';
import 'package:calendaroo/environments/environment.dart';
import 'package:calendaroo/model/event.model.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/services.dart' show rootBundle;

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
    String sql = await rootBundle.loadString('assets/resources/create-db.sql');
    await db.execute(sql);
    print("Database was created!");
  }

  void _onUpgrade(Database db, int oldVersion, int newVersion) async {
    // Run migration according database versions
    for (var i = oldVersion - 1; i <= newVersion - 1; i++) {
//      await db.execute(migrationScripts[i]);
    }
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

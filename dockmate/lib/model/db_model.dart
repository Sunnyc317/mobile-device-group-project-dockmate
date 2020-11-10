import 'dart:async';
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart';

class DBModel {
  var database;

  Future<Database> init() async {
    this.database =
        await openDatabase(path.join(await getDatabasesPath(), 'dockmate.db'),
            onCreate: (db, version) {
      db.execute(
          'CREATE TABLE listings (id INTEGER PRIMARY KEY, title TEXT, address TEXT, city TEXT, province TEXT, country TEXT, pet TEXT, parking TEXT, bedroom TEXT, bathroom TEXT, description TEXT, duration TEXT, price TEXT, public TEXT, status TEXT, mainImage TEXT');
    }, version: 1);
    print("Create table called");
  }

  Future<void> insertDB(String tableName, var obj) async {
    if (this.database == null) {
      await init();
    }
    await database.insert(tableName, obj.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> updateDB(String tableName, var obj) async {
    if (this.database == null) {
      await init();
    }

    await database
        .update(tableName, obj.toMap(), where: 'id = ?', whereArgs: [obj.id]);
  }

  Future<void> deleteDB(String tableName, int id) async {
    if (this.database == null) {
      await init();
    }

    await database.delete(
      tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}

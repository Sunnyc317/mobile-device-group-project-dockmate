import 'dart:async';
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart';

class DBModel {
  var database;

  Future<Database> init() async {
    this.database =
        await openDatabase(path.join(await getDatabasesPath(), 'dockmate.db'),
            onCreate: (db, version) {
      // CREATE MULTIPLE TABLE
      /*db.execute(
          'CREATE TABLE listing (id INTEGER PRIMARY KEY, sid TEXT, grade TEXT');*/
    }, version: 1);
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

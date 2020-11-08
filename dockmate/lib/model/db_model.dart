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

  Future<void> insertDB(String table_name, var obj) async {
    if (this.database == null) {
      await init();
    }
    await database.insert(table_name, obj.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> updateDB(String table_name, var obj) async {
    if (this.database == null) {
      await init();
    }

    await database
        .update(table_name, obj.toMap(), where: 'id = ?', whereArgs: [obj.id]);
  }

  Future<void> deleteDB(String table_name, int id) async {
    if (this.database == null) {
      await init();
    }

    await database.delete(
      table_name,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}

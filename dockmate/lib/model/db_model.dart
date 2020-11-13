import 'dart:async';
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart';
import 'package:dockmate/model/username.dart';

class DBModel {
  var database;

  Future<Database> init() async {
    this.database =
        await openDatabase(path.join(await getDatabasesPath(), 'dockmate.db'),
            onCreate: (db, version) {
      db.execute(
          //'CREATE TABLE listings (id INTEGER PRIMARY KEY, title TEXT, address TEXT, city TEXT, province TEXT, country TEXT, pet TEXT, parking TEXT, bedroom TEXT, bathroom TEXT, description TEXT, duration TEXT, price TEXT, public TEXT, status TEXT, mainImage TEXT');
          'CREATE TABLE usernames(id INTEGER PRIMARY KEY AUTO INCREMENT, username TEXT)');
    }, version: 1);
    print("Create table called");
  }

  Future<List> getAll() async {
    print("on get all");
    final db = await init();
    final List<Map<String, String>> names = await db.query('usernames');
    List result = [];
    if (names.length > 0) {
      for (int i = 0; i < names.length; i++) {
        result.add(Username.fromMap(names[i]));
      }
    }
    return result;
  }

  Future<void> getName() async {
    print("on get name");
    List names = await getAll();
    return names[names.length]['usernames'];
  }

  Future<void> insertDB(String tableName, var obj) async {
    print("Inserting to DB");
    if (this.database == null) {
      await init();
    }
    await database.insert('usernames', obj.toMap(),
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

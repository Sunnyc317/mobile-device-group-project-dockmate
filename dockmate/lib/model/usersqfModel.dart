import 'dart:async';
import 'package:sqflite/sqflite.dart';

import 'package:dockmate/utils/dbUtils.dart';
import 'user.dart';
// import 'package:dockmate/model/user.dart';

class UserModel {
  Future<int> insertUser(User u) async {
    final db = await DBUtils.init();
    print('user inserted');
    return db.insert(
      'user',
      u.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<bool> idNotExist(String id) async {
    final db = await DBUtils.init();
    final List<Map<String, dynamic>> maps = await db.query(
      'user',
      where: 'firebaseID = ?',
      whereArgs: [id],
    );
    if (maps.length == 0) {
      return true;
    }
    return false;
  }

  Future<List<Map<String, dynamic>>> getUserWithId(String id) async {
    final db = await DBUtils.init();
    final List<Map<String, dynamic>> maps = await db.query(
      'user',
      // where: 'firebaseID = ?',
      // whereArgs: [id],
    );
    // User user = User.fromMap(maps[0]);
    return maps;
  }

  Future<void> updateUser(User u) async {
    final db = await DBUtils.init();
    return db.update('user', u.toMap(), where: 'firebaseID = ?', whereArgs: [u.id]);
  }

  Future<void> deleteUser(int id) async {
    final db = await DBUtils.init();
    return db.delete('user', where: 'id = ?', whereArgs: [id]);
  }

  Future<void> deleteAllUser() async {
    final db = await DBUtils.init();
    return db.delete('user');
  }

  

  // Future<List<User>> getAllRoutes() async {
  //   final db = await DBUtils.init();
  //   final List<Map<String, dynamic>> returnMap = await db.query('myRoute');
  //   List<MyRoute> result = [];

  //   if (returnMap.length > 0) {
  //     for (int i = 0; i < returnMap.length; i++) {
  //       result.add(MyRoute.fromMap(returnMap[i]));
  //     }
  //     print(result);
  //   }

  //   return result;
  // }

  
}

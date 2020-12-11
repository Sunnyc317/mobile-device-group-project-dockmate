import 'dart:async';
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart';

class DBUtils {
  static Future<Database> init() async {
    var database = openDatabase(
      path.join(await getDatabasesPath(), 'user.db'),
      onCreate: (db, version) {
        db.execute("CREATE TABLE user(" +
            "id INTEGER PRIMARY KEY AUTOINCREMENT, " +
            "firebaseID TEXT, " +
            "firstname TEXT, " +
            "lastname TEXT, " +
            "email TEXT" +
            "notifON INTEGER DEFAULT 1, " +
            "wantHouseTypes TEXT, " +
            "phone TEXT, " +
            "country TEXT" +
            "province TEXT" +
            ")");
        // db.execute("CREATE TABLE preference(" +
        //     "id INTEGER PRIMARY KEY AUTOINCREMENT, " +
        //     "doorHoldT TEXT, " +
        //     "buildings TEXT " +
        //     ")");
      },
      version: 2,
    );
    return database;
  }
}

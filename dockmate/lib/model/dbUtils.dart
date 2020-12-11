import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as path;

class DBUtils {
  /*
   * Setting up SQLite, code adapted from Lecture example
   */
  static Future<Database> init() async {
    var database = openDatabase(
      path.join(await getDatabasesPath(), 'dockmate.db'),
      onCreate: (db, version) {
        db.execute(
            'CREATE TABLE usernames(id INTEGER AUTO INCREMENT, username TEXT)');
      },
      version: 1,
    );
    return database;
  }
}

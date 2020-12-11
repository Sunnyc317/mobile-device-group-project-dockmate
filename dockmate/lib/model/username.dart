import 'package:dockmate/model/dbUtils.dart';
import 'package:sqflite/sqflite.dart';

class Username {
  // Very simple username object to mimic session storage
  int id;
  String username;

  Username({this.id, this.username});

  Username.fromMap(map) {
    this.id = map['id'];
    this.username = map['username'];
  }

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'username': this.username,
    };
  }
}

class UsernameModel {
  // Used to access SQFLite that stores current user name
  getUsername() async {
    //just always get the latest one
    final db = await DBUtils.init();
    final userMap = await db.query('usernames');
    var allUsernames = [];
    if (userMap.length > 0) {
      for (int i = 0; i < userMap.length; i++) {
        allUsernames.add(Username.fromMap(userMap[i]));
      }
    }
    return allUsernames[userMap.length - 1];
  }

  setUsername(String username) async {
    final db = await DBUtils.init();
    await db.insert(
      'usernames',
      Username(username: username).toMap(),
      conflictAlgorithm: ConflictAlgorithm.abort,
    );
  }
}

import 'package:flutter/material.dart';
import 'db_model.dart';
import 'user.dart';

class Listing {
  int id;
  User op;
  Image mainIimage;
  List<Image> images;
  DateTime date;
  String title;
  String address;
  String city;
  String postalCode;
  String province;
  String country;
  String description;
  String price;
  String bedroom;
  int bathroom;
  bool isParkingAvail;
  bool isPetFriendly;
  bool isPublic;

  Listing();

  Listing.fromMap(Map<String, dynamic> map) {
    //this.id = map['id'];
  }

  Map<String, dynamic> toMap() {
    return {
      //'id': this.id,
    };
  }

  String toString() {
    //return 'Grade(id:$id, sid:$sid, grade$grade)';
  }

  Future<void> insertGrade(Listing list) async {
    DBModel().insertDB("listings", list);
  }

  Future<List<Listing>> getAllListings() async {
    final database = await DBModel().init();

    final List<Map<String, dynamic>> maps = await database.query('listings');
    List<Listing> result = [];
    if (maps.length > 0) {
      for (int i = 0; i < maps.length; i++) {
        result.add(Listing.fromMap(maps[i]));
      }
    }
    return result;
  }
}

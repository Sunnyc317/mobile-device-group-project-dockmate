// import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:core';
import 'package:dockmate/model/listing.dart';
import 'package:dockmate/model/message.dart';
import 'package:dockmate/model/db_model.dart';

class User {
  // DocumentReference id;
  String id;
  String first_name;
  String last_name;
  String email;
  String phone;
  // String password; // need to encrypt
  String address;
  String city;
  String postal_code;
  String province;
  String country;
  bool landlord;
  List<String> wantHouseTypes;
  // Not sure about the following yet
  List<Listing> my_listings;
  List<Listing> saved_listings;
  List<Message> messages; // Im not sure what the format on this yet....
  // Something about preference
  // Type of housing
  // Postal code they're looking for?

  User({this.id}) {}

  User.fromMap(Map<String, dynamic> map) {
    this.id = map['id'];
  }

  Map<String, dynamic> toMap() {
    return {'id': this.id};
  }

  List<User> result = [];
  Future<List<User>> getAllUsers() async {
    final database = await DBModel().init();

    final List<Map<String, dynamic>> maps = await database.query('users');
    if (maps.length > 0) {
      for (int i = 0; i < maps.length; i++) {
        result.add(User.fromMap(maps[i]));
      }
    }
    return result;
  }

  String getUser() {
    //getAllUsers();
    //return result[0].id;
    return id;
  }
}

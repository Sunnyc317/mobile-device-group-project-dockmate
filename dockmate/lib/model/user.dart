// import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:core';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dockmate/model/listing.dart';
import 'package:dockmate/model/message.dart';
import 'package:dockmate/model/db_model.dart';

class User {
  DocumentReference reference;
  String id;
  String first_name;
  String last_name;
  String email;
  var profile_pic;
  bool emailvarified = false;
  List<String> wantHouseTypes;
  String phone;
  // String address;
  // String city;
  // String postal_code;
  // String province;
  // String country;
  // bool landlord;
  // Not sure about the following yet
  List<Listing> my_listings;
  List<Listing> saved_listings;
  List<Message> messages; // Im not sure what the format on this yet....
  // Something about preference
  // Type of housing
  // Postal code they're looking for?

  //temporary for chat purposes
  User({this.id});
  User.chat({this.first_name, this.last_name});

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


  void setname(String username) {
    this.first_name = username.splitMapJoin(' ')[0];
    this.last_name = username.splitMapJoin(' ')[1];
  }
  void setemailvarified(bool emailvarified) {this.emailvarified = emailvarified;}
  void setprofilepic(var profile_pic) {this.profile_pic = profile_pic;}
  void setemail(String email) {this.email = email;}
  void setphone(String phone) {this.phone = phone;}

  String getUser() {
    //getAllUsers();
    //return result[0].id;
    return id;
  }
  @override
  String toString() {
    // TODO: implement toString
    return super.toString();
  }
}

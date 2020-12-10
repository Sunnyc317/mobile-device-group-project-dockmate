// import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:core';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dockmate/model/listing.dart';
import 'package:dockmate/model/message.dart';

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
  List<Listing> my_listings;
  List<Listing> saved_listings;
  List<Message> messages;

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

  void setname(String username) {
    this.first_name = username.splitMapJoin(' ')[0];
    this.last_name = username.splitMapJoin(' ')[1];
  }

  void setemailvarified(bool emailvarified) {
    this.emailvarified = emailvarified;
  }

  void setprofilepic(var profile_pic) {
    this.profile_pic = profile_pic;
  }

  void setemail(String email) {
    this.email = email;
  }

  void setphone(String phone) {
    this.phone = phone;
  }

  String getUser() {
    //getAllUsers();
    //return result[0].id;
    return id; // temporary for my listing purposes
  }

  @override
  String toString() {
    return super.toString();
  }
}

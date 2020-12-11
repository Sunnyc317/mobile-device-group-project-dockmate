// import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:core';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dockmate/model/listing.dart';
import 'package:dockmate/model/message.dart';

class User {
  String id; 
  int sqfid;
  String first_name = 'nofirstname';
  String last_name = 'nolastname';
  String email;
  bool notifON = true;
  // bool emailvarified = false;
  List<String> wantHouseTypes;
  String phone;
  String province;
  String country;
  // bool landlord;
  // List<Listing> my_listings;
  // List<Listing> saved_listings;
  // List<Message> messages; // Im not sure what the format on this yet....
  //temporary for chat purposes
  User({this.id});
  User.chat({this.first_name, this.last_name});

  User.fromMap(Map<String, dynamic> map) {
    this.sqfid = map['id'];
    this.id = map['firebaseID'];
    this.first_name = map['firstname'];
    this.last_name = map['lastname'];
    this.email = map['email'];
    if(map['notifON']==1) {this.notifON=true;} else {this.notifON=false;}
    this.notifON = map['notifON'];
    this.phone = map['phone'];
    this.wantHouseTypes = map['wantHouseType'].split(',');
    this.country = map['country'];
    this.province = map['province'];
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'firstname': this.first_name,
      'lastname': this.last_name,
      'id': this.sqfid,
      'firebaseID': this.id,
      'email': this.email,
      'notifON': this.notifON ? 1 : 0,
      'phone': this.phone,
      'wantHouseTypes': this.wantHouseTypes,
      'province': this.province,
      'country': this.country
    };
    return map;
  }

  List<User> result = [];

  void setname(String username) {
    this.first_name = username.splitMapJoin(' ')[0];
    this.last_name = username.splitMapJoin(' ')[1];
  }
  void setemail(String email) {this.email = email;}
  void setphone(String phone) {this.phone = phone;}

  String getUser() {
    return id;
  }

  @override
  String toString() {
    // TODO: implement toString
    return super.toString();
  }
}

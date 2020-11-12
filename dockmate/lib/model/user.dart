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
  String password;
  String email;
  String phone;
  // String password; // need to encrypt
  String address;
  String city;
  String postal_code;
  String province;
  String country;
  bool landlord;
  List<String> preferedHouseTypes;
  // Not sure about the following yet
  List<Listing> my_listings;
  List<Listing> saved_listings;
  List<Message> messages; // Im not sure what the format on this yet....
  // Something about preference
  // Type of housing
  // Postal code they're looking for?

  // User({this.uid, this.first_name, this.last_name, this.email, this.phone, this.password});
  User({this.id});

  User.fromMap(Map<String, dynamic> map, {this.reference}) {

    this.id = map['id'];
    this.first_name = map['first_name'];
    this.last_name = map['last_name'];
    this.email = map['email'];
    this.phone = map['phone'];
    this.password = map['password'];
    this.address = map['address'];
    this.city = map['city'];
    this.postal_code = map['postal_code'];
    this.province = map['province'];
    this.country = map['country'];
    this.landlord = map['landlord'];
    this.preferedHouseTypes = map['preferedHouseTypes'];
    // this.my_listings = map['my_listings'];
    // this.saved_listings = map['saved_listings'];
    // this.messages = map['messages'];
  }

  Map<String, dynamic> toMap() {
    return {
      'id' : this.id,
      'first_name' : this.first_name,
      'last_name': this.last_name,
      'email' : this.email,
      'phone' : this.phone,
      'password' : this.password,
      'address' : this.address,
      'city' : this.city,
      'postal_code' : this.postal_code,
      'province' : this.province,
      'country' : this.country, 
      'landlord' : this.landlord, 
      'preferedHouseTypes' : this.preferedHouseTypes, 
      // 'my_listings' : this.my_listings, 
      // 'saved_listings' : this.saved_listings, 
      // 'messages' : this.messages
    };
  }

  @override
  String toString() {
    // TODO: implement toString
    return 'first name: $first_name';}

  //temporary for chat purposes
  User.chat({this.first_name, this.last_name});


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

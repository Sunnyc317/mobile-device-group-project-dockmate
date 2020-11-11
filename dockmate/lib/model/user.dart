import 'dart:core';
import 'package:dockmate/model/listing.dart';
import 'package:flutter/material.dart';
import 'listing.dart';
import 'message.dart';

class User {
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
}

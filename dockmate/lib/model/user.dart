import 'dart:core';

class User {
  String id;
  int sqfid;
  String first_name = 'nofirstname';
  String last_name = 'nolastname';
  String email;
  bool notifON = true;
  List<String> wantHouseTypes;
  String phone;
  String province;
  String country;

  User({this.id});
  User.chat({this.first_name, this.last_name});

  User.fromMap(Map<String, dynamic> map) {
    this.sqfid = map['id'];
    this.id = map['firebaseID'];
    this.first_name = map['firstname'];
    this.last_name = map['lastname'];
    this.email = map['email'];
    if (map['notifON'] == 1) {
      this.notifON = true;
    } else {
      this.notifON = false;
    }
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

  void setemail(String email) {
    this.email = email;
  }

  void setphone(String phone) {
    this.phone = phone;
  }

  String getUser() {
    return id;
  }

  @override
  String toString() {
    return super.toString();
  }
}

import 'package:dockmate/model/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Listing {
  DocumentReference reference;
  String id;
  User owner;
  // String because we might use the firestore link
  String mainImage;
  List<String> images;
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
  String bathroom;
  String duration;
  String status;
  bool isParkingAvail;
  bool isPetFriendly;
  bool isPublic;
  String userID;
  DateTime timestamp;

  FirebaseFirestore _db = FirebaseFirestore.instance;

  Listing(
      {this.id,
      this.mainImage,
      this.title,
      this.address,
      this.city,
      this.postalCode,
      this.province,
      this.country,
      this.description,
      this.price,
      this.bedroom,
      this.bathroom,
      this.status,
      this.isParkingAvail,
      this.isPetFriendly,
      this.isPublic,
      this.userID,
      this.duration});

  factory Listing.fromMap(
      Map<String, dynamic> map, DocumentReference reference) {
    return Listing(
        id: map['id'],
        mainImage: map['mainImage'],
        title: map['title'],
        address: map['address'],
        city: map['city'],
        postalCode: map['postalCode'],
        province: map['province'],
        country: map['country'],
        description: map['description'],
        price: map['price'],
        bedroom: map['bedroom'],
        bathroom: map['bathroom'],
        status: map['status'],
        isParkingAvail: map['parking'],
        isPetFriendly: map['petFriendly'],
        isPublic: map['public'],
        userID: map['userID'],
        duration: map['duration']);
  }

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'mainImage': this.mainImage,
      'title': this.title,
      'address': this.address,
      'city': this.city,
      'postalCode': this.postalCode,
      'province': this.province,
      'country': this.country,
      'description': this.description,
      'price': this.price,
      'bedroom': this.bedroom,
      'bathroom': this.bathroom,
      'status': this.status,
      'parking': this.isParkingAvail,
      'petFriendly': this.isPetFriendly,
      'public': this.isPublic,
      'userID': this.userID,
      'duration': this.duration
    };
  }

  Future<void> insert(Listing list) async {
    var merge = SetOptions(merge: true);
    return _db.collection('listings').doc(list.id).set(list.toMap(), merge);
  }

  Future<void> delete(String id) async {
    return _db.collection('listings').doc(id).delete();
  }

  Stream<List<Listing>> getAllListings() {
    return _db.collection('listings').snapshots().map((snapshot) => snapshot
        .docs
        .map((doc) => Listing.fromMap(doc.data(), doc.reference))
        .toList());
  }
}

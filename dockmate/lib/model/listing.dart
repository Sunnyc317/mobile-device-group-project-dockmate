//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dockmate/model/db_model.dart';
import 'package:dockmate/model/user.dart';

class Listing {
  //DocumentReference id;
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

  // TEMPORARILY USING LOCAL STORAGE FOR WIDGET TESTING
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

  Listing.fromMap(Map<String, dynamic> map) {
    this.id = map['id'];
    this.mainImage = map['mainImage'];
    this.title = map['title'];
    this.address = map['address'];
    this.city = map['city'];
    this.postalCode = map['postalCode'];
    this.province = map['province'];
    this.country = map['country'];
    this.description = map['description'];
    this.price = map['price'];
    this.bedroom = map['bedroom'];
    this.bathroom = map['bathroom'];
    this.status = map['status'];
    this.isParkingAvail = map['parking'];
    this.isPetFriendly = map['pet'];
    this.isPublic = map['public'];
    this.userID = map['userID'];
    this.duration = map['duration'];
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
      'bahroom': this.bathroom,
      'status': this.status,
      'parking': this.isParkingAvail,
      'pet': this.isPetFriendly,
      'public': this.isPublic,
      'userID': this.userID,
      'duration': this.duration
    };
  }

  String toString() {}

  Future<void> insert(Listing list) async {
    DBModel().insertDB("listings", list);
  }

  Future<List<Listing>> getAllListings() async {
    //final database = await DBModel().init();

    //final List<Map<String, dynamic>> maps = await database.query('listings');
    List<Listing> result = [];
    Listing list1 = Listing(
        id: "1",
        mainImage:
            "https://d2kcmk0r62r1qk.cloudfront.net/imageSponsors/xlarge/2015_09_14_01_36_04_stanleycondos_rendering5.jpg",
        title: "1 bedroom",
        address: "1800 Simcoe St. North",
        city: "Oshawa",
        postalCode: "L1G 3Z2",
        province: "ON",
        country: "CA",
        description: "hello!!",
        price: "500",
        bedroom: "2",
        bathroom: "1",
        status: "Available",
        isParkingAvail: true,
        isPetFriendly: false,
        isPublic: true,
        userID: "1",
        duration: "4 months");
    result.add(list1);

    Listing list2 = Listing(
        id: "2",
        mainImage:
            "https://www.royalhomepainterstoronto.ca/wp-content/uploads/2018/12/condo-renovation-service-vaughan-toronto.jpg",
        title: "2 bedroom 1 den",
        address: "1900 Simcoe St. North",
        city: "Oshawa",
        postalCode: "L1G 3Z2",
        province: "ON",
        country: "CA",
        description: "hey!!",
        price: "450",
        bedroom: "2+1",
        bathroom: "2",
        status: "Available",
        isParkingAvail: false,
        isPetFriendly: true,
        isPublic: true,
        userID: "2",
        duration: "1 year");
    result.add(list2);
    /*if (maps.length > 0) {
      for (int i = 0; i < maps.length; i++) {
        result.add(Listing.fromMap(maps[i]));
      }
    }*/
    return result;
  }
}

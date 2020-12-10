import 'package:flutter/material.dart';
import 'package:dockmate/model/listing.dart';

Widget buildListRow(Listing listing, Row rows) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Row(children: <Widget>[
        Container(
          margin: EdgeInsets.only(left: 10.0, right: 15.0),
          child: Container(
              width: 250,
              child: Text(
                listing.title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              )),
        ),
        rows,
      ]),
      Container(
        margin: EdgeInsets.symmetric(horizontal: 5),
        padding: EdgeInsets.all(5.0),
        child: Text(listing.address),
      ),
      Container(
          margin: EdgeInsets.symmetric(horizontal: 10),
          child: Image.network(listing.mainImage,
              height: 200, width: 350, fit: BoxFit.fill)),
      Container(
          padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
          child: Row(
            children: <Widget>[
              Text("\$" + listing.price + "/",
                  style: TextStyle(
                      color: Colors.blue,
                      fontSize: 20,
                      fontWeight: FontWeight.bold)),
              Container(
                  margin: EdgeInsets.only(top: 5.3),
                  child: Text("mth",
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ))),
            ],
          )),
      Container(
        margin: EdgeInsets.only(left: 146.0, right: 146.0, top: 10.0),
        height: 1.0,
        width: 80.0,
        color: Colors.grey,
      ),
      buildIconRow(listing),
    ],
  );
}

Widget buildIconRow(Listing listing) {
  return Row(
    children: [
      // buildIconPair(Icon(Icons.king_bed_outlined), listing.bedroom),
      // buildIconPair(Icon(Icons.bathtub_outlined), listing.bathroom),
      // buildIconPair(Icon(Icons.pets), listing.isPetFriendly ? "Yes" : "No"),
      // buildIconPair(Icon(Icons.directions_car_sharp),
      // listing.isParkingAvail ? "Yes" : "No")
    ],
  );
}

Widget buildIconPair(Icon icon, String text) {
  return Row(children: [
    Container(
      padding: EdgeInsets.symmetric(horizontal: 5.0),
      child: icon,
    ),
    Container(padding: EdgeInsets.symmetric(horizontal: 3.0), child: Text(text))
  ]);
}

Color idStatus(String status) {
  switch (status) {
    case "Available":
      return Colors.green;
      break;
    case "Pending":
      return Colors.yellow;
      break;
    case "No Longer Available":
      return Colors.grey;
      break;
    default:
      return Colors.black;
  }
}

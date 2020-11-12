import 'package:flutter/material.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:rxdart/subjects.dart';
import 'package:search_app_bar/searcher.dart';
import 'package:dockmate/model/listing.dart';

Icon sad_replacement_icon = Icon(Icons.satellite);

Widget snackBarCustom(String message) {
  return SnackBar(
    content: Text(message),
    action: SnackBarAction(
        /*label: 'Undo',
      onPressed: () {
        // Some code to undo the change.
      },*/
        ),
  );
}

Widget buildListRow(Listing listing, bool isGeneral) {
  return Container(
      padding: EdgeInsets.symmetric(vertical: 20.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                    child: Text(
                      listing.title,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              Container(
                  child: Image.network(listing.mainImage,
                      height: 100, width: 250, fit: BoxFit.fill)),
              Container(
                padding: EdgeInsets.all(10.0),
                child: Text("\$" + listing.price),
              ),
              Container(
                padding: EdgeInsets.all(10.0),
                child: Text(listing.address),
              ),
              buildIconRow(listing),
            ],
          ),
          isGeneral ? generalListing() : myListing()
        ],
      ));
}

Widget generalListing() {
  return Row(
    children: [
      Container(
        child: IconButton(
          icon: sad_replacement_icon,
          //icon: Icon(Icons.message_outlined),
          onPressed: () {},
        ),
      ),
      Container(
        child: IconButton(
          icon: sad_replacement_icon,
          //icon: Icon(Icons.bookmark_border_outlined),
          onPressed: () {},
        ),
      )
    ],
  );
}

Widget myListing() {
  return Row(
    children: [
      Container(
        child: IconButton(
          icon: sad_replacement_icon,
          //icon: Icon(Icons.create_outlined),
          onPressed: () {},
        ),
      ),
      Container(
        padding: EdgeInsets.symmetric(horizontal: 5.0),
        child: IconButton(
          icon: Icon(Icons.delete_outline),
          onPressed: () {},
        ),
      )
    ],
  );
}

Widget buildIconRow(Listing listing) {
  return Row(
    children: [
      buildIconPair(
          sad_replacement_icon,
          //Icon(Icons.king_bed_outlined),
          listing.bedroom),
      buildIconPair(
          sad_replacement_icon,
          //Icon(Icons.bathtub_outlined),
          listing.bathroom),
      buildIconPair(
          sad_replacement_icon,
          //Icon(Icons.pets),
          listing.isPetFriendly ? "Yes" : "No"),
      buildIconPair(
          sad_replacement_icon,
          //Icon(Icons.directions_car_sharp),
          listing.isParkingAvail ? "Yes" : "No")
    ],
  );
}

Widget buildIconPair(Icon icon, String text) {
  return Row(children: [
    Container(
      padding: EdgeInsets.symmetric(horizontal: 5.0),
      child: icon,
    ),
    Container(padding: EdgeInsets.symmetric(horizontal: 5.0), child: Text(text))
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

class Filter extends BlocBase implements Searcher<String> {
  final _filteredData = BehaviorSubject<List<String>>();
  var dataList = [];

  Stream<List<String>> get filteredData => _filteredData.stream;

  Filter(List data) {
    dataList = data;
    _filteredData.add(dataList);
  }

  @override
  get onDataFiltered => _filteredData.add;

  @override
  get data => dataList;

  @override
  void dispose() {
    _filteredData.close();
    super.dispose();
  }
}

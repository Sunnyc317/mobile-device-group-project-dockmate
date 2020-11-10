import 'package:flutter/material.dart';
import 'package:dockmate/utils/bottombar.dart';
import 'package:dockmate/model/listing.dart';
import 'package:dockmate/pages/posting_form.dart';

class MyListing extends StatefulWidget {
  String title;
  MyListing({this.title});
  @override
  _MyListingState createState() => _MyListingState();
}

class _MyListingState extends State<MyListing> {
  int _selectedIndex;
  List<Listing> _listings;
  Listing _listing = new Listing();

  @override
  void initState() {
    super.initState();
    reload();
  }

  void reload() {
    /*_listing.init().then((_) {
      _listing.getAllListings().then((grades) {
        setState(() {
          _listings = grades;
        });
      });
    });*/
  }

  @override
  Widget build(BuildContext context) {
    //inal Filter filter;
    return Scaffold(
      appBar: AppBar(title: Text('My Listings')),
      body: ListView.builder(
        itemCount: _listings != null ? _listings.length : 0,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedIndex = index;
              });
            },
            child: Container(
              decoration: BoxDecoration(
                color: index == _selectedIndex ? Colors.blue : Colors.white,
              ),
              child: ListTile(
                  title: Text(_listings[index].address),
                  subtitle: Text(_listings[index].price)),
            ),
          );
        },
      ),
      bottomNavigationBar: BottomBar(bottomIndex: 0),
    );
  }
}

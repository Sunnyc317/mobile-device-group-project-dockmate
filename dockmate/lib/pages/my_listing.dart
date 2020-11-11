import 'package:flutter/material.dart';
import 'package:dockmate/utils/bottombar.dart';
import 'package:dockmate/utils/util.dart';
import 'package:dockmate/model/listing.dart';
import 'package:dockmate/model/user.dart';
import 'package:dockmate/pages/posting_form.dart';
import 'package:dockmate/pages/posting.dart';

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
    User user = User(id: "2");
    _listing.getAllListings().then((list) {
      setState(() {
        _listings = list.where((i) => i.userID == user.getUser()).toList();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    //inal Filter filter;
    return Scaffold(
      appBar: AppBar(
        title: Text('My Listings'),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                _addListing(context);
              })
        ],
      ),
      body: ListView.builder(
        itemCount: _listings != null ? _listings.length : 0,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedIndex = index;
                _openListing(context);
              });
            },
            child: Container(
                decoration: BoxDecoration(
                  color: index == _selectedIndex ? Colors.blue : Colors.white,
                ),
                child: ListTile(title: buildListRow(_listings[index], true))),
          );
        },
      ),
      bottomNavigationBar: BottomBar(bottomIndex: 0),
    );
  }

  Future<void> _addListing(BuildContext context) async {
    var list = await Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => PostingForm(title: 'Add Listing')));

    await _listing.insert(list);
    reload();
  }

  Future<void> _openListing(BuildContext context) async {
    Listing post = Listing(
        id: _listings[_selectedIndex].id,
        mainImage: _listings[_selectedIndex].mainImage,
        title: _listings[_selectedIndex].title,
        address: _listings[_selectedIndex].address,
        city: _listings[_selectedIndex].city,
        postalCode: _listings[_selectedIndex].postalCode,
        province: _listings[_selectedIndex].province,
        country: _listings[_selectedIndex].country,
        description: _listings[_selectedIndex].description,
        price: _listings[_selectedIndex].price,
        bedroom: _listings[_selectedIndex].bedroom,
        bathroom: _listings[_selectedIndex].bathroom,
        status: _listings[_selectedIndex].status,
        isParkingAvail: _listings[_selectedIndex].isParkingAvail,
        isPetFriendly: _listings[_selectedIndex].isPetFriendly,
        isPublic: _listings[_selectedIndex].isPublic,
        userID: _listings[_selectedIndex].userID);

    await Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => Posting(title: '', listing: post)));
    _selectedIndex = -1;
    reload();
  }
}

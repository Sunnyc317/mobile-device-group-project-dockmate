import 'package:dockmate/posting_form.dart';
import 'package:flutter/material.dart';
import '../model/listing.dart';
import '../utils/bottombar.dart';

class Listings extends StatefulWidget {
  final String title;

  Listings({Key key, this.title}) : super(key: key);

  @override
  _ListingState createState() => _ListingState();
}

class _ListingState extends State<Listings> {
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
    return Scaffold(
      appBar: AppBar(title: Text('Listings'), actions: <Widget>[
        IconButton(icon: Icon(Icons.search), onPressed: () {}),
        IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              _addListing(context);
            })
      ]),
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

  Future<void> _addListing(BuildContext context) async {
    var list = await Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => PostingForm(title: 'Add Listing')));

    //await _listing.insert(list);
    reload();
  }
}

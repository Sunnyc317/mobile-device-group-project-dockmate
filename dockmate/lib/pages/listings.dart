import 'package:dockmate/model/user.dart';
import 'package:dockmate/utils/auth.dart';
import 'package:flutter/material.dart';
//import 'package:search_app_bar/search_app_bar.dart';
import 'package:dockmate/model/listing.dart';
import 'package:dockmate/utils/bottombar.dart';
import 'package:dockmate/utils/util.dart';
import 'package:dockmate/pages/posting.dart';
import 'package:dockmate/pages/posting_form.dart';

class Listings extends StatefulWidget {
  final String title;
  User user;

  Listings({Key key, this.title, this.user}) : super(key: key);

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
    _listing.getAllListings().first.then((list) {
      setState(() {
        _listings = list;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    AuthService _auth = AuthService();
    //final Filter filter;

    return Scaffold(
      appBar: AppBar(
        title: Text('Listings'),
        actions: <Widget>[
          FlatButton(
            child: Text('Sign Out'),
            onPressed: () {
              _auth.signOut();
            },
          ),
          IconButton(icon: Icon(Icons.search), onPressed: () {}),
          IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                _addListing(context);
              }),
          
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
                child: ListTile(
                    title: Container(
                        padding: EdgeInsets.symmetric(vertical: 20.0),
                        child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              buildListRow(_listings[index]),
                              Row(
                                children: [
                                  Container(
                                    child: IconButton(
                                      icon: Icon(Icons.message_outlined),
                                      onPressed: () {},
                                    ),
                                  ),
                                  Container(
                                    child: IconButton(
                                      icon:
                                          Icon(Icons.bookmark_border_outlined),
                                      onPressed: () {
                                        Scaffold.of(context)
                                            .showSnackBar(SnackBar(
                                          content: Text("Post saved"),
                                        ));
                                        _saveListing(context);
                                      },
                                    ),
                                  )
                                ],
                              )
                            ])))),
          );
        },
      ),
      bottomNavigationBar: BottomBar(bottomIndex: 0),
    );
  }

  Future<void> _saveListing(BuildContext context) async {
    // TO BE IMPLEMENTED
    reload();
  }

  Future<void> _addListing(BuildContext context) async {
    var list = await Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => PostingForm(title: 'Add Listing')));

    if (list != null) await _listing.insert(list);
    reload();
  }

  Future<void> _openListing(BuildContext context) async {
    await Navigator.of(context).push(MaterialPageRoute(
        builder: (context) =>
            Posting(title: '', listing: _listings[_selectedIndex])));
    _selectedIndex = -1;
    reload();
  }
}

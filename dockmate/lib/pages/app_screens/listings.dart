import 'package:dockmate/model/user.dart';
// import 'package:dockmate/utils/auth.dart';
import 'package:flutter/material.dart';
//import 'package:search_app_bar/search_app_bar.dart';
import 'package:dockmate/model/listing.dart';
import 'package:dockmate/utils/bottombar.dart';
import 'package:dockmate/utils/util.dart';
import 'package:dockmate/pages/app_screens/posting.dart';
import 'package:dockmate/pages/app_screens/posting_form.dart';

// Search functions referencing: https://github.com/ahmed-alzahrani/Flutter_Search_Example
class Listings extends StatefulWidget {
  final String title;
  User user;

  Listings({Key key, this.title, this.user}) : super(key: key);

  @override
  _ListingState createState() => _ListingState();
}

class _ListingState extends State<Listings> {
  int _selectedIndex;
  String _search = "";
  List<Listing> _listings;
  List<Listing> _filteredListings;
  Listing _listing = new Listing();
  Icon _searchIcon = new Icon(Icons.search);
  Icon _saveIcon = new Icon(Icons.bookmark_border_outlined);
  Widget _title = new Text('Listings');
  final TextEditingController _filter = new TextEditingController();

  @override
  void initState() {
    super.initState();
    reload();
  }

  _ListingState() {
    initState();
    _filter.addListener(() {
      if (_filter.text.isEmpty) {
        setState(() {
          _search = "";
          _filteredListings = _listings;
        });
      } else {
        setState(() {
          _search = _filter.text;
        });
      }
    });
  }

  void reload() {
    _listing.getAllListings().first.then((list) {
      setState(() {
        _listings = _filteredListings = list;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Image.asset("assets/dock.png", scale: 20, color: Colors.white),
        title: _title,
        centerTitle: true,
        actions: <Widget>[
          IconButton(icon: _searchIcon, onPressed: _searchPressed),
          IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                _addListing(context);
              }),
        ],
      ),
      body: _filteredList(),
      bottomNavigationBar: BottomBar(bottomIndex: 0),
    );
  }

  Row symbols() {
    return Row(children: <Widget>[
      Container(
        child: IconButton(
          icon: Icon(Icons.message_outlined),
          onPressed: () {},
        ),
      ),
      Container(
        child: IconButton(
          icon: _saveIcon,
          onPressed: () {
            _saveListing(context);
            Scaffold.of(context).showSnackBar(SnackBar(
              content: Text("Post saved"),
            ));
          },
        ),
      )
    ]);
  }

  void _searchPressed() {
    setState(() {
      if (this._searchIcon.icon == Icons.search) {
        _searchIcon = new Icon(Icons.close);
        _title = new TextField(
          controller: _filter,
          decoration: new InputDecoration(
              prefixIcon: new Icon(Icons.search),
              hintText: 'Address, Postal Code, Keyword...'),
        );
      } else {
        _searchIcon = new Icon(Icons.search);
        _title = new Text('Listings');
        _filteredListings = _listings;
        _filter.clear();
      }
    });
  }

  Widget _filteredList() {
    if (_search != "") {
      // Search through address
      _filteredListings = _listings
          .where((list) =>
              list.address.toLowerCase().contains(_search.toLowerCase()))
          .toList();

      if (_filteredListings.isEmpty) {
        // Search through postal code
        _filteredListings = _listings
            .where((list) =>
                list.postalCode.toLowerCase().contains(_search.toLowerCase()))
            .toList();

        if (_filteredListings.isEmpty) {
          // Search through post title
          _filteredListings = _listings
              .where((list) =>
                  list.title.toLowerCase().contains(_search.toLowerCase()))
              .toList();
        }
      }
    }

    return ListView.builder(
      itemCount: _filteredListings != null ? _filteredListings.length : 0,
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
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(children: <Widget>[
                              buildListRow(_filteredListings[index], symbols()),
                            ]),
                          ])))),
        );
      },
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

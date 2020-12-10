import 'package:dockmate/model/user.dart';
import 'package:flutter/material.dart';
import 'package:dockmate/model/listing.dart';
import 'package:dockmate/model/saved_listing.dart';
import 'package:dockmate/utils/bottombar.dart';
import 'package:dockmate/utils/util.dart';
import 'package:dockmate/pages/views/post/posting.dart';
import 'package:dockmate/pages/views/post/posting_form.dart';
import 'package:filter_list/filter_list.dart';
//import 'package:dockmate/model/chat.dart';
//import 'package:dockmate/pages/views/chat/message.dart';

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
  User _user = User(id: "2FXgu90z0tTy0MO5gI3Bti");
  List<Listing> _listings;
  SavedListings _savedListings = new SavedListings();
  List<Listing> _filteredListings;
  List<Listing> _savedList;
  List<String> _selectedFilter = [];
  Listing _listing = new Listing();
  Icon _searchIcon = new Icon(Icons.search);
  Icon _saveIcon = new Icon(Icons.bookmark_border_outlined);
  Widget _title = new Text('Listings');
  final TextEditingController _filter = new TextEditingController();

  List<String> _filterList = [
    "Saved Posts",
    "Studio",
    "1 Bedroom",
    "1+1 Bedroom",
    "2 Bedroom",
    "2+1 Bedroom",
    "3 Bedroom",
    "3+1 Bedroom",
    "4+ Bedroom",
    "1 Bathroom",
    "2 Bathroom",
    "3 Bathroom",
    "4 Bathroom",
    "5+ Bathroom",
    "\$\$: 800-1000",
    "\$\$: 1000-1200",
    "\$\$: 1500-1800",
    "\$\$: 1800-2000",
    "\$\$: 2000-2500",
    "\$\$\$: 2500-3000",
    "\$\$\$: 3000-4500",
    'AB',
    'BC',
    'MB',
    'NB',
    'NL',
    'NS',
    'NT',
    'NU',
    'ON',
    'PE',
    'QC',
    'YT',
    "US",
  ];

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

  void _getSavedListings(userID) {
    _listing.getAllListings().first.then((a) {
      _savedListings.getAllSavedListings().first.then((b) {
        var userList = b.where((i) => i.userID == userID).toList();
        userList.forEach((list) {
          setState(() {
            _savedList = a.where((i) => i.id == list.listingID).toList();
          });
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading:
              Image.asset("assets/dock.png", scale: 20, color: Colors.white),
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
        floatingActionButton: FloatingActionButton(
          onPressed: _openFilterDialog,
          tooltip: 'Filter',
          child: Icon(Icons.filter_alt),
        ));
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
    String userID = _user.getUser();
    _getSavedListings(userID);

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

    Row symbols(var index) {
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
            //_savedList.contains((i) => i.id == _filteredListings[index].id)
            //   ? Icon(Icons.bookmark)
            //   : Icon(Icons.bookmark_border),
            onPressed: () {
              _saveListing(_filteredListings[index]);
              Scaffold.of(context).showSnackBar(SnackBar(
                content: Text("Post Saved"),
              ));
            },
          ),
        )
      ]);
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
                              buildListRow(
                                  _filteredListings[index], symbols(index)),
                            ]),
                          ])))),
        );
      },
    );
  }

  void _openFilterDialog() async {
    await FilterListDialog.display(context,
        allTextList: _filterList,
        height: 480,
        borderRadius: 20,
        headlineText: "Select Filter",
        searchFieldHintText: "Search Here",
        selectedTextList: _selectedFilter, onApplyButtonClick: (list) {
      if (list.isEmpty || list == null) list = _filterList;
      setState(() {
        _selectedFilter = List.from(list);

        List<Listing> _temp = new List<Listing>();
        _selectedFilter.forEach((filter) {
          if (filter.split(" ").length == 2) {
            var current = filter.split(" ");
            if (current[1] == "Bedroom") {
              _temp.addAll(_listings
                  .where((list) => list.bedroom == current[0])
                  .toList());
            } else if (current[1] == "Bathroom") {
              _temp.addAll(_listings
                  .where((list) => list.bathroom == current[0])
                  .toList());
            } else if (current[0].contains("\$")) {
              var price_range = current[1].split("-");
              var start_price = int.parse(price_range[0]);
              var limit_price = int.parse(price_range[1]);

              _temp.addAll(_listings
                  .where((list) =>
                      list.price.toLowerCase() != "negotiable" &&
                      int.parse(list.price) >= start_price &&
                      int.parse(list.price) <= limit_price)
                  .toList());
            }
          } else if (filter == "Saved Posts") {
            String userID = _user.getUser();
            _getSavedListings(userID);
            _temp.addAll(_savedList);
          } else {
            _temp.addAll(
                _listings.where((list) => list.province == filter).toList());
          }

          _filteredListings = _temp;
        });
      });

      Navigator.pop(context);
    });
  }

  Future<void> _saveListing(Listing listing) async {
    String userID = _user.getUser();
    _savedListings.insert(SavedListings(listingID: listing.id, userID: userID));
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

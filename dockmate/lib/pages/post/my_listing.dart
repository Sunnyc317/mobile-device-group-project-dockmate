import 'package:flutter/material.dart';
import 'package:dockmate/utils/bottombar.dart';
import 'package:dockmate/utils/util.dart';
import 'package:dockmate/model/listing.dart';
import 'package:dockmate/model/user.dart';
import 'package:dockmate/pages/post/posting_form.dart';
import 'package:dockmate/pages/post/posting.dart';

class MyListing extends StatefulWidget {
  // final String title;
  final Function toggleView;
  MyListing({Key key, this.toggleView}) : super(key: key);

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
    User user = User(id: "2FXgu90z0tTy0MO5gI3Bti");
    _listing.getAllListings().first.then((list) {
      setState(() {
        _listings = list.where((i) => i.userID == user.getUser()).toList();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    //inal Filter filter;

    Row symbols(index) {
      return Row(
        children: [
          Container(
            child: IconButton(
              icon: Icon(Icons.create_outlined),
              onPressed: () {
                _selectedIndex = index;
                _updateListing(context);
              },
            ),
          ),
          Container(
            child: IconButton(
              icon: Icon(Icons.delete_outline),
              onPressed: () {
                _deleteConfirmation(context);
              },
            ),
          )
        ],
      );
    }

    return Scaffold(
      appBar: AppBar(
        leading: Image.asset("assets/dock.png", scale: 20, color: Colors.white),
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
                child: ListTile(
                    title: Container(
                        padding: EdgeInsets.symmetric(vertical: 20.0),
                        child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              buildListRow(_listings[index], symbols(index)),
                            ])))),
          );
        },
      ),
      bottomNavigationBar:
          BottomBar(bottomIndex: 3, toggleView: widget.toggleView),
    );
  }

  Future<void> _deleteConfirmation(BuildContext context) async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Are you sure you want to delete this post?'),
            content: Text('This change cannot be recovered'),
            actions: [
              FlatButton(
                textColor: Color(0xFF6200EE),
                onPressed: () {
                  // NOT WORKING, ARGUMENT ERROR WILL BE FIXED ON THE NEXT ITERATION
                  //_listing.delete(_listings[_selectedIndex].id);
                  Navigator.pop(context);
                },
                child: Text('YES'),
              ),
              FlatButton(
                textColor: Color(0xFF6200EE),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('CANCEL'),
              ),
            ],
          );
        });
  }

  Future<void> _addListing(BuildContext context) async {
    var list = await Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => PostingForm(title: 'Add Listing')));

    if (list != null) await _listing.insert(list);
    reload();
  }

  Future<void> _updateListing(BuildContext context) async {
    var list = await Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => PostingForm(
            title: 'Edit Listing', listing: _listings[_selectedIndex])));

    if (list != null) await _listing.update(list);
    _selectedIndex = -1;
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

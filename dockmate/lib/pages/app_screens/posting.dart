import 'package:flutter/material.dart';
import 'package:dockmate/model/listing.dart';
import 'package:dockmate/utils/util.dart';
import 'package:dockmate/model/chat.dart';
import 'package:dockmate/pages/app_screens/message.dart';
import 'package:dockmate/model/user.dart';
import 'package:dockmate/pages/app_screens/posting_form.dart';

class Posting extends StatefulWidget {
  final String title;
  final Listing listing;

  Posting({Key key, this.title, this.listing}) : super(key: key);

  @override
  _PostingState createState() => _PostingState();
}

class _PostingState extends State<Posting> {
  String _postalCode;
  String _address;
  String _city;
  String _province;
  String _country;
  String _description;
  String _duration;
  String _status;
  String _title;
  String _mainImage;
  String _price;
  String _userID;
  String _owner;
  bool _isOwner = false;

  @override
  Widget build(BuildContext context) {
    if (widget.listing != null) {
      _title = widget.listing.title;
      _address = widget.listing.address;
      _description = widget.listing.description;
      _duration = widget.listing.duration;
      _price = widget.listing.price;
      _province = widget.listing.province;
      _city = widget.listing.city;
      _country = widget.listing.country;
      _postalCode = widget.listing.postalCode;
      _status = widget.listing.status;
      _mainImage = widget.listing.mainImage;
      _userID = widget.listing.userID;

      User user = User(id: "2FXgu90z0tTy0MO5gI3Bti");
      if (user.getUser() == _userID) _isOwner = true;
    }

    return Scaffold(
      appBar: AppBar(
          leading:
              Image.asset("assets/dock.png", scale: 20, color: Colors.white),
          title: Text(widget.title)),
      body: Builder(
          builder: (context) => SingleChildScrollView(
                child: Container(
                    padding: EdgeInsets.symmetric(vertical: 30.0),
                    child: Column(children: [
                      Container(
                          child: Row(
                        children: [
                          Container(
                              width: 285,
                              // padding: EdgeInsets.only(right: 20),
                              margin: EdgeInsets.only(left: 22),
                              child: Text(
                                _title,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22,
                                ),
                              )),
                          Container(
                            child: _isOwner
                                ? IconButton(
                                    iconSize: 32,
                                    icon: Icon(Icons.create_outlined),
                                    onPressed: () {
                                      _updateListing(context, widget.listing);
                                    },
                                  )
                                : IconButton(
                                    iconSize: 32,
                                    icon: Icon(Icons.check_box_outline_blank,
                                        color: Colors.white),
                                    onPressed: () {},
                                  ),
                          ),
                          Container(
                            child: _isOwner
                                ? IconButton(
                                    iconSize: 32,
                                    icon: Icon(Icons.delete_outline),
                                    onPressed: () {
                                      _deleteConfirmation(context);
                                    },
                                  )
                                : IconButton(
                                    iconSize: 32,
                                    icon: Icon(Icons.bookmark_border_outlined),
                                    onPressed: () {
                                      Scaffold.of(context)
                                          .showSnackBar(SnackBar(
                                        content: Text("Post saved"),
                                      ));
                                    },
                                  ),
                          )
                        ],
                      )),
                      Container(
                          padding: EdgeInsets.all(10.0),
                          child: Image.network(_mainImage,
                              height: 200, width: 370, fit: BoxFit.fill)),
                      Container(
                          width: 370,
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                      Container(
                                          margin: EdgeInsets.only(bottom: 6),
                                          child: Text("Location",
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 16))),
                                      Text(_address),
                                      Container(
                                          padding: EdgeInsets.only(
                                              // left: 10.0,
                                              // right: 10.0,
                                              top: 2.0,
                                              bottom: 10.0),
                                          child: Text(_city +
                                              ", " +
                                              _province +
                                              ", " +
                                              _country +
                                              " ")),
                                    ])),
                                Container(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10.0),
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: <Widget>[
                                          Container(
                                              padding: EdgeInsets.only(top: 2),
                                              margin:
                                                  EdgeInsets.only(bottom: 3),
                                              child: Row(children: <Widget>[
                                                Text("\$ $_price/",
                                                    style: TextStyle(
                                                        color: Colors.blue,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 20)),
                                                Container(
                                                  margin:
                                                      EdgeInsets.only(top: 5.3),
                                                  child: Text("mth",
                                                      style: TextStyle(
                                                        color: Colors.blue,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 14,
                                                      )),
                                                )
                                              ])),
                                          Text(_duration,
                                              style: TextStyle(
                                                color: Colors.blue,
                                              )),
                                          Container(
                                              margin: EdgeInsets.only(
                                                bottom: 12.0,
                                              ),
                                              child: Text(_status,
                                                  style: TextStyle(
                                                      color:
                                                          idStatus(_status)))),
                                        ])),
                              ])),
                      // Container(
                      //     padding: EdgeInsets.all(10.0),
                      //     child: buildIconRow(widget.listing)),
                      Container(
                          padding: EdgeInsets.only(top: 10.0, bottom: 20.0),
                          width: 370,
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                    margin: EdgeInsets.symmetric(vertical: 5),
                                    child: Text("Description",
                                        style: TextStyle(
                                            color: Colors.grey, fontSize: 16))),
                                Text(_description)
                              ])),
                      // !_isOwner
                      //     ? RaisedButton.icon(
                      //         onPressed: () {
                      //           //temporarily hardcoding other user identity
                      //           _owner = "Rogue Smith";
                      //           Chat chatRoomInfo = Chat.startChatRoom(
                      //               imageURL: _mainImage,
                      //               stringUsers: ["self", _owner]);
                      //           Navigator.of(context).pushNamed('/Chat');
                      //           Navigator.push(
                      //             context,
                      //             MaterialPageRoute(
                      //                 builder: (context) => MessageRoom.create(
                      //                     roomInfo: chatRoomInfo)),
                      //           );
                      //         },
                      //         icon:
                      //             //sad_replacement_icon,
                      //             Icon(Icons.message_outlined),
                      //         label: Text("Chat with " + "Post Owner"))
                      //     : Container(),
                    ])),
              )),
      floatingActionButton: !_isOwner
          ? FloatingActionButton(
              onPressed: () {
                //temporarily hardcoding other user identity
                _owner = "Rogue Smith";
                Chat chatRoomInfo = Chat.startChatRoom(
                    imageURL: _mainImage, stringUsers: ["self", _owner]);
                Navigator.of(context).pushNamed('/Chat');
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          MessageRoom.create(roomInfo: chatRoomInfo)),
                );
              },
              child: Icon(Icons.message_outlined),
            )
          : Container(),
    );
  }

  Future<void> _updateListing(BuildContext context, Listing listing) async {
    var list = await Navigator.of(context).push(MaterialPageRoute(
        builder: (context) =>
            PostingForm(title: 'Edit Listing', listing: listing)));

    Listing _listing = new Listing();
    if (list != null) _listing.update(list);
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
                  Navigator.pop(context);
                },
                child: Text('CANCEL'),
              ),
              FlatButton(
                textColor: Color(0xFF6200EE),
                onPressed: () {
                  // NOT YET REDIRECTING BACK TO PREVIOUS PAGE, FIX FOR NEXT ITERATION
                  Listing _listing = new Listing();
                  _listing.delete(widget.listing.id);
                  Navigator.pop(context);
                },
                child: Text('YES'),
              ),
            ],
          );
        });
  }
}

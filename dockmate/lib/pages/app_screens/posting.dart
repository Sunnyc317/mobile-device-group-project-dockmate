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
                    child: Row(
                      children: [
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                  child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                      width: 230,
                                      padding: EdgeInsets.only(right: 50),
                                      child: Text(
                                        _title,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      )),
                                  Container(
                                    child: _isOwner
                                        ? IconButton(
                                            icon: Icon(Icons.create_outlined),
                                            onPressed: () {
                                              _updateListing(
                                                  context, widget.listing);
                                            },
                                          )
                                        : IconButton(
                                            icon: Icon(
                                                Icons.bookmark_border_outlined),
                                            onPressed: () {
                                              Scaffold.of(context)
                                                  .showSnackBar(SnackBar(
                                                content: Text("Post saved"),
                                              ));
                                            },
                                          ),
                                  ),
                                  Container(
                                    child: _isOwner
                                        ? IconButton(
                                            icon: Icon(Icons.delete_outline),
                                            onPressed: () {
                                              _deleteConfirmation(context);
                                            },
                                          )
                                        : Container(),
                                  )
                                ],
                              )),
                              Container(
                                  padding: EdgeInsets.all(10.0),
                                  child: Text(_status,
                                      style:
                                          TextStyle(color: idStatus(_status)))),
                              Container(
                                  padding: EdgeInsets.all(10.0),
                                  child: Image.network(_mainImage,
                                      height: 100,
                                      width: 250,
                                      fit: BoxFit.fill)),
                              Container(
                                  padding: EdgeInsets.all(10.0),
                                  child: Text(_duration + " - \$" + _price)),
                              Container(
                                  padding: EdgeInsets.all(10.0),
                                  child: Text(_address)),
                              Container(
                                  padding: EdgeInsets.all(10.0),
                                  child: Text(_city +
                                      ", " +
                                      _province +
                                      ", " +
                                      _country +
                                      " ")),
                              Container(
                                  padding: EdgeInsets.all(10.0),
                                  child: buildIconRow(widget.listing)),
                              Container(
                                  padding:
                                      EdgeInsets.only(top: 10.0, bottom: 20.0),
                                  width: 300,
                                  child:
                                      Text("Description: \n\n" + _description)),
                              !_isOwner
                                  ? RaisedButton.icon(
                                      onPressed: () {
                                        //temporarily hardcoding other user identity
                                        _owner = "Rogue Smith";
                                        Chat chatRoomInfo = Chat.startChatRoom(
                                            imageURL: _mainImage,
                                            stringUsers: ["self", _owner]);
                                        Navigator.of(context)
                                            .pushNamed('/Chat');
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  MessageRoom.create(
                                                      roomInfo: chatRoomInfo)),
                                        );
                                      },
                                      icon:
                                          //sad_replacement_icon,
                                          Icon(Icons.message_outlined),
                                      label: Text("Chat with " + "Post Owner"))
                                  : Container(),
                            ])
                      ],
                    ),
                  ),
                )));
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
                  // NOT YET REDIRECTING BACK TO PREVIOUS PAGE, FIX FOR NEXT ITERATION
                  Listing _listing = new Listing();
                  _listing.delete(widget.listing.id);
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
}

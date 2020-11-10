import 'package:flutter/material.dart';
import 'package:dockmate/model/listing.dart';
import 'package:dockmate/utils/util.dart';

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

      //if (user.getUser() == _userID) _isOwner = true;
    }
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Row(
          children: [
            Column(children: [
              Container(child: Text(_title)),
              if (_isOwner) myListing(),
            ]),
            Container(
                child:
                    Text(_status, style: TextStyle(color: idStatus(_status)))),
            // TEMP, WILL SHOW MULTIPLE IMAGES
            Container(child: Image.network(_mainImage)),
            Container(child: Text(_address)),
            Container(
                child: Text(_city +
                    ", " +
                    _province +
                    ", " +
                    _country +
                    " " +
                    _postalCode)),
            Container(child: buildIconRow(widget.listing)),
            Container(child: Text(_price)),
            Container(child: Text(_duration)),
            Container(child: Text(_description)),
            if (!_isOwner)
              RaisedButton.icon(
                  onPressed: null,
                  icon: Icon(Icons.message_outlined),
                  label: Text("Chat with " + "Post Owner")),
          ],
        ),
      ),
    );
  }
}

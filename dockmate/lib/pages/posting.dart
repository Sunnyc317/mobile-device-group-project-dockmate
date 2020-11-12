import 'package:flutter/material.dart';
import 'package:dockmate/model/listing.dart';
import 'package:dockmate/utils/util.dart';
import 'package:dockmate/model/chat.dart';
import 'package:dockmate/pages/message.dart';

Icon sad_replacement_icon = Icon(Icons.satellite);

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
      _status = widget.listing.status;
      _mainImage = widget.listing.mainImage;

      //if (user.getUser() == _userID) _isOwner = true;
    }
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Container(
        padding: EdgeInsets.all(30.0),
        child: Row(
          children: [
            Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
              Container(child: Text(_title)),
              if (_isOwner) myListing(),
              Container(
                  child: Text(_status,
                      style: TextStyle(color: idStatus(_status)))),
              Container(
                  child: Image.network(_mainImage,
                      height: 100, width: 250, fit: BoxFit.fill)),
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
              Container(child: Text("\$" + _price)),
              Container(child: Text(_duration)),
              Container(child: Text(_description)),
              if (!_isOwner)
                RaisedButton.icon(
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
                    icon: sad_replacement_icon, //Icon(Icons.message_outlined),
                    label: Text("Chat with " + "Post Owner")),
            ])
          ],
        ),
      ),
    );
  }
}

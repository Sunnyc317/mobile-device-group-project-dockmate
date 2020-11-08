import 'package:flutter/material.dart';
import 'model/listing.dart';
import 'bottombar.dart';

class PostingForm extends StatefulWidget {
  final String title;

  PostingForm({Key key, this.title}) : super(key: key);

  @override
  _PostingFormState createState() => _PostingFormState();
}

List<DropdownMenuItem<String>> _buildDropdownItems(List objects) {
  List<DropdownMenuItem<String>> items = List();
  for (var object in objects) {
    items.add(
      DropdownMenuItem(
        value: object,
        child: Text(object),
      ),
    );
  }
  return items;
}

class _PostingFormState extends State<PostingForm> {
  List _provinceList = [
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
    'YT'
  ];

  int _id;
  int _bed;
  int _bathroom;
  bool _isParkingAvail = false;
  bool _isPetFriendly = false;
  String _postalCode;
  String _address;
  String _city;
  String _province;
  String _country;
  String _description;
  bool _isPublic = true;

  @override
  Widget build(BuildContext context) {
    /*if (widget.grade != null) {
      _id = widget.grade.id;
      _sid = widget.grade.sid;
      _grade = widget.grade.grade;
    }*/

    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: ListView(
          children: <Widget>[
            ListTile(
              title: TextField(
                decoration: InputDecoration(
                  hintText: 'Address',
                  //errorText: 'Error Text',
                  border: OutlineInputBorder(),
                ),
                controller: TextEditingController(text: _address),
                onChanged: (value) {
                  _address = value;
                },
              ),
            ),
            ListTile(
              title: TextField(
                decoration: InputDecoration(
                  hintText: 'City/Town',
                  //errorText: 'Error Text',
                  border: OutlineInputBorder(),
                ),
                controller: TextEditingController(text: _city),
                onChanged: (value) {
                  _city = value;
                },
              ),
            ),
            ListTile(
              title: TextField(
                decoration: InputDecoration(
                  hintText: 'Postal Code',
                  //errorText: 'Error Text',
                  border: OutlineInputBorder(),
                ),
                controller: TextEditingController(text: _postalCode),
                onChanged: (value) {
                  _postalCode = value;
                },
              ),
            ),
            ListTile(
              title: DropdownButton<String>(
                  value: _province,
                  items: _buildDropdownItems(_provinceList),
                  onChanged: (value) {
                    setState(() {
                      _province = value;
                    });
                  }),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //Grade grade = Grade(id: _id, sid: _sid, grade: _grade);
          //Navigator.pop(context, grade);
        },
        tooltip: 'Add New Grade',
        child: Icon(Icons.save),
      ),
    );
  }
}

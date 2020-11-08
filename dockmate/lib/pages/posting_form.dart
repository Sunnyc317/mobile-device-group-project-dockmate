import 'package:flutter/material.dart';
import '../model/listing.dart';

class PostingForm extends StatefulWidget {
  final String title;

  PostingForm({Key key, this.title}) : super(key: key);

  @override
  _PostingFormState createState() => _PostingFormState();
}

class _PostingFormState extends State<PostingForm> {
  var _countryList = ["CA", "US", "Other"];
  var _bedroomOptions = ["Studio", "1", "1+1", "2", "2+1", "3", "3+1", "4+"];
  var _bathroomOptions = [1, 2, 3, 4, 5];
  var _provinceList = [
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
  String _bed;
  int _bathroom;
  bool _isParkingAvail = false;
  bool _isPetFriendly = false;
  String _postalCode;
  String _address;
  String _city;
  String _province;
  String _country;
  String _description;
  bool _isPublic = false;

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
            buildFirstRow(),
            buildTextFieldRow("Street", _address),
            buildTextFieldRow("City/Town", _city),
            buildTextFieldRow("PostalCode", _postalCode),
            //buildDropdownListRow("Province", _province, _provinceList),
            //buildDropdownListRow("Country", _country, _countryList),
            buildTextAreaRow("Description", _description),
            Row(
              children: [
                Container(child: Text("Public")),
                buildCheckboxColumn(_isPublic)
              ],
            ),
            Row(
              children: [
                RaisedButton(
                  color: Colors.grey,
                  onPressed: () {},
                  child: Text("Cancel"),
                ),
                RaisedButton(
                  color: Colors.green,
                  onPressed: () {
                    Listing list = Listing();
                    Navigator.pop(context, list);
                  },
                  child: Text("Done"),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget buildFirstRow() {
    return Row(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [buildDropdownListRow("Bed", _bed, _bedroomOptions)],
        ),
        Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //buildDropdownListRow("Bathroom", _bathroom, _bathroomOptions)
            ]),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [Text("Parking"), buildCheckboxColumn(_isParkingAvail)],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [Text("Pet Friendly"), buildCheckboxColumn(_isPetFriendly)],
        )
      ],
    );
  }

  Widget buildTextFieldRow(String hintTxt, var param) {
    return ListTile(
      title: TextField(
        decoration: InputDecoration(
          hintText: hintTxt,
          //errorText: 'Error Text',
          border: OutlineInputBorder(),
        ),
        controller: TextEditingController(text: param),
        onChanged: (value) {
          param = value;
        },
      ),
    );
  }

  Widget buildTextAreaRow(String hintTxt, var param) {
    return ListTile(
      title: TextField(
        maxLines: 3,
        decoration: InputDecoration(
          hintText: hintTxt,
          //errorText: 'Error Text',
          border: OutlineInputBorder(),
        ),
        controller: TextEditingController(text: param),
        onChanged: (value) {
          param = value;
        },
      ),
    );
  }

  Widget buildDropdownListRow(var lead, var param, var objList) {
    return ListTile(
        leading: lead,
        title: DropdownButton<dynamic>(
          items: objList.map((dynamic value) {
            return new DropdownMenuItem<dynamic>(
              value: value,
              child: new Text(value),
            );
          }).toList(),
          onChanged: (value) {
            param = value;
          },
        ));
  }

  Widget buildCheckboxColumn(var param) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Checkbox(
          value: param,
          onChanged: (bool value) {
            setState(() {
              param = value;
            });
          },
        ),
      ],
    );
  }
}

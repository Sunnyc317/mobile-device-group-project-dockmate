import 'package:flutter/material.dart';
import 'package:dockmate/model/listing.dart';

class PostingForm extends StatefulWidget {
  final String title;

  PostingForm({Key key, this.title}) : super(key: key);

  @override
  _PostingFormState createState() => _PostingFormState();
}

class _PostingFormState extends State<PostingForm> {
  final _countryList = ["CA", "US", "Other"];
  final _statusOptions = ["Available", "Pending", "No Longer Available"];
  final _bedroomOptions = ["Studio", "1", "1+1", "2", "2+1", "3", "3+1", "4+"];
  final _bathroomOptions = ["1", "2", "3", "4", "5+"];
  final _provinceList = [
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
  String _bathroom;
  bool _isParkingAvail = false;
  bool _isPetFriendly = false;
  String _postalCode;
  String _address;
  String _city;
  String _province;
  String _country;
  String _description;
  String _duration;
  String _status;
  String _title;
  String _price;
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
            buildTextFieldRow("Title", _title),
            ListTile(title: buildFirstRow()),
            ListTile(title: buildSecondRow()),
            buildTextFieldRow("Price", _price),
            buildTextFieldRow("Street", _address),
            buildTextFieldRow("City/Town", _city),
            buildTextFieldRow("PostalCode", _postalCode),
            ListTile(
                title:
                    buildDropdownListRow("Province", _province, _provinceList)),
            ListTile(
                title: buildDropdownListRow("Country", _country, _countryList)),
            buildTextAreaRow("Duration", _duration),
            buildTextFieldRow("Description", _description),
            ListTile(
                title: buildDropdownListRow("Status", _status, _statusOptions)),
            ListTile(
                leading: Text("Public"), title: buildCheckboxColumn(_isPublic)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RaisedButton(
                  padding: EdgeInsets.all(10.0),
                  color: Colors.grey,
                  onPressed: () {},
                  child: Text("Cancel"),
                ),
                RaisedButton(
                  padding: EdgeInsets.all(10.0),
                  color: Colors.green,
                  onPressed: () {
                    Listing list = Listing(
                        title: _title,
                        address: _address,
                        city: _city,
                        postalCode: _postalCode,
                        province: _province,
                        country: _country,
                        description: _description,
                        price: _price,
                        bedroom: _bed,
                        bathroom: _bathroom,
                        status: _status,
                        isParkingAvail: _isParkingAvail,
                        isPetFriendly: _isPetFriendly,
                        isPublic: _isPublic);
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
    return Row(children: [
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [buildDropdownListRow("Bed", _bed, _bedroomOptions)],
      ),
      Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildDropdownListRow("Bathroom", _bathroom, _bathroomOptions)
          ])
    ]);
  }

  Widget buildSecondRow() {
    return Row(
      children: [
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
    return Row(children: [
      Text(lead),
      DropdownButton<String>(
        value: param,
        items: objList.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: (String value) {
          setState(() {
            param = value;
          });
        },
      )
    ]);
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

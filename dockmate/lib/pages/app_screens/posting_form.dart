import 'package:flutter/material.dart';
import 'package:dockmate/model/listing.dart';

class PostingForm extends StatefulWidget {
  final String title;
  final Listing listing;

  PostingForm({Key key, this.title, this.listing}) : super(key: key);

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
    'YT',
    "Other"
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
    if (widget.listing != null) {
      print("not null");
      _title = widget.listing.title;
      _address = widget.listing.address;
      _description = widget.listing.description;
      _duration = widget.listing.duration;
      _price = widget.listing.price;
      _province = widget.listing.province;
      _city = widget.listing.city;
      _country = widget.listing.country;
      _postalCode = "L6G 0C6"; //widget.listing.postalCode;
      _status = widget.listing.status;
      _isPublic = widget.listing.isPublic;
      _isParkingAvail = widget.listing.isParkingAvail;
      _isPetFriendly = widget.listing.isPetFriendly;
      _bed = widget.listing.bedroom;
      _bathroom = widget.listing.bathroom;
    }

    return Scaffold(
      appBar: AppBar(
          leading:
              Image.asset("assets/dock.png", scale: 20, color: Colors.white),
          title: Text(widget.title)),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: ListView(
          children: <Widget>[
            ListTile(
              title: TextField(
                decoration: InputDecoration(
                  hintText: "Title",
                  //errorText: 'Error Text',
                  border: OutlineInputBorder(),
                ),
                controller: TextEditingController(text: _title),
                onChanged: (value) {
                  _title = value;
                },
              ),
            ),
            ListTile(title: buildFirstRow()),
            ListTile(title: buildSecondRow()),
            ListTile(
              title: TextField(
                decoration: InputDecoration(
                  hintText: "Price",
                  //errorText: 'Error Text',
                  border: OutlineInputBorder(),
                ),
                controller: TextEditingController(text: _price),
                onChanged: (value) {
                  _price = value;
                },
              ),
            ),
            ListTile(
              title: TextField(
                decoration: InputDecoration(
                  hintText: "Street",
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
                  hintText: "City/Town",
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
                  hintText: "Postal Code",
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
                title: Row(children: [
              buildProvinceDropdownList(),
              Container(
                  padding: EdgeInsets.only(right: 20.0),
                  child: buildCountryDropdownList())
            ])),
            ListTile(
              title: TextField(
                decoration: InputDecoration(
                  hintText: "Duration",
                  //errorText: 'Error Text',
                  border: OutlineInputBorder(),
                ),
                controller: TextEditingController(text: _duration),
                onChanged: (value) {
                  _duration = value;
                },
              ),
            ),
            ListTile(
              title: TextField(
                maxLines: 3,
                decoration: InputDecoration(
                  hintText: "Description",
                  //errorText: 'Error Text',
                  border: OutlineInputBorder(),
                ),
                controller: TextEditingController(text: _description),
                onChanged: (value) {
                  _description = value;
                },
              ),
            ),
            ListTile(title: buildStatusDropdownList()),
            ListTile(leading: Text("Public"), title: buildVisibilityCheckbox()),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    padding: EdgeInsets.only(right: 8.0),
                    child: RaisedButton(
                      // color: Colors.grey,
                      onPressed: () {},
                      child: Text("Cancel"),
                    )),
                RaisedButton(
                  color: Colors.blue,
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
                        isPublic: _isPublic,
                        duration: _duration,
                        userID: "Xgu90z0tTy0MO5gI3Bti",
                        mainImage:
                            "https://torontostoreys.com/wp-content/uploads/2020/03/101-St-Clair-Ave.jpeg");
                    Navigator.pop(context, list);
                  },
                  child: Text("Done", style: TextStyle(color: Colors.white)),
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
        children: [buildBedDropdownList()],
      ),
      Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                padding: EdgeInsets.only(right: 20.0),
                child: buildBathDropdownList())
          ])
    ]);
  }

  Widget buildSecondRow() {
    return Row(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(children: [Text("Parking"), buildParkingCheckbox()])
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                padding: EdgeInsets.only(right: 20.0),
                child:
                    Row(children: [Text("Pet Friendly"), buildPetCheckbox()]))
          ],
        )
      ],
    );
  }

  Widget buildBedDropdownList() {
    return Row(children: [
      Container(padding: EdgeInsets.only(right: 5.0), child: Text("Bedroom")),
      new DropdownButton<String>(
        value: _bed,
        items: _bedroomOptions.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: (String value) {
          setState(() {
            _bed = value;
          });
        },
      )
    ]);
  }

  Widget buildBathDropdownList() {
    return Row(children: [
      Container(padding: EdgeInsets.only(right: 5.0), child: Text("Bathroom")),
      new DropdownButton<String>(
        value: _bathroom,
        items: _bathroomOptions.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: (String value) {
          setState(() {
            _bathroom = value;
          });
        },
      )
    ]);
  }

  Widget buildProvinceDropdownList() {
    return Row(children: [
      Container(padding: EdgeInsets.only(right: 5.0), child: Text("Province")),
      new DropdownButton<String>(
        value: _province,
        items: _provinceList.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: (String value) {
          setState(() {
            _province = value;
          });
        },
      )
    ]);
  }

  Widget buildCountryDropdownList() {
    return Row(children: [
      Container(padding: EdgeInsets.only(right: 5.0), child: Text("Country")),
      new DropdownButton<String>(
        value: _country,
        items: _countryList.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: (String value) {
          setState(() {
            _country = value;
          });
        },
      )
    ]);
  }

  Widget buildStatusDropdownList() {
    return Row(children: [
      Container(padding: EdgeInsets.only(right: 5.0), child: Text("Status")),
      new DropdownButton<String>(
        value: _status,
        items: _statusOptions.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: (String value) {
          setState(() {
            _status = value;
          });
        },
      )
    ]);
  }

  Widget buildParkingCheckbox() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        new Checkbox(
          value: _isParkingAvail,
          onChanged: (bool value) {
            setState(() {
              _isParkingAvail = value;
            });
          },
        ),
      ],
    );
  }

  Widget buildPetCheckbox() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        new Checkbox(
          value: _isPetFriendly,
          onChanged: (bool value) {
            setState(() {
              _isPetFriendly = value;
            });
          },
        ),
      ],
    );
  }

  Widget buildVisibilityCheckbox() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        new Checkbox(
          value: _isPublic,
          onChanged: (bool value) {
            setState(() {
              _isPublic = value;
            });
          },
        ),
      ],
    );
  }
}

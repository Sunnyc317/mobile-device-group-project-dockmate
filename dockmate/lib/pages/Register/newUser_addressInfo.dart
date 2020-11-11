// it is unclear whether user should put in their current location or the location they wish to find housingimport 'package:dockmate/Register/firstScreen.dart';
import 'package:dockmate/Register/forgotPassword.dart';
import 'package:dockmate/Register/newUser_housingType.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  Register({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              child: Image.asset("assets/placeholder_icon.png", scale: 20),
              margin: EdgeInsets.only(right: 10),
            ),
            Text("Dock Mate"),
          ],
        ),
      ),
      body: Center(
        child: Container(
          margin: EdgeInsets.only(top: 50, bottom: 50),
          child: Column(
            // mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text("Almost there! "),
              TextField(
                decoration: InputDecoration(hintText: "Street Address"),
              ),
              TextField(
                decoration: InputDecoration(hintText: "Unit/Apt (Optional)"),
              ),
              TextField(
                decoration: InputDecoration(hintText: "City/Town"),
              ),
              TextField(
                decoration: InputDecoration(hintText: "Postal Code"),
              ),
              DropdownButton(
                items: [
                  DropdownMenuItem(
                    child: Text("Ontario"),
                  ),
                  DropdownMenuItem(
                    child: Text("Alberta"),
                  ),
                  DropdownMenuItem(
                    child: Text("British Columbia"),
                  ),
                  DropdownMenuItem(
                    child: Text("Saskatchewan"),
                  ),
                  DropdownMenuItem(
                    child: Text("Nova Scotia"),
                  ),
                  DropdownMenuItem(
                    child: Text("Newfoundland"),
                  ),
                  DropdownMenuItem(
                    child: Text("Quebec"),
                  ),
                  DropdownMenuItem(
                    child: Text("Newfoundland"),onTap: ,
                  ),
                ],
              ),
              TextField(
                decoration: InputDecoration(hintText: "Re-enter Password"),
              ),
              Row(
                children: [
                  Container(
                    margin: EdgeInsets.all(10),
                    child: RaisedButton(
                      onPressed: () {},
                      child: Text("Cancel"),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(10),
                    child: RaisedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HousingType()),
                        );
                      },
                      child: Text("Next"),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

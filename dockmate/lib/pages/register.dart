import 'package:dockmate/model/user.dart';
import 'package:dockmate/pages/newUser_housingType.dart';
import 'package:dockmate/pages/settings.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

class Register extends StatefulWidget {
  Register({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  String fname;
  String lname;
  String email;
  String phone;
  String password;
  String repassword;

  _register() {
    if (repassword == password) {
      User newuser = User(
          // first_name: fname,
          // last_name: lname,
          // email: email,
          // phone: phone,
          // password: password
          );


      // Navigator.push(
      //   context,
      //   MaterialPageRoute(builder: (context) => HousingType(title: "Select your prefered housing type", user: newuser)),
      // );

      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => Settings(title: "Settings", user: newuser)),
      );
    }
  }

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
              Text("Register"),
              TextField(
                decoration: InputDecoration(hintText: "First Name"),
                onChanged: (value) {
                  fname = value;
                },
              ),
              TextField(
                decoration: InputDecoration(hintText: "Last Name"),
                onChanged: (value) {
                  lname = value;
                },
              ),
              TextField(
                decoration: InputDecoration(hintText: "Email"),
                onChanged: (value) {
                  email = value;
                },
              ),
              TextField(
                decoration: InputDecoration(hintText: "Phone Number"),
                onChanged: (value) {
                  phone = value;
                },
              ),
              TextField(
                decoration: InputDecoration(hintText: "Password"),
                onChanged: (value) {
                  password = value;
                },
              ),
              TextField(
                decoration: InputDecoration(hintText: "Re-enter Password"),
                onChanged: (value) {
                  repassword = value;
                },
              ),
              Row(
                children: [
                  Container(
                    margin: EdgeInsets.all(10),
                    child: RaisedButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed('/Login');
                      },
                      child: Text("Cancel"),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(10),
                    child: RaisedButton(
                      onPressed: () {
                        _register();
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

import 'package:dockmate/pages/authentication/firstScreen.dart';
import 'package:flutter/material.dart';

class ForgotPassword extends StatefulWidget {
  ForgotPassword({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Image.asset("assets/dock.png", scale: 20, color: Colors.white),
        title: Text("Dock Mate"),
      ),
      body: Center(
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 120),
          child: ListView(
            // mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              ListTile(
                  title: Text("Forgot your password?",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 23))),
              ListTile(
                  title: Text(
                      "No worries! Enter your account's email and we'll send you a password reset link.")),
              ListTile(
                  title: TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(), labelText: "Email"),
              )),
              ListTile(
                  title: RaisedButton(
                color: Colors.blue,
                onPressed: () {},
                child: Text("Send your password reset email",
                    style: TextStyle(color: Colors.white)),
              )),
            ],
          ),
        ),
      ),
    );
  }
}

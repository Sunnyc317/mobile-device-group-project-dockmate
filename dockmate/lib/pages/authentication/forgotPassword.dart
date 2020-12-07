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
          margin: EdgeInsets.only(top: 200, bottom: 300),
          child: Column(
            // mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text("Reset your password"),
              TextField(
                decoration: InputDecoration(labelText: "email"),
              ),
              RaisedButton(
                onPressed: () {},
                child: Text("Submit"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

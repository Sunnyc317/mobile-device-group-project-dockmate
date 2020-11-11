import 'package:dockmate/Register/firstScreen.dart';
import 'package:dockmate/Register/forgotPassword.dart';
import 'package:dockmate/Register/register.dart';
import 'package:flutter/material.dart';

class LogInScreen extends StatefulWidget {
  LogInScreen({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _LogInScreenState createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset("assets/placeholder_icon.png", scale: 20),
            Text("Dock Mate"),
          ],
        ),
      ),
      body: Center(
        child: Container(
          margin: EdgeInsets.only(top: 200, bottom: 200),
          child: Column(
            // mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text("Welcome Back"),
              TextField(
                decoration: InputDecoration(labelText: "Username"),
              ),
              TextField(
                decoration: InputDecoration(labelText: "*********"),
              ),
              Container(
                alignment: Alignment.centerLeft,
                child: FlatButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ForgotPassword()));
                  },
                  child: Text("Forgot Password?"),
                ),
              ),
              RaisedButton(
                onPressed: () {},
                child: Text("Login"),
              ),
              FlatButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Register()));
                },
                child: Text("New User? Register Here!"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

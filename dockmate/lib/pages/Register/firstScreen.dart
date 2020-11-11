import 'package:dockmate/Register/logIn.dart';
import 'package:dockmate/Register/register.dart';
import 'package:flutter/material.dart';

class FirstScreen extends StatefulWidget {
  FirstScreen({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _FirstScreenState createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          margin: EdgeInsets.only(top: 200, bottom: 300),
          child: Column(
            // mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Image.asset("assets/placeholder_icon.png", scale: 7),
              RaisedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LogInScreen()),
                  );
                },
                child: Text("Returning User"),
              ),
              RaisedButton(
                child: Text("New User"),
                onPressed: () { Navigator.push(context, MaterialPageRoute(builder: (context) => Register()), ); },
              )
            ],
          ),
        ),
      ),
    );
  }
}

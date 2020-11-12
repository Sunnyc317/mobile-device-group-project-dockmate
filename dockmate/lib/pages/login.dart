import 'package:dockmate/pages/old/firstScreen_S.dart';
import 'package:dockmate/pages/forgotPassword.dart';
import 'package:dockmate/pages/register.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  Login({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset("assets/dock.png", scale: 20, color: Colors.white),
            Text("Dock Mate"),
          ],
        ),
      ),
      body: Center(
        child: Container(
          // margin: EdgeInsets.only(top: 200, bottom: 200),
          child: Column(
            // mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Text("Welcome Back"),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Username',
                  border: OutlineInputBorder(),
                ),
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
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
                onPressed: () {
                  Navigator.of(context).pushReplacementNamed('/Listings');
                },
                child: Text("Login"),
              ),
              FlatButton(
                onPressed: () {
                  Navigator.of(context).pushReplacementNamed('/Register');
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

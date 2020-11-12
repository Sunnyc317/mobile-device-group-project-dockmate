import 'package:dockmate/pages/newUser_housingType.dart';
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
              child: Image.asset("assets/dock.png",
                  scale: 20, color: Colors.white),
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
              ),
              TextField(
                decoration: InputDecoration(hintText: "Last Name"),
              ),
              TextField(
                decoration: InputDecoration(hintText: "Email"),
              ),
              TextField(
                decoration: InputDecoration(hintText: "Phone Number"),
              ),
              TextField(
                decoration: InputDecoration(hintText: "Password"),
              ),
              TextField(
                decoration: InputDecoration(hintText: "Re-enter Password"),
              ),
              Row(
                children: [
                  Container(
                    margin: EdgeInsets.all(10),
                    child: RaisedButton(
                      onPressed: () {
                        Navigator.of(context).pushReplacementNamed('/Login');
                      },
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

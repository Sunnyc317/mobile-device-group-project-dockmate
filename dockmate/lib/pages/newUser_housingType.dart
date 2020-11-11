import 'package:dockmate/pages/logIn.dart';
import 'package:dockmate/pages/register.dart';
import 'package:flutter/material.dart';

class HousingType extends StatefulWidget {
  HousingType({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _HousingTypeState createState() => _HousingTypeState();
}

class _HousingTypeState extends State<HousingType> {
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
          margin: EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            // mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              // Image.asset("assets/placeholder_icon.png", scale: 7),
              Row(
                children: [
                  RaisedButton(
                    onPressed: () {},
                    child: Column(
                      children: [
                        Image.asset("assets/placeholder_icon.png", scale: 10),
                        Text("House"),
                      ],
                    ),
                  ),
                  RaisedButton(
                    child: Column(
                      children: [
                        Image.asset("assets/placeholder_icon.png", scale: 10),
                        Text("Condo/Apt"),
                      ],
                    ),
                    onPressed: () {},
                  )
                ],
              ),
              Row(
                children: [
                  RaisedButton(
                    onPressed: () {},
                    child: Column(
                      children: [
                        Image.asset("assets/placeholder_icon.png", scale: 10),
                        Text("Single Room"),
                      ],
                    ),
                  ),
                  RaisedButton(
                    child: Column(
                      children: [
                        Image.asset("assets/placeholder_icon.png", scale: 10),
                        Text("Shared Space"),
                      ],
                    ),
                    onPressed: () {},
                  )
                ],
              ),
              Row(
                children: [
                  RaisedButton(
                    onPressed: () {},
                    child: Column(
                      children: [
                        Image.asset("assets/placeholder_icon.png", scale: 10),
                        Text("Long-term"),
                      ],
                    ),
                  ),
                  RaisedButton(
                    child: Column(
                      children: [
                        Image.asset("assets/placeholder_icon.png", scale: 10),
                        Text("Short-term"),
                      ],
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
              RaisedButton(
                child: Column(
                  children: [
                    Image.asset("assets/placeholder_icon.png", scale: 10),
                    Text("I'm a landlord"),
                  ],
                ),
                onPressed: () {},
              ), 
              TextField(decoration: InputDecoration(hintText: "City/Town/Postal Code"),), 
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RaisedButton(
                    child: Text("Skip"),
                    onPressed: () {Navigator.of(context).pushNamed('/Listings');},
                  ),
                  RaisedButton(
                    child: Text("All Set!"),
                    onPressed: () {Navigator.of(context).pushNamed('/Listings');},
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

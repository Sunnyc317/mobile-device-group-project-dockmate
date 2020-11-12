import 'package:dockmate/model/user.dart';
import 'package:dockmate/pages/logIn.dart';
import 'package:flutter/material.dart';
import 'package:dockmate/utils/notifications.dart';

class HousingType extends StatefulWidget {
  final String title;
  User user; 

  HousingType({Key key, this.title, this.user}) : super(key: key);

  @override
  _HousingTypeState createState() => _HousingTypeState();
}

class _HousingTypeState extends State<HousingType> {
  List<String> preferedList;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  _allset(){
    widget.user.preferedHouseTypes = preferedList;
    Navigator.of(context).pushNamed('/Settings');
  }

  @override
  Widget build(BuildContext context) {
    final _notifications = Notifications();
    _notifications.init();

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
              TextField(
                decoration: InputDecoration(hintText: "City/Town/Postal Code"),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RaisedButton(
                    child: Text("Skip"),
                    onPressed: () async {
                      await _notifications.sendNotificationNow(
                          "Welcome to Dockmate!",
                          "You have successfully joined Dockmate, check the app now",
                          "something");
                      Navigator.of(context).pushReplacementNamed('/Listings');
                    },
                  ),
                  RaisedButton(
                    child: Text("All Set!"),

                    onPressed: () async {
                      await _notifications.sendNotificationNow(
                          "Welcome to Dockmate!",
                          "You have successfully joined Dockmate, check the app now",
                          "something");
                      Navigator.of(context).pushReplacementNamed('/Listings');
                    },
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

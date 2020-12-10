import 'package:dockmate/model/user.dart' as usermodel;
import 'package:dockmate/utils/auth.dart';
import 'package:flutter/material.dart';
import 'package:dockmate/utils/bottombar.dart';
import 'package:dockmate/model/username.dart';

class Settings extends StatefulWidget {
  // String title;
  // usermodel.User user;
  final Function toggleView;
  Settings({Key key, this.toggleView}):super(key:key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final _formKey = GlobalKey<FormState>();
  UsernameModel usernameModel = UsernameModel();
  String newUsername = "First Name";

  Future<void> _getUsername() async {
    Username name = await usernameModel.getUsername();
    print("anything: $name");
    setState(() {
      newUsername = name.username;
    });
  }

  @override
  void initState() {
    super.initState();
    _getUsername();
  }

  @override
  Widget build(BuildContext context) {
    AuthService _auth = AuthService();

    // Future<String> initSampleName() async {
    //   // print("creating new username");
    //   // usernameModel.setUsername(newUsername);
    //   Username name = await usernameModel.getUsername();
    //   print("anything: $name");
    //   setState(() {
    //     newUsername = name.username;
    //   });
    // }

    return Scaffold(
      appBar: AppBar(
        leading: Image.asset("assets/dock.png", scale: 20, color: Colors.white),
        title: Text('Settings'),
      ),
      body: Container(
          margin: EdgeInsets.only(top: 55, bottom: 5),
          child: Center(
              // margin: EdgeInsets.only(top: 30, bottom: 5, left: 20),
              child: Form(
            key: _formKey,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                      margin: EdgeInsets.symmetric(vertical: 8.0),
                      child: Text("Signed in as: $newUsername",
                          style: TextStyle(fontSize: 20))),
                  Container(
                      margin: EdgeInsets.symmetric(vertical: 4.0),
                      child: ButtonTheme(
                          minWidth: 200,
                          child: RaisedButton(
                            color: Colors.white60,
                            child: Text('Edit Profile'),
                            onPressed: () {},
                          ))),
                  Container(
                      margin: EdgeInsets.symmetric(vertical: 4.0),
                      child: ButtonTheme(
                          minWidth: 200,
                          child: RaisedButton(
                            color: Colors.white60,
                            child: Text('Change Language'),
                            onPressed: () {},
                          ))),

                  Container(
                      margin: EdgeInsets.symmetric(vertical: 4.0),
                      child: ButtonTheme(
                          minWidth: 200,
                          child: RaisedButton(
                            // color: Colors.white60,
                            child: Text('Sign Out',
                                style: TextStyle(color: Colors.white)),
                            onPressed: () {
                              _auth.signOut();
                            },
                          ))),
                  // TextFormField(
                  //   onChanged: (String value) {
                  //     newUsername = value;
                  //   },
                  // ),
                  // RaisedButton(onPressed: () => initSampleName()),
                ]),
          ))),
      bottomNavigationBar: BottomBar(bottomIndex: 4, toggleView: widget.toggleView,),
    );
  }
}

import 'package:dockmate/model/user.dart' as usermodel;
import 'package:dockmate/utils/auth.dart';
import 'package:flutter/material.dart';
import 'package:dockmate/utils/bottombar.dart';
import 'package:dockmate/model/username.dart';

class Settings extends StatefulWidget {
  String title;
  usermodel.User user;
  Settings({this.title, this.user});

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
      appBar: AppBar(title: Text('Settings'), actions: [
        FlatButton(
          child: Text('Sign Out'),
          onPressed: () {
            _auth.signOut();
          },
        )
      ]),
      body: Center(
          child: Form(
        key: _formKey,
        child: Column(children: [
          Text("Current username", style: TextStyle(fontSize: 30)),
          Text(newUsername),
          // TextFormField(
          //   onChanged: (String value) {
          //     newUsername = value;
          //   },
          // ),
          // RaisedButton(onPressed: () => initSampleName()),
        ]),
      )),
      bottomNavigationBar: BottomBar(bottomIndex: 4),
    );
  }
}

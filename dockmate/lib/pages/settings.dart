import 'package:flutter/material.dart';
import 'package:dockmate/utils/bottombar.dart';
import 'package:dockmate/model/username.dart';

class Settings extends StatefulWidget {
  String title;
  Settings({this.title});

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final _formKey = GlobalKey<FormState>();
  UsernameModel usernameModel = UsernameModel();
  String newUsername = "First Name";

  @override
  Widget build(BuildContext context) {
    Future<String> initSampleName() async {
      print("creating new username");
      usernameModel.setUsername(newUsername);
      Username name = await usernameModel.getUsername();
      print("anything: $name");
      setState(() {
        newUsername = name.username;
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Center(
          child: Form(
        key: _formKey,
        child: Column(children: [
          Text("Current username", style: TextStyle(fontSize: 30)),
          Text(newUsername),
          TextFormField(
            onChanged: (String value) {
              newUsername = value;
            },
          ),
          RaisedButton(onPressed: () => initSampleName()),
        ]),
      )),
      bottomNavigationBar: BottomBar(bottomIndex: 4),
    );
  }
}

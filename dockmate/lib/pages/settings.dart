import 'package:flutter/material.dart';
import 'package:dockmate/utils/bottombar.dart';

class Settings extends StatefulWidget {
  String title;
  Settings({this.title});

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Center(
        child: Text("Placeholder for settings"),
      ),
      bottomNavigationBar: BottomBar(bottomIndex: 4),
    );
  }
}

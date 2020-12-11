import 'package:flutter/material.dart';

class SelectLanguage extends StatefulWidget {
  @override
  _SelectLanguageState createState() => _SelectLanguageState();
}

class _SelectLanguageState extends State<SelectLanguage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Select Language')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(padding: EdgeInsets.all(8), children: [
          ListTile(
            title: Text('English'),
            onTap: () {},
          ),
          ListTile(
            title: Text('French'),
            onTap: () {},
          ),
          SizedBox(height: 50),
          RaisedButton(
            child: Text('Confirm',
                style: TextStyle(fontSize: 20, color: Colors.white)),
            onPressed: () {},
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
            ),
            color: Colors.blue,
          )
        ]),
      ),
    );
  }
}

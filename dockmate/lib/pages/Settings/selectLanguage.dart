import 'package:flutter/material.dart';

class SelectLanguage extends StatefulWidget {
  @override
  _SelectLanguageState createState() => _SelectLanguageState();
}


class _SelectLanguageState extends State<SelectLanguage> {
int _selectedIndex;
String language = 'English';
  @override
  void initState() {
    _selectedIndex = 0;
    language = 'English';
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    // String language = 'English';
    return Scaffold(
      appBar: AppBar(title: Text('Select Language')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(padding: EdgeInsets.all(8), children: [
          ListTile(
            title: Text('English'),
            tileColor:
                _selectedIndex == 0 ? Colors.blue[100] : Colors.white,
            onTap: () {
              setState(() {
                _selectedIndex = 0;
                language = 'English';
              });
              // language = 'English';
            },
          ),
          ListTile(
            title: Text('French'),
            tileColor:
                _selectedIndex == 1 ? Colors.blue[100] : Colors.white,
            onTap: () {
              setState(() {
                _selectedIndex = 1;
                language = 'French';
              });
            },
          ),
          SizedBox(height: 50),
          RaisedButton(
            child: Text('Confirm',
                style: TextStyle(fontSize: 20, color: Colors.white)),
            onPressed: () {
              if (language == 'English') {
                // Locale newLocale = Locale('en');
                Navigator.pop(context, 'en');
              } else if (language == 'French') {
                // Locale newLocale = Locale('fr');
                Navigator.pop(context, 'fr');
              }
            },
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

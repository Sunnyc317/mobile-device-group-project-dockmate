import 'package:flutter/material.dart';
import './utils/bottombar.dart';
import './pages/login.dart';
import './pages/register.dart';
import './pages/chat.dart';
import './pages/settings.dart';
import './pages/listings.dart';
import './pages/my_listing.dart';
import './pages/map.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dock Mate',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Dock Mate!'),
      routes: <String, WidgetBuilder>{
        '/Login': (BuildContext context) => Login(),
        '/Listing': (BuildContext context) => Listings(),
        '/Chat': (BuildContext context) => Chat(),
        '/Map': (BuildContext context) => Map(),
        '/MyListing': (BuildContext context) => MyListing(),
        '/Settings': (BuildContext context) => Settings(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _bottomIndex = 0;

  void _setBottomIndex(int i) {
    setState(() {
      _bottomIndex = i;
    });
    if (i > 0) {
      print("Page not created yet");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
          Image.asset('assets/images/logo.jpeg', width: 200),
          const SizedBox(height: 50),
          ButtonTheme(
              minWidth: 200,
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                ),
                color: Colors.white60,
                child: const Text('Returning User',
                    style: TextStyle(fontSize: 20)),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Login()),
                  );
                },
              )),
          const SizedBox(height: 30),
          ButtonTheme(
              minWidth: 200,
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                ),
                child: const Text('New User', style: TextStyle(fontSize: 20)),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Login()),
                  );
                },
              )),
        ]),
      ),
    );
    /*return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Hi :D',
            ),
          ],
        ),
      ),
      bottomNavigationBar:
          BottomBar(bottomIndex: _bottomIndex, setBottomIndex: _setBottomIndex),
    );*/
  }
}

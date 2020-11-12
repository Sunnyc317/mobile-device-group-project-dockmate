import 'package:dockmate/model/user.dart';
import 'package:dockmate/pages/old/newUser_addressInfo.dart';
import 'package:dockmate/pages/warpper.dart';
import 'package:dockmate/utils/auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

// import 'package:dockmate/pages/Register/firstScreen_S.dart';
// import './pages/login_old.dart';
// import 'package:dockmate/pages/register.dart';
import 'package:dockmate/pages/register_form.dart';
import 'package:dockmate/pages/firstScreen.dart';
import 'package:provider/provider.dart';
import 'pages/logIn.dart';
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
        '/Login': (BuildContext context) => Login(title: "Login"),
        '/Register': (BuildContext context) => Register(title: "Register"),
        '/Listings': (BuildContext context) => Listings(title: "Listings"),
        '/Chat': (BuildContext context) => Chat(title: "All Messages"),
        '/Map': (BuildContext context) => Map(title: "Find a House"),
        '/MyListings': (BuildContext context) =>
            MyListing(title: "My Listings"),
        '/Settings': (BuildContext context) => Settings(title: "Settings"),
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
  bool _initialized = false; 
  bool _error = false;
  int _bottomIndex = 0;

  void _setBottomIndex(int i) {
    setState(() {
      _bottomIndex = i;
    });
    if (i > 0) {
      print("Page not created yet");
    }
  }

  void initializeFlutterFire() async {
    try {
      await Firebase.initializeApp();
      setState(() {
        _initialized = true;
      });
    } catch(e) {
      print(e.toString());
      setState(() {
        _error = true;
        
      });
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    initializeFlutterFire();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // return FirstScreen(title: 'Dock Mate');
      
    // streamProvider for listening to the stream of user status in auth.dart
    // specifying the type streaming is User as in user.dart
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: Wrapper(),
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

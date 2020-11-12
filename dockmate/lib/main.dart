import 'package:flutter/material.dart';
import 'package:dockmate/pages/login.dart';
import 'package:dockmate/pages/chat.dart';
import 'package:dockmate/pages/settings.dart';
import 'package:dockmate/pages/listings.dart';
import 'package:dockmate/pages/my_listing.dart';
import 'package:dockmate/pages/map.dart';
import 'package:dockmate/pages/register.dart';
import 'package:dockmate/pages/firstScreen.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  //final Future<FirebaseApp> _initialization = Firebase.initializeApp();

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
        '/Chat': (BuildContext context) => Chatroom(title: "All Messages"),
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
  @override
  Widget build(BuildContext context) {
    return FirstScreen(title: 'Dock Mate');
  }
}

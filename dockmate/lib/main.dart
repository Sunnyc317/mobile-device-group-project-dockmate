import 'package:dockmate/model/user.dart' as usermodel;
import 'package:dockmate/utils/auth.dart';
import 'package:dockmate/utils/wrapper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider<usermodel.User>.value(value: AuthService().user),
        StreamProvider<User>.value(value: AuthService().userstatus),
      ],
      // return StreamProvider.value(
      //   value: AuthService().user,
      child: MaterialApp(
        title: 'Dock Mate',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: MyHomePage(title: 'Dock Mate!'),
        routes: <String, WidgetBuilder>{},
      ),
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

  void initializeFlutterFire() async {
    try {
      await Firebase.initializeApp();
      setState(() {
        _initialized = true;
      });
    } catch (e) {
      setState(() {
        _error = true;
      });
    }
  }

  @override
  void initState() {
    initializeFlutterFire();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (_error) {
      return _InitializingPage(text: 'error initializing firebase');
    }

    if (!_initialized) {
      return _InitializingPage(text: 'Loading...');
    }

    // Wrapper listen to authentication status change and send user to AUTH pages or Postings
    return Wrapper();
  }
}

class _InitializingPage extends StatelessWidget {
  // var title;
  var text;
  _InitializingPage({this.text});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Image.asset("assets/dock.png", scale: 20, color: Colors.white),
        title: Text('Dockmate'),
      ),
      body: Center(
        child: Text(text),
      ),
    );
  }
}

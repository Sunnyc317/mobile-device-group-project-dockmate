import 'package:dockmate/model/user.dart' as usermodel;
import 'package:dockmate/utils/auth.dart';
import 'package:dockmate/utils/language.dart';
import 'package:dockmate/utils/wrapper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_i18n/flutter_i18n_delegate.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_i18n/loaders/decoders/json_decode_strategy.dart';
import 'package:flutter_i18n/loaders/local_translation_loader.dart';

void main() async {
  final FlutterI18nDelegate flutterI18nDelegate = FlutterI18nDelegate(
    translationLoader: FileTranslationLoader(
        useCountryCode: false,
        fallbackFile: 'en',
        basePath: 'assets/flutter_i18n'),
  );
  // WidgetsFlutterBinding.ensureInitialized();
  await flutterI18nDelegate.load(null);
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp(flutterI18nDelegate));
}

class MyApp extends StatelessWidget {
  final FlutterI18nDelegate flutterI18nDelegate;

  MyApp(this.flutterI18nDelegate);
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider<usermodel.User>.value(value: AuthService().user),
        StreamProvider<User>.value(value: AuthService().userstatus),
        Provider<String>.value(value: Language().lang),
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
        localizationsDelegates: [
          flutterI18nDelegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
          // FlutterI18nDelegate(
          //   translationLoader: LocalTranslationLoader(
          //     basePath: 'assets/flutter_i18n',
          //     decodeStrategies: [
          //       JsonDecodeStrategy(),
          //     ],
          //   ),
          // ),
          // GlobalMaterialLocalizations.delegate,
          // GlobalWidgetsLocalizations.delegate,
        ],
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

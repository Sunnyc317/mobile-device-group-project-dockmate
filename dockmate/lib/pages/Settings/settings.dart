import 'package:dockmate/model/user.dart' as usermodel;
import 'package:dockmate/pages/Settings/changePassword.dart';
import 'package:dockmate/pages/Settings/editProfile.dart';
import 'package:dockmate/pages/Settings/selectLanguage.dart';
import 'package:dockmate/pages/Settings/survey.dart';
import 'package:dockmate/utils/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:dockmate/utils/bottombar.dart';
import 'package:dockmate/model/username.dart';
import 'package:provider/provider.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_i18n/flutter_i18n_delegate.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class Settings extends StatefulWidget {
  // String title;
  // usermodel.User user;
  final Function toggleView;
  Settings({Key key, this.toggleView}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final _formKey = GlobalKey<FormState>();
  usermodel.User locuser;

  @override
  Widget build(BuildContext context) {
    AuthService _auth = AuthService();
    final user = Provider.of<User>(context);
    final modelUser = Provider.of<usermodel.User>(context);
    locuser = modelUser;

    String userName = user.displayName;

    if (user.isAnonymous) {
      setState(() {
        userName = 'Guest';
      });
    } else if (userName == null) {
      print('no user name');
      userName = 'nousername';
    }

    return Scaffold(
      appBar: AppBar(
        leading: Image.asset("assets/dock.png", scale: 20, color: Colors.white),
        title: Text('Settings'),
      ),
      body: Container(
          margin: EdgeInsets.only(top: 10, bottom: 5),
          child: Padding(
              padding: EdgeInsets.only(top: 5),
              // margin: EdgeInsets.only(top: 30, bottom: 5, left: 20),
              child: Form(
                key: _formKey,
                child: ListView(padding: EdgeInsets.all(8), children: [
                  ListTile(
                    title: Wrap(children: [
                      
                      Text(
                        // "Signed in as: ",
                        FlutterI18n.translate(context, "Settings.Status"),
                        style: TextStyle(
                            fontSize: 20,
                            color: Color.fromRGBO(88, 126, 163, 1)),
                      ),
                      Text(
                        userName,
                        style: TextStyle(
                            fontSize: 20,
                            color: Color.fromRGBO(27, 70, 112, 1)),
                      )
                    ]),
                  ),
                  Builder(
                    builder: (context) => ListTile(
                      title: Text(FlutterI18n.translate(context, "Settings.EditProfile"),),
                      leading: Icon(Icons.edit),
                      onTap: () {
                        if (user.isAnonymous) {
                          Scaffold.of(context).showSnackBar(SnackBar(
                              content: Text('can\'t edit profile as a guest')));
                        } else {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      EditProfile(user: locuser)));
                        }
                      },
                    ),
                  ),
                  ListTile(
                    title: Text(FlutterI18n.translate(context, "Settings.SelectLanguage"),),
                    leading: Icon(Icons.flag),
                    onTap: () async {
                      String lang = await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SelectLanguage()));
                      Locale newLocale = Locale(lang);
                      await FlutterI18n.refresh(context, newLocale);
                      setState(() {});
                    },
                  ),
                  Builder(
                    builder: (context) => ListTile(
                      title: Text(FlutterI18n.translate(context, "Settings.ChangePassword")),
                      leading: Icon(Icons.security),
                      onTap: () async {
                        if (user.isAnonymous) {
                          Scaffold.of(context).showSnackBar(SnackBar(
                              content:
                                  Text('can\'t change password as a guest')));
                        } else {
                          await Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ChangePassword()));

                          Scaffold.of(context).showSnackBar(SnackBar(
                              content: Text('password updated successfully')));
                        }
                      },
                    ),
                  ),
                  ListTile(
                      title: Text(
                        'Take a Survey!',
                      ),
                      leading: Icon(Icons.lightbulb),
                      onTap: () async {
                        await Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Survey()));
                      }),
                  ListTile(
                      title: Text(FlutterI18n.translate(context, "Settings.Logout"),
                          style: TextStyle(
                              color: Color.fromRGBO(222, 115, 89, 1))),
                      leading: Icon(Icons.exit_to_app),
                      onTap: () {
                        _auth.signOut();
                      }),
                ]),
              ))),
      bottomNavigationBar: BottomBar(
        bottomIndex: 4,
        toggleView: widget.toggleView,
      ),
    );
  }
}

import 'package:dockmate/model/user.dart' as usermodel;
import 'package:dockmate/pages/Settings/editProfile.dart';
import 'package:dockmate/pages/Settings/selectLanguage.dart';
import 'package:dockmate/utils/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:dockmate/utils/bottombar.dart';
import 'package:dockmate/model/username.dart';
import 'package:provider/provider.dart';

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
                        "Signed in as: ",
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
                  ListTile(
                    title: Text('Edit Profile'),
                    leading: Icon(Icons.edit),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  EditProfile(user: locuser)));
                    },
                  ),
                  ListTile(
                    title: Text('Select Language'),
                    leading: Icon(Icons.flag),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SelectLanguage()));
                    },
                  ),
                  ListTile(
                    title: Text('Change Password'),
                    leading: Icon(Icons.security),
                    onTap: () {},
                  ),
                  ListTile(
                      title: Text('Log Out',
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

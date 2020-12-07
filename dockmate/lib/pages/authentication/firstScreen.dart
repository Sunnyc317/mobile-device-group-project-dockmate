import 'package:dockmate/utils/auth.dart';
import 'package:flutter/material.dart';

class FirstScreen extends StatefulWidget {
  final Function toggleView;
  FirstScreen({Key key, this.toggleView}) : super(key: key);

  @override
  _FirstScreenState createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  @override
  Widget build(BuildContext context) {
    final AuthService _auth = AuthService();

    return Scaffold(
      appBar: AppBar(
        leading: Image.asset("assets/dock.png", scale: 20, color: Colors.white),
        title: Text('Dock Mate (Authentication)'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Image.asset('assets/dock.png', width: 200),
            Container(
                margin: EdgeInsets.only(top: 50, bottom: 5),
                child: ButtonTheme(
                    minWidth: 200,
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      ),
                      color: Colors.white60,
                      child: const Text('Returning User',
                          style: TextStyle(fontSize: 20)),
                      onPressed: () {
                        widget.toggleView('login');
                        // Navigator.of(context).pushReplacementNamed('/Login');
                      },
                    ))),
            Container(
                margin: EdgeInsets.symmetric(vertical: 15),
                child: ButtonTheme(
                  minWidth: 200,
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    ),
                    child: const Text('New User',
                        style: TextStyle(fontSize: 20, color: Colors.white)),
                    onPressed: () {
                      widget.toggleView('register');
                      // Navigator.of(context).pushReplacementNamed('/Register');
                    },
                  ),
                )),
            Container(
                margin: EdgeInsets.only(top: 5),
                child: ButtonTheme(
                  minWidth: 200,
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    ),
                    color: Colors.white60,
                    child: const Text('Guest Login',
                        style: TextStyle(fontSize: 20)),
                    onPressed: () async {
                      // call anon sign in function
                      var reselt = await _auth.signInAnon();

                      // Navigator.of(context).pushReplacementNamed('/Login');
                    },
                  ),
                )),
          ],
        ),
      ),
    );
  }
}

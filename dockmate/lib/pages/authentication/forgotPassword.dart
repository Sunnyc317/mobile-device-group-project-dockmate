import 'package:dockmate/pages/authentication/firstScreen.dart';
import 'package:dockmate/utils/auth.dart';
import 'package:flutter/material.dart';

class ForgotPassword extends StatefulWidget {
  ForgotPassword({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  String email;
  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    AuthService _auth = AuthService();
    String msg;
    String email;

    return Scaffold(
      appBar: AppBar(
        leading: Image.asset("assets/dock.png", scale: 20, color: Colors.white),
        title: Text("Dock Mate"),
      ),
      body: Center(
        child: Container(
          margin: EdgeInsets.only(top: 120),
          child: Form(
            key: _formKey,
            child: ListView(
              // mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                ListTile(
                    title: Text("Forgot your password?",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 23))),
                ListTile(
                    title: Text(
                        "No worries! Enter your account's email and we'll send you a password reset link.")),
                ListTile(
                  title: TextFormField(
                    validator: (val) {
                      if (val.isEmpty) {
                        return 'Please enter your email';
                      }
                      return null;
                    },
                    onSaved: (val) {
                      email = val;
                    },
                    decoration: InputDecoration(
                        border: OutlineInputBorder(), labelText: "Email"),
                  ),
                ),
                ListTile(
                  title: Builder(
                    builder: (context) => RaisedButton(
                      color: Colors.blue,
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          _formKey.currentState.save();
                          var result = await _auth.resetPassword(email);
                          if (result['linksent']) {
                            Scaffold.of(context).showSnackBar(
                                SnackBar(content: Text(result['msg'])));
                            Future.delayed(const Duration(seconds: 2),
                                () => Navigator.pop(context, email));
                          } else {
                            Scaffold.of(context).showSnackBar(
                                SnackBar(content: Text(result['msg'])));
                          }
                        }
                      },
                      child: Text("Send your password reset email",
                          style: TextStyle(color: Colors.white)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

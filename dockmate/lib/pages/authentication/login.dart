import 'package:dockmate/pages/authentication/firstScreen.dart';
import 'package:dockmate/pages/authentication/forgotPassword.dart';
import 'package:dockmate/pages/authentication/register.dart';
import 'package:flutter/material.dart';
import 'package:dockmate/utils/auth.dart';

class Login extends StatefulWidget {
  final Function toggleView;
  Login({Key key, this.toggleView}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    // final user = Providor.of<usermodel.User>(Context);
    final _formKey = GlobalKey<FormState>();
    String email;
    String password;
    AuthService _auth = AuthService();

    return Scaffold(
      appBar: AppBar(
        leading: Image.asset("assets/dock.png", scale: 20, color: Colors.white),
        title: Text("Dock Mate"),
      ),
      body: Center(
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 120),
          // margin: EdgeInsets.only(top: 200, bottom: 200),
          child: Form(
            key: _formKey,
            child: ListView(
              // mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                ListTile(
                    title: Text("Welcome back!",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 23))),
                ListTile(
                    title: TextFormField(
                  validator: (val) {
                    if (val.isEmpty) {
                      return 'Please enter your email';
                    }
                    return null;
                  },
                  onChanged: (val) {
                    email = val;
                  },
                  decoration: InputDecoration(
                    hintText: 'Email',
                    border: OutlineInputBorder(),
                  ),
                )),
                ListTile(
                    title: TextFormField(
                  validator: (val) {
                    if (val.isEmpty) {
                      return 'Please enter your password';
                      setState(() {});
                    }
                    return null;
                  },
                  onChanged: (val) {
                    password = val;
                  },
                  decoration: InputDecoration(
                    hintText: 'Password',
                    border: OutlineInputBorder(),
                  ),
                )),
                Container(
                  alignment: Alignment.centerLeft,
                  child: FlatButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ForgotPassword()));
                    },
                    child: Container(
                        margin: EdgeInsets.only(left: 5.5),
                        child: Text("Forgot Password?",
                            style: TextStyle(color: Colors.blue))),
                  ),
                ),
                Builder(
                    builder: (context) => Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: 100, vertical: 5),
                          child: RaisedButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                            ),
                            color: Colors.blue,
                            child: Text(
                              "Login",
                              style: TextStyle(fontSize: 20, color: Colors.white)),
                            onPressed: () async {
                              _formKey.currentState.save();
                              dynamic result =
                                  await _auth.signinwithEmail(email, password);

                              if (result['user'] == null) {
                                print('user is null');
                                Scaffold.of(context).showSnackBar(
                                    SnackBar(content: Text(result['msg'])));
                              } else {
                                setState(() {});
                              }
                            },
                          ),
                        )),
                Container(
                  margin: EdgeInsets.only(top: 5, left: 100, right: 100),
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
                  ),
                ),
                SizedBox(height: 20,),
                FlatButton(
                  child: Text("New User? Register Here!",
                      style: TextStyle(color: Colors.blue)),
                  onPressed: () {
                    widget.toggleView('register');
                    // Navigator.of(context).pushReplacementNamed('/Register');
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:dockmate/model/usersqfModel.dart';
import 'package:dockmate/pages/authentication/forgotPassword.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:dockmate/utils/auth.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  final Function toggleView;
  bool verified;
  User user;
  Login({Key key, this.toggleView, this.user, this.verified}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  // bool changed = false;
  @override
  Widget build(BuildContext context) {
    final _model = UserModel();
    final userstatus = Provider.of<User>(context);
    final _formKey = GlobalKey<FormState>();
    User user = widget.user;
    bool verified = widget.verified;
    String email;
    String password;
    AuthService _auth = AuthService();
    // if (!changed) {
    //   user = widget.user;
    //   verified = widget.verified;
    // }

    return Scaffold(
      appBar: AppBar(
        leading: Image.asset("assets/dock.png", scale: 20, color: Colors.white),
        title: Text("Dock Mate"),
      ),
      body: Center(
        child: Container(
          margin: EdgeInsets.only(top: 120),
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
                  onTap: () {
                    if (userstatus != null) {
                      _auth.signOut();
                    }
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
                    }
                    return null;
                  },
                  onChanged: (val) {
                    password = val;
                  },
                  obscureText: true,
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
                  builder: (context) {
                    print('user: $user, verified: $verified');
                    if (userstatus != null && !userstatus.emailVerified) {
                      // changed = true;
                      return Center(
                        child: Text(
                          '${userstatus.email} is not verified \nAn verification email is on the way, please verify again',
                          style: TextStyle(color: Colors.red),
                        ),
                      );

                      // Scaffold.of(context).showSnackBar(SnackBar(
                      //     content: Text(
                      //         '${widget.user.email} is not verified, \nAn varification email is on the way, please varify again')));
                    } else {
                      return Text('');
                    }
                  },
                ),
                Builder(
                  builder: (context) => Container(
                    margin: EdgeInsets.symmetric(horizontal: 100, vertical: 5),
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      ),
                      color: Colors.blue,
                      child: Text("Login",
                          style: TextStyle(fontSize: 20, color: Colors.white)),
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          _formKey.currentState.save();
                          dynamic result =
                              await _auth.signinwithEmail(email, password);

                          if (result['user'] == null) {
                            print('user is null');
                            Scaffold.of(context).showSnackBar(
                                SnackBar(content: Text(result['msg'])));
                          } else {
                            _model.insertUser(result['user']);
                            bool idNotExist =
                                await _model.idNotExist(result['user'].id);
                            if (idNotExist) {
                              _model.insertUser(result['user']);
                              print('created user ${result['user']}');
                            }
                            print(result['msg']);
                          }
                        }
                      },
                    ),
                  ),
                ),
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
                // SizedBox(
                //   height: 20,
                // ),
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
      // }),
    );
  }
}

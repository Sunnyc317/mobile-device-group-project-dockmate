import 'package:dockmate/model/usersqfModel.dart';
import 'package:dockmate/pages/authentication/firstScreen.dart';
import 'package:dockmate/pages/authentication/forgotPassword.dart';
import 'package:dockmate/pages/authentication/register.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:dockmate/utils/auth.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';

class ChangePassword extends StatefulWidget {
  // final Function toggleView;
  // bool verified;
  // User user;
  // ChangePassword({Key key, this.toggleView, this.user, this.verified}) : super(key: key);

  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  // bool changed = false;
  @override
  Widget build(BuildContext context) {
    final _model = UserModel();
    final userstatus = Provider.of<User>(context);
    final _formKey = GlobalKey<FormState>();
    // User user = widget.user;
    String password;
    String reEnterPassword;
    AuthService _auth = AuthService();
    // if (!changed) {
    //   user = widget.user;
    //   verified = widget.verified;
    // }

    return Scaffold(
      appBar: AppBar(
        // leading: Image.asset("assets/dock.png", scale: 20, color: Colors.white),
        title: Text("Change Password"),
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
                    title: Text("Enter new password"),
                    subtitle: TextFormField(
                      obscureText: true,
                      validator: (val) {
                        if (val.length > 0 && val.length < 8) {
                          return 'password need to have more than 8 characters';
                        }
                        return null;
                      },
                      onSaved: (val) {
                        password = val;
                      },
                      onChanged: (val) {
                        password = val;
                        // if (val.length > 0 && val.length < 8) {
                        //   return 'password need to have more than 8 characters';
                        // }
                        // return null;
                      },
                      decoration: InputDecoration(
                        hintText: 'new password',
                        border: OutlineInputBorder(),
                      ),
                    )),
                ListTile(
                    title: Text("Re-enter new password"),
                    subtitle: TextFormField(
                      validator: (val) {
                        if (val != password) {
                          return 'doesn\tt match with the password above';
                        }
                        return null;
                      },
                      onChanged: (val) {
                        reEnterPassword = val;
                      },
                      onSaved: (val) {
                        password = val;
                      },
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: 'Password',
                        border: OutlineInputBorder(),
                      ),
                    )),
                Builder(
                  builder: (context) => Container(
                    margin: EdgeInsets.symmetric(horizontal: 100, vertical: 5),
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      ),
                      color: Colors.blue,
                      child: Text("Submit",
                          style: TextStyle(fontSize: 20, color: Colors.white)),
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          _formKey.currentState.save();
                          dynamic result = await _auth.updatePassword(password);

                          if (result['updated']) {
                            print('password updated. suppose to pop navigator');
                            Scaffold.of(context).showSnackBar(
                                SnackBar(content: Text(result['msg'])));
                          } else {
                            Scaffold.of(context).showSnackBar(
                                SnackBar(content: Text(result['msg'])));
                          }
                        }
                      },
                    ),
                  ),
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

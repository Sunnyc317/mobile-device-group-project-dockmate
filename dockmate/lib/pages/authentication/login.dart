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
        title: Row(
          children: [
            Image.asset("assets/dock.png", scale: 20, color: Colors.white),
            Text("Dock Mate"),
          ],
        ),
      ),
      body: Center(
        child: Container(
          // margin: EdgeInsets.only(top: 200, bottom: 200),
          child: Form(
            key: _formKey,
            child: ListView(
              // mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                SizedBox(
                  height: 40,
                ),
                Text("Welcome Back"),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  onChanged: (val) {
                    email = val;
                  },
                  decoration: InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  onChanged: (val) {
                    password = val;
                  },
                  decoration: InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  child: FlatButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ForgotPassword()));
                    },
                    child: Text("Forgot Password?"),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Builder(
                  builder: (context) => RaisedButton(
                    child: Text("Login"),
                    onPressed: () async {
                      _formKey.currentState.save();
                      _auth.signinwithEmail(email, password);
                      setState(() {
                        
                      });
                      // dynamic result =
                      //     await _auth.signinwithEmail(email, password);

                      // if (result['user'] == null) {
                      //   Scaffold.of(context).showSnackBar(
                      //       SnackBar(content: Text(result['msg'])));
                      // } else {
                      //   Scaffold.of(context).showSnackBar(
                      //       SnackBar(content: Text(result['msg'])));
                      // }


                      // Navigator.of(context).pushReplacementNamed('/Listings');
                    },
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                FlatButton(
                  child: Text("New User? Register Here!"),
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

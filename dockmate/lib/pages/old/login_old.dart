import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  String title;
  Login({this.title});
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Center(
          child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text("Welcome Back!",
              style: TextStyle(
                  color: Colors.grey[800],
                  fontWeight: FontWeight.w900,
                  fontFamily: 'Open Sans',
                  fontSize: 30)),
          Container(
              margin: EdgeInsets.all(20),
              width: 350,
              child: TextFormField(
                decoration: const InputDecoration(
                  //icon: const Icon(Icons.person),
                  labelText: 'Username',
                  border: OutlineInputBorder(),
                ),
              )),
          Container(
              margin: EdgeInsets.all(10),
              width: 350,
              child: TextFormField(
                obscureText: true,
                decoration: const InputDecoration(
                  //icon: const Icon(Icons.lock),
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
              )),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
            Container(
                margin: EdgeInsets.only(right: 20),
                child: ButtonTheme(
                    height: 50,
                    child: RaisedButton(
                      color: Colors.white54,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      ),
                      child: const Text('Forgot Password',
                          style: TextStyle(fontSize: 18)),
                      onPressed: () {},
                    ))),
            ButtonTheme(
                height: 50,
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                  ),
                  child: const Text('Login', style: TextStyle(fontSize: 18)),
                  onPressed: () {
                    Navigator.of(context).pushReplacementNamed('/Listings');
                  },
                )),
          ])
        ],
      )),
    );
  }
}

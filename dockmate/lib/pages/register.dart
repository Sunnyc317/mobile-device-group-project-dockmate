import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  String title;
  Register({this.title});
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
      ),
      body: Center(
        child: Text("Placeholder for sign-up page"),
      ),
    );
  }
}

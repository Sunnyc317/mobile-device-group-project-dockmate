import 'package:flutter/material.dart';

class FirstScreen extends StatefulWidget {
  String title;

  FirstScreen({this.title});

  @override
  _FirstScreenState createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Image.asset("assets/dock.png", scale: 20, color: Colors.white),
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Image.asset('assets/dock.png', width: 200),
            const SizedBox(height: 50),
            ButtonTheme(
                minWidth: 200,
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                  ),
                  color: Colors.white60,
                  child: const Text('Returning User',
                      style: TextStyle(fontSize: 20)),
                  onPressed: () {
                    Navigator.of(context).pushReplacementNamed('/Login');
                  },
                )),
            const SizedBox(height: 30),
            ButtonTheme(
              minWidth: 200,
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                ),
                child: const Text('New User', style: TextStyle(fontSize: 20)),
                onPressed: () {
                  Navigator.of(context).pushReplacementNamed('/Register');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:dockmate/model/user.dart';
import 'package:dockmate/pages/settings.dart' as settings;
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

/*
TO-DOs
  - add "show password button"
  - styling
  - insert user document to firebase
  - write a function to retrieve all user emails and validate if the email already exists.
    - do it in _register() and return coresponding message to indicate the problem (email already exist, phone number exists)
  - 
*/

class Register extends StatefulWidget {
  Register({Key key, this.title}) : super(key: key);
  String title;
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();
  User user;
  String fname;
  String lname;
  String email;
  String phone;
  String password;
  String repassword;

  // write a function to retrieve all user emails and validate if the email already exists.

  _register() {
    User newuser = new User(
        // first_name: fname,
        // last_name: lname,
        // email: email,
        // phone: phone,
        // password: password
        );

    print(newuser);
    user = newuser;

    // _insertDocument().then(() {

    // });
      return {
        'msg': 'User ${user.first_name} is registered',
        'registered': false
      };

    // return {'msg' : 'user ${user.email} registration failed. ', 'registered':false};

    // return {'msg' : 'user ${fname} failed. ', 'registered':false};

    // insert the new user document to firebase
  }

  // _insertDocument() async {
  //   Firebase.initializeApp();
  //   FirebaseFirestore db = FirebaseFirestore.instance;
  //   CollectionReference userCollection =
  //       db.collection('User');
  //   DocumentReference newDocument = await userCollection.add(user.toMap());
  //   user.reference = newDocument;
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                child: Image.asset("assets/placeholder_icon.png", scale: 20),
                margin: EdgeInsets.only(right: 10),
              ),
              Text(widget.title),
            ],
          ),
        ),
        body: Container(
          margin: EdgeInsets.all(10),
          child: Form(
            key: _formKey,
            child: ListView(
              children: <Widget>[
                TextFormField(
                  decoration: const InputDecoration(
                    hintText: 'Enter your first name',
                    labelText: 'First Name',
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'This field is required';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    fname = value;
                  },
                  onSaved: (value) {
                    fname = value;
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    hintText: 'Enter your last name',
                    labelText: 'Last Name',
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'This field is required';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    lname = value;
                  },
                  onSaved: (value) {
                    lname = value;
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    hintText: 'xxxxxx@email.com',
                    labelText: 'Email address',
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'This field is required';
                    }
                    // validate user email from database
                    return null;
                  },
                  onSaved: (value) {
                    email = value;
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    hintText: '(xxx) xxx-xxxx',
                    labelText: 'Phone number',
                  ),
                  validator: (value) {
                    if (value.length != 10) {
                      return 'phone number format wrong';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    if (value.length != 10) {
                      return 'phone number format wrong';
                    } else {
                      return null;
                    }
                  },
                  onSaved: (value) {
                    phone = value;
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    hintText:
                        'User at lease 4 characters with special symbols .?!_*',
                    labelText: 'password',
                  ),
                  obscureText: true,
                  validator: (value) {
                    if (value.length < 4) {
                      return 'password needs to be at least 4 char long';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    if (value.length < 4) {
                      return 'password needs to be at least 4 char long';
                    } else {
                      password = value;
                    }
                  },
                  onSaved: (value) {
                    password = value;
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Re-enter password',
                  ),
                  obscureText: true,
                  validator: (value) {
                    if (value != password) {
                      return 'this doesn\'t match your password';
                    } else {
                      password = value;
                    }
                  },
                  onChanged: (value) {
                    if (value != password) {
                      return 'this doesn\'t match your password';
                    }
                  },
                  onSaved: (value) {
                    password = value;
                  },
                ),
                Padding(
                  padding: EdgeInsets.all(20),
                  child: Builder(
                    builder: (context) => RaisedButton(
                      onPressed: () {
                        // Validate returns true if the form is valid, otherwise false.
                        if (_formKey.currentState.validate()) {
                          _formKey.currentState.save();
                          var registration_status = _register();
                          Scaffold.of(context).showSnackBar(SnackBar(
                              content: Text(registration_status['msg'])));

                          // head: check if the user is registered in firebase
                          if (registration_status['registered']) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      settings.Settings(title: "Settings", user: user)),
                            );
                          } else {
                            Scaffold.of(context).showSnackBar(SnackBar(
                                content: Text(registration_status['msg'])));
                          }
                          // end: check if the user is registered in firebase

                        } else {
                          // form invalid
                          Scaffold.of(context).showSnackBar(
                              SnackBar(content: Text('Input fields invalid')));
                        }
                      },
                      child: Text('Submit'),
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}

import 'package:dockmate/model/user.dart';
import 'package:dockmate/pages/authentication/newUser_housingType.dart';
import 'package:dockmate/pages/app_screens/settings.dart';
import 'package:dockmate/utils/auth.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  Register({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();
  User user;
  String fname = '';
  String lname = '';
  String email = '';
  String phone;
  String password = '';
  String repassword = '';

  // TO-DOs
  // - write a function to retrieve all user emails and validate if the email already exists.
  // - insert the new user document to firebase

  @override
  Widget build(BuildContext context) {
    AuthService _auth = AuthService();
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
        actions: <Widget>[
          FlatButton.icon(
              onPressed: () =>
                  Navigator.of(context).pushReplacementNamed('/Login'),
              icon: Icon(Icons.person),
              label: Text('Log in'))
        ],
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
                  return null;
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
                  return null;
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
                onChanged: (value) {
                  email = value;
                  return null;
                },
                onSaved: (value) {
                  email = value;
                },
              ),
              // TextFormField(
              //   decoration: const InputDecoration(
              //     hintText: '(xxx) xxx-xxxx',
              //     labelText: 'Phone number',
              //   ),
              //   validator: (value) {
              //     if (value.length != 10) {
              //       return 'phone number format wrong';
              //     }
              //     return null;
              //   },
              //   onChanged: (value) {
              //     if (value.length != 10) {
              //       return 'phone number format wrong';
              //     } else {
              //       return null;
              //     }
              //   },
              //   onSaved: (value) {
              //     phone = value;
              //   },
              // ),
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
                    return null;
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
                  } else {
                    return null;
                  }
                },
                onSaved: (value) {
                  password = value;
                },
              ),
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: RaisedButton(
                      child: Text('Cancel'),
                      onPressed: () {
                        Navigator.of(context)
                            .pushReplacementNamed('/FirstScreen');
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: Builder(
                      builder: (context) => RaisedButton(
                        onPressed: () async {
                          // Validate returns true if the form is valid, otherwise false.
                          // case 1: register success, proceed to Hoursing type preference
                          // case 2: register fail (email already exist), request re-register with different email
                          // case 3: input field invalie, re-enter fields
                          if (_formKey.currentState.validate()) {
                            _formKey.currentState.save();
                            dynamic result = await _auth
                                .registerWithEmailAndPassword(email, password);

                            if (result == null) {
                              Scaffold.of(context).showSnackBar(SnackBar(
                                  content: Text('Please provide a valid email')));
                              
                            } else {
                              Scaffold.of(context).showSnackBar(SnackBar(
                                  content: Text('Registration success')));
                            }

                            // var registration_status = _register();

                            // if (registration_status['registered']) {
                            //   // update user status and log the user in
                            // } else {
                            //   // email already in use snackbar and input field hint
                            // }

                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //       builder: (context) =>
                            //           Settings(title: "Settings")),
                            // );

                            // Scaffold.of(context).showSnackBar(SnackBar(
                            //     content: Text(registration_status['msg'])));
                            // if (registration_status['registered']) {
                            //   Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (context) => Settings(
                            //             title: "Settings")),
                            //   );
                            // } else {
                            //   Scaffold.of(context).showSnackBar(SnackBar(
                            //       content: Text(registration_status['msg'])));
                            // }
                            // end: check if the user is registered in firebase

                          } else {
                            Scaffold.of(context).showSnackBar(SnackBar(
                                content: Text('Input fields invalid')));
                          }
                        },
                        child: Text('Submit'),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  _register() {
    // dynamic result = await _auth.regist
    // register new user in firebase

    // User newuser = new User(
    // email: email,
    // phone: phone,
    // password: password
    // );

    // return {
    //   'msg': 'User ${user.first_name} registered',
    //   'registered': false
    // };
    // return {'msg' : 'user ${user.email} registration failed. ', 'registered':false};
    // return {'msg' : 'user ${fname} failed. ', 'registered':false};
  }
}
// import 'package:dockmate/model/user.dart';

import 'package:dockmate/model/usersqfModel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:dockmate/pages/authentication/newUser_housingType.dart';
import 'package:dockmate/pages/Settings/settings.dart';
import 'package:dockmate/model/user.dart' as modeluser;
import 'package:dockmate/utils/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditProfile extends StatefulWidget {
  modeluser.User user;

  EditProfile({Key key, this.user}) : super(key: key);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final _formKey = GlobalKey<FormState>();
  final _model = UserModel();
  // modeluser.User sqluser;
  // User user;

  // Future<modeluser.User> getUser() async {
  //   // var user;
  //   // await _model.getUserWithId(id).then((u) {user = u;});
  //   return await _model.getUserWithId(widget.user.id);
  // }

  // @override
  // void initState() {
  //   sqluser = getUser(widget.user.id);
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    final userCloud = Provider.of<User>(context);
    final user = Provider.of<modeluser.User>(context);
    // modeluser.User sqluser = getUser(userCloud.uid);
    // var sqluser = _model.getUserWithId(widget.user.id).then((u) => u);
    // if (user.first_name == null ) {
    //   setState(() {
    //     userCloud.updateProfile(displayName: 'nofirstname nolastname');
    //   });
    // }
    String fname = userCloud.displayName.split(' ')[0];
    String lname = userCloud.displayName.split(' ')[1];
    // String fname = widget.user.first_name;
    // String lname = widget.user.last_name;
    // String fname = 'fname';
    // String lname = 'lname';
    String email = user.email;
    // String phone = widget.user.phone;
    String phone = 'phone is not avaiable yet';
    // UsernameModel usernameModel = UsernameModel();
    AuthService _auth = AuthService();

    print('$fname $lname $email');

    return Scaffold(
              appBar: AppBar(
                // leading: Image.asset("assets/dock.png", scale: 20, color: Colors.white),
                title: Text("Edit Profile"),
              ),
              body: Container(
                // margin: EdgeInsets.all(10),
                margin: EdgeInsets.symmetric(vertical: 18),
                child: Form(
                  key: _formKey,
                  child: ListView(
                    children: <Widget>[
                      ListTile(
                          title: Text("Personal Information",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 23))),
                      ListTile(
                          title:
                              Text('  $fname', style: TextStyle(fontSize: 20)),
                          subtitle: TextFormField(
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              // hintText: fname,
                              labelText: 'Enter new first name',
                            ),
                            validator: (value) {
                              return null;
                            },
                            onChanged: (value) {
                              fname = value;
                              return null;
                            },
                            onSaved: (value) {
                              fname = value;
                            },
                          )),
                      ListTile(
                          title:
                              Text('  $lname', style: TextStyle(fontSize: 20)),
                          subtitle: TextFormField(
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Enter your last name',
                              labelText: 'Last Name',
                            ),
                            validator: (value) {
                              return null;
                            },
                            onChanged: (value) {
                              lname = value;
                              return null;
                            },
                            onSaved: (value) {
                              lname = value;
                            },
                          )),
                      ListTile(
                          title: Text('Current email: ${email}',
                              style: TextStyle(fontSize: 20)),
                          subtitle: TextFormField(
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              // hintText: 'Enter new email address',
                              labelText: 'Enter new email address',
                            ),
                            validator: (value) {
                              return null;
                            },
                            onChanged: (value) {
                              email = value;
                              return null;
                            },
                            onSaved: (value) {
                              email = value;
                            },
                          )),
                      // ListTile(
                      //   title: Text(user.phone),
                      //   subtitle: TextFormField(
                      //     decoration: const InputDecoration(
                      //       border: OutlineInputBorder(),
                      //       hintText: '(xxx) xxx-xxxx',
                      //       labelText: 'Phone number',
                      //     ),
                      //     validator: (value) {
                      //       if (value.length > 0 && value.length < 10) {
                      //         return 'phone number format wrong';
                      //       }
                      //       return null;
                      //     },
                      //     onChanged: (value) {
                      //       if (value.length != 10) {
                      //         return 'phone number format wrong';
                      //       } else {
                      //         return null;
                      //       }
                      //     },
                      //     onSaved: (value) {
                      //       phone = value;
                      //     },
                      //   ),
                      // ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.only(right: 8.0),
                            child: RaisedButton(
                              child: Text('Cancel'),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                          ),
                          Container(
                            child: Builder(
                              builder: (context) => RaisedButton(
                                color: Colors.blue,
                                onPressed: () async {
                                  // case 1: register success, proceed to Hoursing type preference
                                  if (_formKey.currentState.validate()) {
                                    print("First name: $fname is registered");
                                    // usernameModel.setUsername(
                                    //     fname); //save username to sqflite to be used by other parts
                                    _formKey.currentState.save();
                                    print('lname');
                                    if (lname.isNotEmpty) {
                                      print('here at lastname $lname');
                                      user.last_name = lname;
                                      userCloud.updateProfile(
                                          displayName:
                                              '${user.first_name} $lname');
                                    }
                                    if (fname.isNotEmpty) {
                                      print('here at firstname $fname');
                                      user.first_name = fname;
                                      userCloud.updateProfile(
                                          displayName:
                                              '$fname ${user.last_name}');
                                    }
                                    if (phone.isNotEmpty) {
                                      user.phone = phone;
                                      _model.updateUser(user);
                                    }
                                    Navigator.pop(context);
                                  } else {
                                    Scaffold.of(context).showSnackBar(SnackBar(
                                        content: Text('Input fields invalid')));
                                  }
                                },
                                child: Text('Save',
                                    style: TextStyle(color: Colors.white)),
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


    // return FutureBuilder(
    //     future: _model.getUserWithId(userCloud.uid),
    //     builder: (context, snapshot) {
    //       if (snapshot.hasData) {
    //         print('snapshot has data');
    //         print(snapshot.data);
    //         modeluser.User sqluser = modeluser.User.fromMap(snapshot.data[0]);
    //         return Scaffold(
    //           appBar: AppBar(
    //             // leading: Image.asset("assets/dock.png", scale: 20, color: Colors.white),
    //             title: Text("Edit Profile"),
    //           ),
    //           body: Container(
    //             // margin: EdgeInsets.all(10),
    //             margin: EdgeInsets.symmetric(vertical: 18),
    //             child: Form(
    //               key: _formKey,
    //               child: ListView(
    //                 children: <Widget>[
    //                   ListTile(
    //                       title: Text("Personal Information",
    //                           style: TextStyle(
    //                               fontWeight: FontWeight.bold, fontSize: 23))),
    //                   ListTile(
    //                       title:
    //                           Text('  $fname', style: TextStyle(fontSize: 20)),
    //                       subtitle: TextFormField(
    //                         decoration: const InputDecoration(
    //                           border: OutlineInputBorder(),
    //                           // hintText: fname,
    //                           labelText: 'Enter new first name',
    //                         ),
    //                         validator: (value) {
    //                           return null;
    //                         },
    //                         onChanged: (value) {
    //                           fname = value;
    //                           return null;
    //                         },
    //                         onSaved: (value) {
    //                           fname = value;
    //                         },
    //                       )),
    //                   ListTile(
    //                       title:
    //                           Text('  $lname', style: TextStyle(fontSize: 20)),
    //                       subtitle: TextFormField(
    //                         decoration: const InputDecoration(
    //                           border: OutlineInputBorder(),
    //                           hintText: 'Enter your last name',
    //                           labelText: 'Last Name',
    //                         ),
    //                         validator: (value) {
    //                           return null;
    //                         },
    //                         onChanged: (value) {
    //                           lname = value;
    //                           return null;
    //                         },
    //                         onSaved: (value) {
    //                           lname = value;
    //                         },
    //                       )),
    //                   ListTile(
    //                       title: Text('Current email: ${email}',
    //                           style: TextStyle(fontSize: 20)),
    //                       subtitle: TextFormField(
    //                         decoration: const InputDecoration(
    //                           border: OutlineInputBorder(),
    //                           // hintText: 'Enter new email address',
    //                           labelText: 'Enter new email address',
    //                         ),
    //                         validator: (value) {
    //                           return null;
    //                         },
    //                         onChanged: (value) {
    //                           email = value;
    //                           return null;
    //                         },
    //                         onSaved: (value) {
    //                           email = value;
    //                         },
    //                       )),
    //                   ListTile(
    //                     title: Text(sqluser.phone),
    //                     subtitle: TextFormField(
    //                       decoration: const InputDecoration(
    //                         border: OutlineInputBorder(),
    //                         hintText: '(xxx) xxx-xxxx',
    //                         labelText: 'Phone number',
    //                       ),
    //                       validator: (value) {
    //                         if (value.length > 0 && value.length < 10) {
    //                           return 'phone number format wrong';
    //                         }
    //                         return null;
    //                       },
    //                       onChanged: (value) {
    //                         if (value.length != 10) {
    //                           return 'phone number format wrong';
    //                         } else {
    //                           return null;
    //                         }
    //                       },
    //                       onSaved: (value) {
    //                         phone = value;
    //                       },
    //                     ),
    //                   ),
    //                   Row(
    //                     mainAxisAlignment: MainAxisAlignment.center,
    //                     crossAxisAlignment: CrossAxisAlignment.start,
    //                     children: [
    //                       Container(
    //                         padding: EdgeInsets.only(right: 8.0),
    //                         child: RaisedButton(
    //                           child: Text('Cancel'),
    //                           onPressed: () {
    //                             Navigator.pop(context);
    //                           },
    //                         ),
    //                       ),
    //                       Container(
    //                         child: Builder(
    //                           builder: (context) => RaisedButton(
    //                             color: Colors.blue,
    //                             onPressed: () async {
    //                               // case 1: register success, proceed to Hoursing type preference
    //                               if (_formKey.currentState.validate()) {
    //                                 print("First name: $fname is registered");
    //                                 // usernameModel.setUsername(
    //                                 //     fname); //save username to sqflite to be used by other parts
    //                                 _formKey.currentState.save();
    //                                 print('lname');
    //                                 if (lname.isNotEmpty) {
    //                                   print('here at lastname $lname');
    //                                   user.last_name = lname;
    //                                   userCloud.updateProfile(
    //                                       displayName:
    //                                           '${user.first_name} $lname');
    //                                 }
    //                                 if (fname.isNotEmpty) {
    //                                   print('here at firstname $fname');
    //                                   user.first_name = fname;
    //                                   userCloud.updateProfile(
    //                                       displayName:
    //                                           '$fname ${user.last_name}');
    //                                 }
    //                                 if (phone.isNotEmpty) {
    //                                   user.phone = phone;
    //                                   _model.updateUser(user);
    //                                 }
    //                                 Navigator.pop(context);
    //                               } else {
    //                                 Scaffold.of(context).showSnackBar(SnackBar(
    //                                     content: Text('Input fields invalid')));
    //                               }
    //                             },
    //                             child: Text('Save',
    //                                 style: TextStyle(color: Colors.white)),
    //                           ),
    //                         ),
    //                       ),
    //                     ],
    //                   )
    //                 ],
    //               ),
    //             ),
    //           ),
    //         );
    //       } else {
    //         return Scaffold(body: Center(child: Text('no data visible')));
    //       }
    //     });
  }
}

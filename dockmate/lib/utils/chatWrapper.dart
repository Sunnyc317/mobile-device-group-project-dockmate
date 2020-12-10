import 'package:flutter/material.dart';
import 'package:dockmate/model/username.dart';
import 'package:dockmate/pages/app_screens/userChat.dart';
import 'package:dockmate/pages/app_screens/message.dart';

class ChatWrapper extends StatefulWidget {
  final Function toggleView;
  ChatWrapper({Key key, this.toggleView}) : super(key: key);

  @override
  _ChatWrapperState createState() => _ChatWrapperState();
}

class _ChatWrapperState extends State<ChatWrapper> {
  final UsernameModel _usernameModel = UsernameModel();
  String _user = "USER NOT FOUND";

  // @override
  // void initState() {
  //   print("Chat wrapper's init state");
  //   super.initState();
  //   _getUsername();
  // }

  Future<String> _getUsername() async {
    print("now we get userrname in chat wrapper");
    Username name = await _usernameModel.getUsername();
    print("chat wrrapper's anything: ${name.username}");
    _user = name.username;
    print("entire get username in chat wrapper is done");
    return name.username;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _getUsername(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              print("no connection boo");
              return Scaffold(body: Text('No connection'));
            case ConnectionState.waiting:
              print("it's at waiting....");
              return Scaffold(body: Center(child: CircularProgressIndicator()));
            case ConnectionState.done:
              if (snapshot.hasError)
                return Scaffold(body: Text('Error: You should not see this!'));
              else {
                if (_user.toLowerCase().contains("guest")) {
                  print("It went to guest chatroom @$_user");
                  return MessageRoom(
                      toggleView: widget.toggleView, currentUser: _user);
                } else {
                  print("It went to USER'S?! chatroom @$_user");
                  return UserChat(
                      title: "$_user's Chat Room",
                      toggleView: widget.toggleView);
                }
              }
          }
        });
  }
}

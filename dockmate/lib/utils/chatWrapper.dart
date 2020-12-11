import 'package:flutter/material.dart';
import 'package:dockmate/model/username.dart';
import 'package:dockmate/pages/chat/userChat.dart';
import 'package:dockmate/pages/chat/message.dart';

// This class handles different types of Chat to be shown
class ChatWrapper extends StatefulWidget {
  final Function toggleView;
  ChatWrapper({Key key, this.toggleView}) : super(key: key);

  @override
  _ChatWrapperState createState() => _ChatWrapperState();
}

class _ChatWrapperState extends State<ChatWrapper> {
  final UsernameModel _usernameModel = UsernameModel();
  String _user = "USER NOT FOUND";

  Future<String> _getUsername() async {
    // Get username to determine chat type
    Username name = await _usernameModel.getUsername();
    _user = name.username;
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
                  // Block guest from being able to access all chatrooms
                  return MessageRoom(
                    toggleView: widget.toggleView,
                    currentUser: _user,
                    postTitle: "Your helpful seahorse mate",
                  );
                } else {
                  // Show normal chatrooms
                  return UserChat(
                      title: "$_user's Chat Room",
                      toggleView: widget.toggleView);
                }
              }
          }
        });
  }
}

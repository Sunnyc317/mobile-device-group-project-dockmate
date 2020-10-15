import 'package:flutter/material.dart';

class BottomBar extends StatelessWidget {
  final Function setBottomIndex;
  final int bottomIndex;

  BottomBar({@required this.bottomIndex, @required this.setBottomIndex});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      elevation: 0,
      type: BottomNavigationBarType.fixed,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          //might need refactoring
          icon: Icon(
            Icons.home,
          ),
          title: Text("Listing"),
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.place,
          ),
          title: Text("Map"),
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.account_circle,
          ),
          title: Text("My List"),
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.chat,
          ),
          title: Text("Chat"),
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.settings,
          ),
          title: Text("Setting"),
        ),
      ],
      currentIndex: bottomIndex,
      selectedItemColor: Colors.blue[400],
      onTap: setBottomIndex,
    );
  }
}

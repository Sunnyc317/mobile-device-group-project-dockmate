import 'package:flutter/material.dart';

class MenuBar {
  String name;
  IconData icon;

  MenuBar({this.name, this.icon});
}

class BottomBar extends StatelessWidget {
  final Function setBottomIndex;
  final int bottomIndex;
  List<MenuBar> _menu = [
    MenuBar(name: 'Listing', icon: Icons.home),
    MenuBar(name: 'Map', icon: Icons.place),
    MenuBar(name: 'Chat', icon: Icons.chat),
    MenuBar(name: 'My Listing', icon: Icons.account_circle),
    MenuBar(name: 'Settings', icon: Icons.settings),
  ];

  BottomBar({@required this.bottomIndex, this.setBottomIndex});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      elevation: 0,
      items: _menu.map((MenuBar menu) {
        return BottomNavigationBarItem(
          icon: Icon(menu.icon),
          label: menu.name,
        );
      }).toList(),
      currentIndex: bottomIndex,
      selectedItemColor: Colors.blue[400],
      onTap: (int index) {
        var _pageIndex = index;
        var page;
        switch (_pageIndex) {
          case 0:
            page = '/Listings';
            break;
          case 1:
            page = '/Map';
            break;
          case 2:
            page = '/Chat';
            break;
          case 3:
            page = '/MyListings';
            break;
          case 4:
            page = '/Settings';
            break;
        }

        Navigator.of(context).pushReplacementNamed(page);
      },
    );
  }
}

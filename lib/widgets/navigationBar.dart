import 'package:flutter/material.dart';

class NavigationBar extends StatelessWidget {
  void onNavigation(int index, BuildContext context) {
    print(index);
    String route = '';
    switch (index) {
      case 0:
        route = '/transaction';
        break;
      case 1:
        route = '/transaction';
        break;
      case 2:
        route = '/accounts';
        break;
      case 3:
        route = '/accounts/add';
        break;
    }

    Navigator.pushReplacementNamed(context, route);
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        currentIndex: 0,
        onTap: (index) => onNavigation(index, context),
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.blueGrey[900],
        unselectedIconTheme: IconThemeData(color: Colors.grey[400]),
        unselectedItemColor: Colors.grey[400],
        selectedIconTheme: IconThemeData(color: Colors.grey[200]),
        selectedItemColor: Colors.grey[200],
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.library_books), label: 'Trans'),
          BottomNavigationBarItem(
              icon: Icon(Icons.add_chart_rounded), label: 'Stats'),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_balance_sharp), label: 'Accounts'),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings), label: 'Settings'),
        ]);
  }
}

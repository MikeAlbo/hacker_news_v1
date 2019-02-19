import 'package:flutter/material.dart';

class BottomNavBar extends StatefulWidget {
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: <BottomNavigationBarItem>[
        _buildBottomNavBarItem(Icons.home, "Home"),
        _buildBottomNavBarItem(Icons.star, "Favorites"),
      ],
      onTap: _onNavItemTap,
      currentIndex: _currentIndex,
    );
  }

  void _onNavItemTap(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}

BottomNavigationBarItem _buildBottomNavBarItem(IconData icon, String title) {
  return BottomNavigationBarItem(
    icon: Icon(icon),
    title: Text(title),
  );
}

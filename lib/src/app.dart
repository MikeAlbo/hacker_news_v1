import 'package:flutter/material.dart';

import 'widgets/bottom_nav_bar.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hacker News"),
        leading: IconButton(icon: Icon(Icons.menu), onPressed: () {}),
      ),
      body: Center(
        child: Text("Hacker News"),
      ),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}

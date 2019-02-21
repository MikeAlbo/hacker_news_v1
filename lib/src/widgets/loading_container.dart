import 'package:flutter/material.dart';

class LoadingContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          title: buildTitleContainer(),
          subtitle: buildSubtextContainer(),
          trailing: buildTrailing(),
        )
      ],
    );
  }
}

Widget buildTitleContainer() {
  return Container(
    color: Colors.grey[400],
    height: 24.0,
    width: 150.0,
    margin: EdgeInsets.only(top: 5.0, bottom: 5.0),
  );
}

Widget buildSubtextContainer() {
  return Container(
    color: Colors.grey[200],
    height: 15.0,
    width: 100.0,
    margin: EdgeInsets.only(top: 5.0, bottom: 5.0),
  );
}

Widget buildTrailing() {
  return Container(
    color: Colors.grey[300],
    height: 25.0,
    width: 25.0,
  );
}

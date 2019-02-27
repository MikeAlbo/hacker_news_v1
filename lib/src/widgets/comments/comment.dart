import 'package:flutter/material.dart';

import '../../models/item_model.dart';

class Comment extends StatelessWidget {
  final ItemModel itemModel;
  Comment({@required this.itemModel});
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        itemModel.title,
        style: TextStyle(fontWeight: FontWeight.w300, fontSize: 15.0),
      ),
      trailing: Icon(Icons.favorite), //todo: convert to button to add to fav
    );
  }
}

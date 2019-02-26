import 'package:flutter/material.dart';
import 'package:hacker_news_v1/src/models/item_model.dart';

class CommentHeader extends StatelessWidget {
  final ItemModel itemModel;

  CommentHeader({@required this.itemModel});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 15.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          _headerTitle(itemModel.title),
          _subhead(itemModel),
          _commentHeader(itemModel.descendants),
        ],
      ),
    );
  }
}

Widget _headerTitle(String title) {
  return Text(
    title,
    textAlign: TextAlign.center,
    style: TextStyle(
      fontSize: 30.0,
      fontWeight: FontWeight.w300,
    ),
  );
}

Widget _subhead(ItemModel item) {
  return Center(
    child: Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "( ${_webLinkHelper(item.url)} )",
                style: TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.w300,
                    color: Colors.blueGrey),
              ),
              Icon(
                Icons.launch,
                color: Colors.lightBlueAccent,
                size: 15.0,
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 20.0),
          child: Center(
            child: Text(
              "by: ${item.by}  |  ${item.score} points",
              style: TextStyle(
                fontWeight: FontWeight.w300,
                fontSize: 12.0,
              ),
            ),
          ),
        ),
        Divider(),
      ],
    ),
  );
}

Widget _commentHeader(int itemChildren) {
  return Padding(
    padding: const EdgeInsets.only(top: 20.0),
    child: Center(
      child: Text(
        "$itemChildren Comments",
        style: TextStyle(
          fontWeight: FontWeight.w300,
          fontSize: 30.0,
        ),
      ),
    ),
  );
}

//helpers todo: poss extract to own file, used multiple times
String _webLinkHelper(String fullLink) {
  var uri = Uri.parse(fullLink);
  String host = uri.host.replaceAll("w", "");
  if (host.indexOf(".") == 0) {
    return host.replaceFirst(".", "");
  }
  return host;
}

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hacker_news_v1/src/models/item_model.dart';
import 'package:hacker_news_v1/src/widgets/loading_container.dart';

import '../blocs/stories_provider.dart';

class StoryListTile extends StatelessWidget {
  final int itemId;

  StoryListTile({this.itemId});

  @override
  Widget build(BuildContext context) {
    final bloc = StoriesProvider.of(context);

    return StreamBuilder(
      stream: bloc.items,
      builder: (context, AsyncSnapshot<Map<int, Future<ItemModel>>> snapshot) {
        if (!snapshot.hasData) {
          return LoadingContainer();
        }
        return FutureBuilder(
          future: snapshot.data[itemId],
          builder: (context, AsyncSnapshot<ItemModel> itemSnapshot) {
            if (!itemSnapshot.hasData) {
              return LoadingContainer();
            }
            return buildTile(context, itemSnapshot.data);
          },
        );
      },
    );
  }
}

Widget buildTile(BuildContext context, ItemModel item) {
  return Column(
    children: <Widget>[
      ListTile(
        onTap: () {
          Navigator.pushNamed(context, "/webview/${item.url}");
          //Navigator.pushNamed(context, "/comments/${item.id}");
        },
        contentPadding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 0.0),
        title: Text(item.title ?? "no title"),
        subtitle: _subStringBuilder(item),
        trailing: Icon(
          Icons.keyboard_arrow_right,
          color: Colors.black26,
        ),
      ),
      Divider(),
    ],
  );
}

Widget _subStringBuilder(ItemModel item) {
  return Padding(
    padding: const EdgeInsets.only(left: 8.0, top: 8.0),
    child: Text(
      "by: ${item.by} | ${item.score} points | ${item.descendants} comments | ${_webLinkHelper(item.url)}",
      style: TextStyle(
        fontWeight: FontWeight.w300,
        fontSize: 13.0,
      ),
      overflow: TextOverflow.ellipsis,
    ),
  );
}

String _webLinkHelper(String fullLink) {
  var uri = Uri.parse(fullLink);
  String host = uri.host.replaceAll("w", "");
  if (host.indexOf(".") == 0) {
    return host.replaceFirst(".", "");
  }
  return host;
}

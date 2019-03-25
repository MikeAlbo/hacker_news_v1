import 'package:flutter/material.dart';
import 'package:hacker_news_v1/src/models/item_model.dart';
import 'package:hacker_news_v1/src/widgets/loading_container.dart';
import 'package:html/parser.dart';

class CommentList extends StatelessWidget {
  final int itemId;
  final Map<int, Future<ItemModel>> itemMap;
  final int depth;

  CommentList({this.itemId, this.itemMap, this.depth});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: itemMap[itemId],
      builder: (context, AsyncSnapshot<ItemModel> snapshot) {
        if (!snapshot.hasData) {
          return LoadingContainer();
        }

        final item = snapshot.data;

        final children = <Widget>[
          ListTile(
            contentPadding: EdgeInsets.only(
              right: 16.0,
              left: depth * 16.0,
            ),
            leading: item.by == '' ? commentDeleted() : null,
            title: buildText(item),
            subtitle: buildSubtext(item),
          ),
//          Divider(
//            color: Colors.grey[300],
//            height: 0.0,
//          ),
        ];

        snapshot.data.kids.forEach((kidId) {
          children.add(
            CommentList(
              itemId: kidId,
              itemMap: itemMap,
              depth: depth + 1,
            ),
          );
        });

        return Column(
          children: children,
        );
      },
    );
  }

  Widget buildText(ItemModel item) {
    final text = item.text.replaceAll("<p>", "\n\n");

    var parsed = parse(text);
    String parsedString = parse(parsed.body.text).documentElement.text;
    return Container(
      child: Text(
        parsedString,
        style: TextStyle(
          height: 1.2,
          wordSpacing: 1.2,
        ),
      ),
      padding: item.by == '' ? null : EdgeInsets.only(left: 10.0),
      decoration: item.by == ''
          ? null
          : BoxDecoration(
              border: Border(
              left: BorderSide(width: 6.0, color: Colors.grey[depth * 100]),
            )),
    );
  }

  Widget buildSubtext(ItemModel item) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          item.by,
          style: TextStyle(
            fontStyle: FontStyle.italic,
            color: Colors.grey[700], //todo: define in theme
          ),
        ),
      ),
      padding: item.by == '' ? null : EdgeInsets.only(left: 10.0),
      decoration: item.by == ''
          ? null
          : BoxDecoration(
              border: Border(
              left: BorderSide(width: 6.0, color: Colors.grey[depth * 100]),
            )),
    );
  }

  Widget commentDeleted() {
    return Container(
      padding: EdgeInsets.only(left: 10.0),
      decoration: BoxDecoration(
          border: Border(
              left: BorderSide(width: 6.0, color: Colors.grey[depth * 100]))),
      child: Text(
        "Comment Deleted",
        style: TextStyle(
          fontWeight: FontWeight.w100,
          fontSize: 18.0,
          color: Colors.black54,
          fontStyle: FontStyle.italic,
        ),
      ),
    );
  }
}

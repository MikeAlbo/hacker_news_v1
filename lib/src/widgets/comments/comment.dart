import 'package:flutter/material.dart';
import 'package:hacker_news_v1/src/blocs/comments_provider.dart';
import 'package:hacker_news_v1/src/models/item_model.dart';

import 'comment_list.dart';

class Comment extends StatelessWidget {
  final int itemId;

  Comment({@required this.itemId});

  @override
  Widget build(BuildContext context) {
    final bloc = CommentsProvider.of(context);
    return StreamBuilder(
      stream: bloc.itemWithComments,
      builder: (context, AsyncSnapshot<Map<int, Future<ItemModel>>> snapshot) {
        if (!snapshot.hasData) {
          return Text('stream loading');
        }
        final itemFuture = snapshot.data[itemId];

        return FutureBuilder(
          future: itemFuture,
          builder: (context, AsyncSnapshot<ItemModel> itemSnapshot) {
            if (!itemSnapshot.hasData) {
              return Text("Loading...");
            }

            return buildList(itemSnapshot.data, snapshot.data);
          },
        );
      },
    );
  }

  Widget buildList(ItemModel item, Map<int, Future<ItemModel>> itemMap) {
    final children = <Widget>[];

    final commentsList = item.kids.map((kidId) {
      return CommentList(
        itemId: kidId,
        itemMap: itemMap,
        depth: 1,
      );
    }).toList();

    children.addAll(commentsList);

    return ListView(
      children: children,
    );
  }
}

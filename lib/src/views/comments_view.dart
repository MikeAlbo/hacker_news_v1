//todo: this is temporarily being used to test navigation, will later contain comments
import 'package:flutter/material.dart';
import 'package:hacker_news_v1/src/blocs/comments_provider.dart';
import 'package:hacker_news_v1/src/models/item_model.dart';
import 'package:hacker_news_v1/src/widgets/comments/comment_list.dart';
import 'package:hacker_news_v1/src/widgets/loading_container.dart';

import '../widgets/comments/comment_header.dart';
//import '../blocs/stories_provider.dart';

//import '../widgets/comments/comment.dart';

class CommentsView extends StatelessWidget {
  final id;

  CommentsView({@required this.id});

  @override
  Widget build(BuildContext context) {
    //StoriesBloc bloc = StoriesProvider.of(context);
    final bloc = CommentsProvider.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Comments View"),
      ),
      body: StreamBuilder(
          stream: bloc.itemWithComments,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return LoadingContainer();
            }
            return FutureBuilder(
              future: snapshot.data[id],
              builder: (context, AsyncSnapshot<ItemModel> itemSnapshot) {
                if (!itemSnapshot.hasData) {
                  return LoadingContainer();
                }
                return _commentScaffold(
                    context, itemSnapshot.data, id, snapshot.data);
              },
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: Icon(Icons.list),
      ),
    );
  }
}

Widget _commentScaffold(BuildContext context, ItemModel item, int id,
    Map<int, Future<ItemModel>> itemMap) {
//  return ListView(
//    children: <Widget>[
//      CommentHeader(
//        itemModel: item,
//      ),
//      //CommentsBody(itemModel: item),
//      Comment(
//        itemId: id,
//      ),
//    ],
//  );

  final children = <Widget>[];

  children.add(CommentHeader(itemModel: item));

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

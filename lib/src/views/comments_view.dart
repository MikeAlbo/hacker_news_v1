//todo: this is temporarily being used to test navigation, will later contain comments
import 'package:flutter/material.dart';
import 'package:hacker_news_v1/src/models/item_model.dart';
import 'package:hacker_news_v1/src/widgets/loading_container.dart';

import '../blocs/stories_provider.dart';
import '../widgets/comments/comment.dart';
import '../widgets/comments/comment_header.dart';

class CommentsView extends StatelessWidget {
  final id;

  CommentsView({@required this.id});

  @override
  Widget build(BuildContext context) {
    StoriesBloc storiesBloc = StoriesProvider.of(context);
    return Scaffold(
        appBar: AppBar(
          title: Text("Comments View"),
        ),
        body: StreamBuilder(
            stream: storiesBloc.items,
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
                  return _commentScaffold(context, itemSnapshot.data);
                },
              );
            }));
  }
}

Widget _commentScaffold(BuildContext context, ItemModel item) {
  return ListView(
    children: <Widget>[
      CommentHeader(
        itemModel: item,
      ),
      //CommentsBody(itemModel: item),
      Comment(
        itemModel: item,
      ),
    ],
  );
}

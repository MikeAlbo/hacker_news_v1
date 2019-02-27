import 'package:flutter/material.dart';

import 'comments_bloc.dart';

export 'comments_bloc.dart ';

class CommentsProvider extends InheritedWidget {
  final CommentBloc commentBloc;

  CommentsProvider({Key key, Widget child})
      : commentBloc = CommentBloc(),
        super(key: key, child: child);

  static CommentBloc of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(CommentsProvider)
            as CommentsProvider)
        .commentBloc;
  }

  @override
  bool updateShouldNotify(CommentsProvider old) {
    return true;
  }
}

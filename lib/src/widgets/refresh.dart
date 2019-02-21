import 'package:flutter/material.dart';

import '../blocs/stories_provider.dart';
import '../providers/hacker_news_api.dart';

class Refresh extends StatelessWidget {
  final Widget child;
  final storyTypes st;
  Refresh({this.child, this.st});

  @override
  Widget build(BuildContext context) {
    final bloc = StoriesProvider.of(context);
    return RefreshIndicator(
      child: child,
      onRefresh: () async {
        await bloc.clearItemsFromCache();
        await bloc.fetchListOfIds(st);
      },
    );
  }
}

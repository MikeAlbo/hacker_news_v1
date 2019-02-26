import 'package:flutter/material.dart';

import '../blocs/stories_provider.dart';
import '../providers/hacker_news_api.dart';

class Refresh extends StatelessWidget {
  final Widget child;
  final storyTypes st;
  Refresh({@required this.child, @required this.st});

  @override
  Widget build(BuildContext context) {
    print("refresh called!!"); //todo: remove!!
    final bloc = StoriesProvider.of(context);
    return RefreshIndicator(
      child: child,
      onRefresh: () async {
        await bloc.clearItemsFromCache();
        print("onRefresh called: fetching List of Ids"); //todo: remove
        await bloc.fetchListOfIds(st);
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:hacker_news_v1/src/blocs/comments_provider.dart';
import 'package:hacker_news_v1/src/views/comments_view.dart';
import 'package:hacker_news_v1/src/views/story_list_view.dart';

import 'blocs/stories_provider.dart';
import 'providers/hacker_news_api.dart';
import 'views/web_view.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CommentsProvider(
      child: StoriesProvider(
        child: MaterialApp(
          theme: ThemeData(
              fontFamily: "Merriweather", primarySwatch: Colors.blueGrey),
          title: "Hacker News!",
          initialRoute: "/listView",
          onGenerateRoute: routes,
          //theme: ThemeData.dark(),
        ),
      ),
    );
  }
}

Route routes(RouteSettings settings) {
  if (settings.name == "/listView") {
    return MaterialPageRoute(builder: (context) {
      final StoriesBloc storiesBloc = StoriesProvider.of(context);
      storiesBloc.fetchListOfIds(storyTypes.topStories);
      return StoryListView();
    });
  } else if (settings.name.contains("/webview/")) {
    return MaterialPageRoute(builder: (context) {
      final String urlId = settings.name.replaceFirst("/webview/", "");
      final List<String> params = urlId.split("**");
      return WebViewScreen(
        fullUrl: params[1],
        itemId: int.parse(params[0]),
      );
    });
  } else if (settings.name.contains("/comments/")) {
    return MaterialPageRoute(builder: (context) {
      final commentsBloc = CommentsProvider.of(context);
      final int id = int.parse(settings.name.replaceFirst("/comments/", ""));
      commentsBloc.fetchItemWithComments(id);
      return CommentsView(id: id);
    });
  } else {
    return MaterialPageRoute(builder: (context) {
      final StoriesBloc storiesBloc = StoriesProvider.of(context);
      storiesBloc.fetchListOfIds(storyTypes.topStories);
      return StoryListView();
    });
  }

//todo: convert to switch statement and use to switch between different story list
}

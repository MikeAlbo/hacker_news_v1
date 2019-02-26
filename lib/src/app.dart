import 'package:flutter/material.dart';
import 'package:hacker_news_v1/src/views/comments_view.dart';
import 'package:hacker_news_v1/src/views/story_list_view.dart';

import 'blocs/stories_provider.dart';
import 'providers/hacker_news_api.dart';
import 'views/web_view.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoriesProvider(
      child: MaterialApp(
        theme: ThemeData(
            fontFamily: "Merriweather", primarySwatch: Colors.blueGrey),
        title: "Hacker News!",
        initialRoute: "/",
        onGenerateRoute: routes,
        //theme: ThemeData.dark(),
      ),
    );
  }
}

Route routes(RouteSettings settings) {
  print("routes called");
  if (settings.name == "/") {
    print("home page called"); //todo: remove!!
    return MaterialPageRoute(builder: (context) {
      final StoriesBloc storiesBloc = StoriesProvider.of(context);
      storiesBloc.fetchListOfIds(storyTypes.topStories);
      print("home called, fetch list"); //todo: remove!
      return StoryListView();
    });
  } else if (settings.name.contains("/webview/")) {
    return MaterialPageRoute(builder: (context) {
      print("webview called");
      final String fullUrl = settings.name.replaceFirst("/webview/", "");
      print(fullUrl); //todo: remove!! this is to test urls that may be broken
      return WebViewScreen(
        fullUrl: fullUrl,
      );
    });
  } else if (settings.name.contains("/comments/")) {
    return MaterialPageRoute(builder: (context) {
      final int id = int.parse(settings.name.replaceFirst("/comments/", ""));
      return CommentsView(id: id);
    });
  } else {
    print("default called"); //todo: remove!!
    return MaterialPageRoute(builder: (context) {
      final StoriesBloc storiesBloc = StoriesProvider.of(context);
      storiesBloc.fetchListOfIds(storyTypes.topStories);
      print("home called, fetch list"); //todo: remove!
      return StoryListView();
    });
  }

//todo: convert to switch statement and use to switch between different story list
}

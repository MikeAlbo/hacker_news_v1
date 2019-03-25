import 'package:flutter/material.dart';
import 'package:hacker_news_v1/src/blocs/stories_provider.dart';
import 'package:hacker_news_v1/src/widgets/bottom_nav_bar.dart';
import 'package:hacker_news_v1/src/widgets/story_list_tile.dart';

import '../providers/hacker_news_api.dart';
import '../widgets/refresh.dart';

class StoryListView extends StatefulWidget {
  @override
  StoryListViewState createState() {
    print("storyListView createState called"); //todo: remove!
    return new StoryListViewState();
  }
}

class StoryListViewState extends State<StoryListView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final bloc = StoriesProvider.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Hacker News"),
        leading: IconButton(icon: Icon(Icons.menu), onPressed: () {}),
      ),
      body: buildList(bloc),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}

Widget buildList(StoriesBloc bloc) {
  print("storyList: buildList"); //todo: remove!
  return StreamBuilder<List<int>>(
    stream: bloc.listOfIds,
    builder: (context, AsyncSnapshot<List<int>> snapshot) {
      //todo: convert to switch statement and handle the error
      if (snapshot.connectionState == ConnectionState.active) {
        print(
            "connection state is not waiting --- ${snapshot.connectionState}"); //todo: remove!
        return Refresh(
          st: storyTypes.topStories,
          child: ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (context, int index) {
              bloc.fetchItem(snapshot.data[index]);
              return StoryListTile(itemId: snapshot.data[index]);
            },
          ),
        );
      } else {
        print("connection state ---  is waiting!!");
        return Center(
          child: CircularProgressIndicator(),
        );
      }
    },
  );
}

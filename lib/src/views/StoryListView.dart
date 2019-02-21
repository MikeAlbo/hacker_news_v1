import 'package:flutter/material.dart';
import 'package:hacker_news_v1/src/blocs/stories_provider.dart';
import 'package:hacker_news_v1/src/widgets/bottom_nav_bar.dart';
import 'package:hacker_news_v1/src/widgets/story_list_tile.dart';

import '../providers/hacker_news_api.dart';
import '../widgets/refresh.dart';

class StoryListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = StoriesProvider.of(context);
    bloc.fetchListOfIds(
        storyTypes.topStories); //todo: remove add to routes later

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
  return StreamBuilder(
    stream: bloc.listOfIds,
    builder: (context, AsyncSnapshot<List<int>> snapshot) {
      if (!snapshot.hasData) {
        return Center(
          child: CircularProgressIndicator(),
        );
      }
      return Refresh(
        child: ListView.builder(
          itemCount: snapshot.data.length,
          itemBuilder: (context, int index) {
            bloc.fetchItem(snapshot.data[index]);
            return StoryListTile(itemId: snapshot.data[index]);
          },
        ),
      );
    },
  );
}

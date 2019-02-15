import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:hacker_news_v1/src/providers/hacker_news_api.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';

void main() {
  test("fetchListOfItems should return a list of ids", () async {
    final newsApi = HackerNewsAPI();

    newsApi.client = MockClient((request) async {
      return Response(jsonEncode([1, 2, 3, 4]), 200);
    });

    final ids = await newsApi.fetchListOfItems(storyTypes.topStories);
    expect(ids, [1, 2, 3, 4]);
  }); //returns a list of ids

  test("fetchListOfItems should return the appropriate list of ids", () async {
    final newsApi = HackerNewsAPI();

    newsApi.client = MockClient((request) async {
      List<int> res;

      switch (request.url.toString()) {
        case "$baseURL/topstories.json":
          res = [1, 2];
          break;
        case "$baseURL/beststories.json":
          res = [3, 4];
          break;
        case "$baseURL/newstories.json":
          res = [5, 6];
          break;
        case "$baseURL/showstories.json":
          res = [7, 8];
          break;
        case "$baseURL/askstories.json":
          res = [9, 10];
          break;
        case "$baseURL/jobstories.json":
          res = [11, 12];
          break;
        default:
          break;
      }

      return Response(json.encode(res), 200);
    });

    final topStoriesIds = await newsApi.fetchListOfItems(storyTypes.topStories);
    expect(topStoriesIds, [1, 2]);

    final bestStoriesIds =
        await newsApi.fetchListOfItems(storyTypes.bestStories);
    expect(bestStoriesIds, [3, 4]);

    final newStoriesIds = await newsApi.fetchListOfItems(storyTypes.newStories);
    expect(newStoriesIds, [5, 6]);

    final showStoriesIds =
        await newsApi.fetchListOfItems(storyTypes.showStories);
    expect(showStoriesIds, [7, 8]);

    final askStoriesIds = await newsApi.fetchListOfItems(storyTypes.askStories);
    expect(askStoriesIds, [9, 10]);

    final jobStoriesIds = await newsApi.fetchListOfItems(storyTypes.jobStories);
    expect(jobStoriesIds, [11, 12]);
  }); // returns the appropriate list of ids

  test("FetchItem should return an item model", () async {
    final newsApi = HackerNewsAPI();

    newsApi.client = MockClient((request) async {
      final jsonMap = {'id': 123};
      return Response(jsonEncode(jsonMap), 200);
    });

    final item = await newsApi.fetchItem(99999);
    expect(item.id, 123);
  }); //fetchItem should return an ItemModel
} //main

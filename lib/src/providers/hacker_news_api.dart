import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' show Client;

import '../models/itemModel.dart';

// current base url to the HN API as of 02/15/19
const String baseURL = 'https://hacker-news.firebaseio.com/v0';

//define the different types of list<int> api calls
enum storyTypes {
  topStories,
  newStories,
  bestStories,
  askStories,
  showStories,
  jobStories,
}

//todo: implement abstract classes for source
class HackerNewsAPI {
  // init HTTP client
  Client client = Client();

  // ge a list of the top ids as an List<int>
//  Future<List<int>> getListOfTopIds() async {
//    final response = await client.get('$baseURL/topstories.json');
//    final ids = json.decode(response.body);
//    return ids.cast<int>();
//  } // getListOfTopIds

  //get request and json decoder helper
  Future<List<int>> fetchListOfItems(storyTypes st) async {
    final fullUrl = _getURLEndpoint(st);
    final response = await client.get(fullUrl);
    final ids = json.decode(response.body);
    return ids.cast<int>();
  } // fetchListOfItems

  //fetch the item using an item id
  Future<ItemModel> fetchItem(int id) async {
    final response = await client.get("$baseURL/item/$id.json");
    final parsedJson = jsonDecode(response.body);
    return ItemModel.fromJson(parsedJson);
  }

// --> HELPERS <-- \\

//return the full URL endpoint for the correct list to be retrieved
  String _getURLEndpoint(storyTypes st) {
    String url = "";
    switch (st) {
      case storyTypes.bestStories:
        url = "$baseURL/beststories.json";
        break;
      case storyTypes.newStories:
        url = "$baseURL/newstories.json";
        break;
      case storyTypes.topStories:
        url = "$baseURL/topstories.json";
        break;
      case storyTypes.showStories:
        url = "$baseURL/showstories.json";
        break;
      case storyTypes.askStories:
        url = "$baseURL/askstories.json";
        break;
      case storyTypes.jobStories:
        url = "$baseURL/jobstories.json";
        break;
      default:
        url = "$baseURL/topstories.json";
        break; // handle error
    }

    return url;
  } //_getURLEndpoint

} //HackerNewsAPI

final List<int> list = [1, 2, 3, 4, 5];

printList() {
  print(list.toString());
}

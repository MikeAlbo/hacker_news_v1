import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' show Client;

// current base url to the HN API as of 02/15/19
const String baseURL = 'https://hacker-news.firebaseio.com/v0';

//define the different types of list<int> api calls
enum storyTypes {
  topStories,
  newStories,
  bestStories,
}

//todo: implement abstract classes for source
class HackerNewsAPI {
  // init HTTP client
  final Client client = Client();

  // ge a list of the top ids as an List<int>
  Future<List<int>> getListOfTopIds() async {
    final response = await client.get('$baseURL/topstories.json');
    final ids = json.decode(response.body);
    return ids.cast<int>();
  } // getListOfTopIds

  Future<List<int>> getListOfIds(storyTypes st) async {
    String url = "";
    switch (st) {
      case storyTypes.bestStories:
        url = "$baseURL/beststories";
        break;
      case storyTypes.newStories:
        url = "$baseURL/newstories";
        break;
      case storyTypes.topStories:
        url = "$baseURL/topstories";
        break;
      default:
        url = "$baseURL/topstories";
        break; // handle error
    }

    return await _getListAndDecodeJson(url);
  } //getListOfIds

  //get request and json decoder helper
  Future<List<int>> _getListAndDecodeJson(String url) async {
    final response = await client.get(url);
    final ids = json.decode(response.body);
    return ids.cast<int>();
  } // _getListAndDecodeJson

//todo: experiment with creating a switch statement and combining the list function calls
//todo: write a test to determine functionality of switch
// todo: possibly refactor so that the get request is called in the main function and the url is selector is the helper function
} //HackerNewsAPI

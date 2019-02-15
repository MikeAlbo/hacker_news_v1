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
  askStories,
  showStories,
  jobStories,
}

//todo: implement abstract classes for source
class HackerNewsAPI {
  // init HTTP client
  final Client client = Client();

  // ge a list of the top ids as an List<int>
//  Future<List<int>> getListOfTopIds() async {
//    final response = await client.get('$baseURL/topstories.json');
//    final ids = json.decode(response.body);
//    return ids.cast<int>();
//  } // getListOfTopIds

  //get request and json decoder helper
  Future<List<int>> getListOfItems(storyTypes st) async {
    final fullUrl = _getURLEndpoint(st);
    final response = await client.get(fullUrl);
    final ids = json.decode(response.body);
    return ids.cast<int>();
  } // getListOfItems

// --> HELPERS <-- \\

//return the full URL endpoint for the correct list to be retrieved
  String _getURLEndpoint(storyTypes st) {
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
      case storyTypes.showStories:
        url = "$baseURL/showstories";
        break;
      case storyTypes.askStories:
        url = "$baseURL/askstories";
        break;
      case storyTypes.jobStories:
        url = "$baseURL/jobstories";
        break;
      default:
        url = "$baseURL/topstories";
        break; // handle error
    }

    return url;
  } //_getURLEndpoint

//todo: experiment with creating a switch statement and combining the list function calls
//todo: write a test to determine functionality of switch
// todo: possibly refactor so that the get request is called in the main function and the url is selector is the helper function
} //HackerNewsAPI

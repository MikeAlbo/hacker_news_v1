import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' show Client;

// current base url to the HN API as of 02/15/19
const String baseURL = 'https://hacker-news.firebaseio.com/v0';

//todo: implement abstract classes for source
class HackerNewsAPI {
  final Client client = Client();

  // ge a list of the top ids as an List<int>
  Future<List<int>> getListOfTopIds() async {
    final response = await client.get('$baseURL/topstories.json');
    final ids = json.decode(response.body);
    return ids.cast<int>();
  } // getListOfTopIds

} //HackerNewsAPI

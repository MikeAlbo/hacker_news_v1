//todo: create a favoritesModel class
//todo: create a method that takes an array an converts it to a string
//todo: create a method that adds a new item to the array
//todo: create a method that finds/removes an id from the db
//todo: create a method that writes to the db
//todo: create a method that clears the entire favorites array
//todo: create test to "test" the functionality of the methods

import 'dart:convert';

class FavoritesModel {
  final int id;
  final List<int> favoritesIds;

  // we want to take the mapped data from the db query, we should select the "ids" key and then decode that string into a List<int> ... in theory
  FavoritesModel.fromDb(Map<String, dynamic> parsedDb)
      : id = parsedDb["id"],
        favoritesIds = json.decode(parsedDb["favoritesIds"]);

  //we should take the ids property and encode it into a JSON string which will be stored in the db under the ids field
  Map<String, dynamic> toMapForDb() {
    return <String, dynamic>{
      "id": id,
      "favoritesIds:": jsonEncode(favoritesIds),
    };
  }
}

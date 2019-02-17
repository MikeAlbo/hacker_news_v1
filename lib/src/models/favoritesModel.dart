//todo: create a favoritesModel class
//todo: create a method that takes an array an converts it to a string
//todo: create a method that adds a new item to the array
//todo: create a method that finds/removes an id from the db
//todo: create a method that writes to the db
//todo: create a method that clears the entire favorites array
//todo: create test to "test" the functionality of the methods

import 'dart:convert';

class FavoritesModel {
  final List<dynamic> ids;

  FavoritesModel.fromDb(Map<String, dynamic> parsedDb) : ids = parsedDb["ids"];

  Map<String, String> toStringForDb() {
    return <String, String>{
      "ids:": jsonEncode(ids),
    };
  }
}

// this model should just contain the methods to do the data conversions. The read write functions should be handled in the db provider. These methods should be called from the bloc.

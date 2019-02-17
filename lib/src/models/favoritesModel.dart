//todo: create a favoritesModel class
//todo: create a method that takes an array an converts it to a string
//todo: create a method that adds a new item to the array
//todo: create a method that finds/removes an id from the db
//todo: create a method that writes to the db
//todo: create a method that clears the entire favorites array
//todo: create test to "test" the functionality of the methods

import 'dart:convert';

class FavoritesModel {
  final List<int> ids;

  // we want to take the mapped data from the db query, we should select the "ids" key and then decode that string into a List<int> ... in theory
  FavoritesModel.fromDb(Map<String, String> parsedDb)
      : ids = json.decode(parsedDb["ids"]);

  //we should take the ids property and encode it into a JSON string which will be stored in the db under the ids field
  Map<String, String> toStringForDb() {
    return <String, String>{
      "ids:": jsonEncode(ids),
    };
  }
}

//ok, something to consider. we could try to have each id as its own entry into the db. We would just do a query for all of the entries and then somehow parse the results into an array for the read function. Add, remove function would do those actions strait on the db and then re-query the db.

// this model should just contain the methods to do the data conversions. The read write functions should be handled in the db provider. These methods should be called, along with the add/remove/clear methods, from the bloc.

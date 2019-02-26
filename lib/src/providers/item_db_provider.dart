import 'dart:async';
import 'dart:io';

import 'package:hacker_news_v1/src/providers/hacker_news_api.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import '../models/favorites_model.dart';
import '../models/item_model.dart';
import 'repository.dart';

class ItemDbProvider extends ItemSources {
  //future: add a method call to fetch the proper list of story ids
  // added to satisfy the abstract ItemSources class
  Future<List<int>> fetchListOfItems(storyTypes st) async {
    return await null;
  }

  Database _db;

  // use the constructor to initialize the database
  ItemDbProvider() {
    init();
  }

  // initialize the database, if one does not exist then create one at that path
  void init() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, "item_test_1.db");
    _db = await openDatabase(
      path,
      version: 1,
      onCreate: this._createTables,
    );
  } //init

  // on create helper to generate 2 tables
  Future _createTables(Database db, int version) async {
    await db.execute("""
      CREATE TABLE Items
      (
      id INTEGER PRIMARY KEY,
      type TEXT,
      by TEXT,
      time INTEGER,
      text TEXT,
      parent INTEGER,
      kids BLOB,
      dead INTEGER,
      deleted INTEGER,
      url TEXT,
      score INTEGER,
      title TEXT,
      descendants INTEGER
      )
      """);

    await db.execute("""
     CREATE TABLE Favorites
     (
     id INTEGER PRIMARY KEY,
     favoritesIds BLOB
     )
    """);
  }

  // fetch the list of favorites from the db
  Future<FavoritesModel> fetchFavorites(int id) async {
    final maps = await _db.query(
      "Favorites",
      columns: null,
      where: "id = ?",
      whereArgs: [id], // todo: make sure favorites list id does not change
    );

    if (maps.length > 0) {
      return FavoritesModel.fromDb(maps.first);
    }

    return null;
  } // fetchFavorites

  // write the list of favorites to the db
  Future<int> addFavoritesListToDb(FavoritesModel favorites) async {
    return _db.insert("Favorites", favorites.toMapForDb(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  } // addFavoritesListToDB

  // clear the list of favorites form the db
  Future<int> clearFavoritesList() {
    return _db.delete("Favorites");
  } // clearFavoritesList

  // fetch an item from the Items table
  Future<ItemModel> fetchItem(int id) async {
    final maps = await _db.query(
      "Items",
      columns: null,
      where: "id = ?",
      whereArgs: [id],
    );

    if (maps.length > 0) {
      return ItemModel.fromDb(maps.first);
    }

    return null;
  } // fetchItem

// add an item to the Items table
  Future<int> addItem(ItemModel item) {
    return _db.insert("Items", item.toMapForDb(),
        conflictAlgorithm: ConflictAlgorithm.ignore);
  } // addItem

// clear the Items table of all data
  Future<int> clearItems() {
    return _db.delete("Items");
  } // clearItems

} // ItemDbProvider

// create an instance of the ItemDbProvider for use in application
final itemDbProvider = ItemDbProvider();

/*
* future: the favorites table can be refactored to save list for all of the different list quires
* */

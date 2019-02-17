import 'dart:async';
import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import '../models/itemModel.dart';

class ItemDbProvider {
  Database _db;

  // use the constructor to initialize the database
  ItemDbProvider() {
    init();
  }

  // initialize the database, if one does not exist then create one at that path
  void init() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, "item.db");
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

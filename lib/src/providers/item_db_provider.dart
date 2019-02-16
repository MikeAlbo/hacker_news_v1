import 'dart:async';
import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import '../models/itemModel.dart';

class ItemDbProvider {
  Database db;

  // use the constructor to initialize the database
  ItemDbProvider() {
    init();
  }

  // initialize the database, if one does not exist then create one at that path
  void init() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, "item.db");
    db = await openDatabase(path, version: 1,
        onCreate: (Database newDb, int version) {
      newDb.execute("""
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
    });
  } //init

  // fetch an item from the Items table
  Future<ItemModel> fetchItem(int id) async {
    final maps = await db.query(
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
    return db.insert("Items", item.toMapForDb(),
        conflictAlgorithm: ConflictAlgorithm.ignore);
  } // addItem

// clear the Items table of all data
  Future<int> clearItems() {
    return db.delete("Items");
  } // clearItems

} // ItemDbProvider

import 'dart:async';

import 'package:hacker_news_v1/src/models/favorites_model.dart';

import '../models/item_model.dart';
import 'hacker_news_api.dart';
import 'item_db_provider.dart';

class Repository {
  List<ItemSources> sources = <ItemSources>[
    itemDbProvider,
    HackerNewsAPI(),
  ];

  //get a appropriate list of Ids
  Future<List<int>> fetchListOfIds(storyTypes st) async {
    print("repo: fetch lis tof items"); //todo: test! remove!!
    return sources[1].fetchListOfItems(st);
  } //getListOfIds

  // fetch an item by id
// checks the db first, then hits the api, afterwards it will attempt to write to db
  Future<ItemModel> fetchItem(int id) async {
    ItemModel item;
    ItemSources itemSource;

    for (itemSource in sources) {
      item = await itemSource.fetchItem(id);
      if (item != null) {
        break;
      }
    }
    itemDbProvider.addItem(item);
    return item;
  } //fetchItem

  // clear the saved Items cache
  clearCache() async {
    await itemDbProvider.clearItems();
  }

// get list of favorites
  // can be refactored later to fetch different list of ids
  Future<FavoritesModel> fetchFavorites(int id) async {
    return await itemDbProvider.fetchFavorites(id);
  } // fetchFavorites

// write list of favorites
  Future<int> writeFavorites(int id, FavoritesModel favorites) async {
    return await itemDbProvider.addFavoritesListToDb(favorites);
  } //writeFavorites

} //Repository

abstract class ItemSources {
  Future<ItemModel> fetchItem(int id);
  Future<List<int>> fetchListOfItems(storyTypes st);
} //ItemSources

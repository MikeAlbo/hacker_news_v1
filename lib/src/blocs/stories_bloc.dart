import 'dart:async';

import 'package:hacker_news_v1/src/models/item_model.dart';
import 'package:hacker_news_v1/src/providers/repository.dart';
import 'package:rxdart/rxdart.dart';

import '../providers/hacker_news_api.dart';

class StoriesBloc {
  final _repository = Repository();
  final _listOfIds = PublishSubject<List<int>>();
  final _itemsOutput = BehaviorSubject<Map<int, Future<ItemModel>>>();
  final _itemsFetcher = PublishSubject<int>();

  // Getters to access the streams
  Observable<List<int>> get listOfIds => _listOfIds.stream;
  Observable<Map<int, Future<ItemModel>>> get items => _itemsOutput.stream;

  // Getter to add an item id to the sink
  Function(int) get fetchItem => _itemsFetcher.sink.add;

  //constructor which applies the transformer to the item model
  StoriesBloc() {
    _itemsFetcher.stream.transform(_itemTransformer()).pipe(_itemsOutput);
  }

  // retrieve the appropriate list of ids from the repo
  fetchListOfIds(storyTypes st) async {
    print("stories bloc: List of Ids called"); //todo: remove
    final ids = await _repository.fetchListOfIds(st);
    _listOfIds.sink.add(ids);
  }

  _itemTransformer() {
    return ScanStreamTransformer(
      (Map<int, Future<ItemModel>> cache, int id, index) {
        // print(index); //todo: remove for production, used to test api calls
        cache[id] = _repository.fetchItem(id);
        return cache;
      },
      <int, Future<ItemModel>>{},
    );
  }

  clearItemsFromCache() async {
    await _repository.clearCache();
  }

  // close the streams
  dispose() {
    _listOfIds.close();
    _itemsOutput.close();
    _itemsFetcher.close();
  }
}

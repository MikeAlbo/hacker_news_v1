import 'dart:async';

import 'package:rxdart/rxdart.dart';

import '../models/item_model.dart';
import '../providers/repository.dart';

//todo: load first comment with replies
//todo: take an array and load additional comments

class CommentBloc {
  final _repository = Repository();
  final _singleCommentFetcher = PublishSubject<int>();
  final _allCommentFetcher = PublishSubject<int>();
  final _commentsOutput = BehaviorSubject<Map<int, Future<ItemModel>>>();

  //constructor
  CommentBloc() {
    _allCommentFetcher
        .transform(_allCommentsTransformer())
        .pipe(_commentsOutput);
    _singleCommentFetcher
        .transform(_singleCommentTransformer())
        .pipe(_commentsOutput);
  }

  //Stream
  Observable<Map<int, Future<ItemModel>>> get itemWithComments =>
      _commentsOutput.stream;

  //Sink
  Function(int) get fetchASingleComment => _singleCommentFetcher.sink.add;
  Function(int) get fetchAllComments => _allCommentFetcher.sink.add;

  //transformers

  //transformer for single comment
  _singleCommentTransformer() {
    return ScanStreamTransformer<int, Map<int, Future<ItemModel>>>(
      (cache, int id, _) {
        cache[id] = _repository.fetchItem(id);
        cache[id].then((ItemModel item) {
          return fetchAllComments(item.kids[0]);
        });
        return cache;
      },
      <int, Future<ItemModel>>{},
    );
  }

  // transformer for all comments
  _allCommentsTransformer() {
    return ScanStreamTransformer<int, Map<int, Future<ItemModel>>>(
      (cache, int id, _) {
        cache[id] = _repository.fetchItem(id);
        cache[id].then((ItemModel item) {
          item.kids.forEach((kidId) => fetchAllComments(kidId));
        });
        return cache;
      },
      <int, Future<ItemModel>>{},
    );
  }

  // cleanup function
  dispose() {
    _commentsOutput.close();
    _singleCommentFetcher.close();
    _allCommentFetcher.close();
  }
}

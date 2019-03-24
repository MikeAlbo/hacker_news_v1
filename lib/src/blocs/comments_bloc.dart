import 'dart:async';

import 'package:rxdart/rxdart.dart';

import '../models/item_model.dart';
import '../providers/repository.dart';

//todo: load first comment with replies
//todo: take an array and load additional comments

class CommentBloc {
  final _repository = Repository();
  final _commentsFetcher = PublishSubject<int>();
  final _commentsOutput = BehaviorSubject<Map<int, Future<ItemModel>>>();

  dispose() {
    _commentsFetcher.close();
    _commentsOutput.close();
  }
}

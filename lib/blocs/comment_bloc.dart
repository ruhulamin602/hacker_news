import 'package:news/resources/repository.dart';
import 'package:rxdart/rxdart.dart';
import 'package:news/models/item_model.dart';
import 'dart:async';

class CommentBloc {
  final _repository = Repositoery();

// controllers
  final _commentsFetcher = PublishSubject<int>();
  final _commentOutput = BehaviorSubject<Map<int, Future<ItemModels>>>();

// streams
  Stream<Map<int, Future<ItemModels>>> get itemWithcomments =>
      _commentOutput.stream;

// sinks
  Function(int) get fetchComments => _commentsFetcher.sink.add;

// bloc constractor
  CommentBloc() {
    _commentsFetcher.stream
        .transform(_commentTrenasformer())
        .pipe(_commentOutput);
  }

// tramsformers
  _commentTrenasformer() {
    return ScanStreamTransformer<int, Map<int, Future<ItemModels>>>(
      (cache, int id, index) {
        print(index);
        cache[id] = _repository.fetchItems(id);
        cache[id].then((ItemModels item) {
          item.kids.forEach((kidId) => fetchComments(kidId));
        });
        return cache;
      },
      <int, Future<ItemModels>>{},
    );
  }

// disposer
  dispose() {
    _commentsFetcher.close();
    _commentOutput.close();
  }
}

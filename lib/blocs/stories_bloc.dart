import 'package:news/models/item_model.dart';
import 'package:rxdart/rxdart.dart';
import '../resources/repository.dart';
import 'dart:async';

class StoriesBloc {
  final _repository = Repositoery();
  final _topIds = PublishSubject<List<int>>();
  final _bestIds = PublishSubject<List<int>>();
  final _itemsOutput = BehaviorSubject<Map<int, Future<ItemModels>>>();
  final _itemFetcher = PublishSubject<int>();
  

  // Streams
  Stream<List<int>> get topIds => _topIds.stream;
  Stream<List<int>> get bestIds => _bestIds.stream;
  Stream<Map<int, Future<ItemModels>>> get item => _itemsOutput.stream;

  //Sinks
  fetchTopIds() async {
    final id = await _repository.fetchTopIds();
    _topIds.sink.add(id);
  }
  fetchBestIds() async {
    final id = await _repository.fetchBestIds();
    _bestIds.sink.add(id);
  }

   Function(int) get fetchItems => _itemFetcher.sink.add;

  // Transformers
  StoriesBloc() {
    _itemFetcher.stream.transform(_itemTransformer()).pipe(_itemsOutput);
  }
  _itemTransformer() {
    return ScanStreamTransformer(
        (Map<int, Future<ItemModels>> cache, int id, index) {
          print(index);
      cache[id] = _repository.fetchItems(id);
      return cache;
    }, <int, Future<ItemModels>>{});
  }
  deleteDb(){
    return _repository.deleteCache();
  }
  dispose() {
    _topIds.close();
    _itemsOutput.close();
    _itemFetcher.close();
    _bestIds.close();
  }
}

import 'package:news/models/item_model.dart';
import 'package:news/resources/news_api_provider.dart';
import 'package:news/resources/news_db_provider.dart';

class Repositoery {
  List<Source> sources = <Source>[
    newsDbProvider,
    NewsApiProvider(),
  ];

  List<Cache> caches = <Cache>[
    newsDbProvider,
  ];
  // (todo)-when we need to edit it...
  Future<List<int>> fetchTopIds() {
    return sources[1].fetchTopIds();
  }
  Future<List<int>> fetchBestIds() {
    return sources[1].fetchBestIds();
  }

  Future<ItemModels> fetchItems(int id) async {
    ItemModels item;
    var source;
    for (source in sources) {
      item = await source.fetchItems(id);

      if (item != null) {
        break;
      }
    }
    for (var cache in caches) {
      if (cache != source) {
        cache.addItems(item);
      }
    }
    return item;
  }

  deleteCache() async {
    Cache cache;
    for (cache in caches) {
      await cache.clear();
    }
  }
}

abstract class Source {
  Future<List<int>> fetchTopIds();
  Future<List<int>> fetchBestIds();
  Future<ItemModels> fetchItems(int id);
}

abstract class Cache {
  Future<int> addItems(ItemModels item);
  Future<int> clear();
}

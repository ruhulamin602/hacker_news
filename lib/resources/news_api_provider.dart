import 'dart:convert';
import 'package:http/http.dart' show Client;
import 'package:news/models/item_model.dart';
import 'repository.dart';

final _root = 'https://hacker-news.firebaseio.com/v0';

class NewsApiProvider implements Source {
  Client client = Client();

  Future<List<int>> fetchTopIds() async {
    final response = await client.get('$_root/topstories.json');

    final ids = json.decode(response.body);

    return ids.cast<int>();
  }
  Future<List<int>> fetchBestIds() async {
    final response = await client.
    get('$_root/beststories.json');

    final ids = json.decode(response.body);

    return ids.cast<int>();
  }

  Future<ItemModels> fetchItems(int id) async {
    final response = await client.get('$_root/item/$id.json');
    final items = json.decode(response.body);
    final item = ItemModels.fromJson(items);
    return item;
  }
}

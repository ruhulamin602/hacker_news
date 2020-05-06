import 'dart:convert';

class ItemModels {
  const ItemModels(
      {this.id,
      this.deleted,
      this.type,
      this.by,
      this.time,
      this.text,
      this.dead,
      this.parent,
      this.kids,
      this.url,
      this.score,
      this.title,
      this.descendants});

  final int id;
  final bool deleted;
  final String type;
  final String by;
  final int time;
  final String text;
  final bool dead;
  final int parent;
  final List<dynamic> kids;
  final String url;
  final int score;
  final String title;
  final int descendants;

  ItemModels.fromJson(Map<String, dynamic> parsedJson)
      : id = parsedJson['id'],
        deleted = parsedJson['deleted'] ?? false,
        type = parsedJson['type'],
        by = parsedJson['by'] ?? '',
        time = parsedJson['time'],
        text = parsedJson['text'] ?? '',
        dead = parsedJson['dead'] ?? false,
        parent = parsedJson['parent'],
        kids = parsedJson['kids'] ?? [],
        url = parsedJson['url'],
        score = parsedJson['score'],
        title = parsedJson['title'],
        descendants = parsedJson['descendants'];

  ItemModels.fromDb(Map<String, dynamic> parJson)
      : id = parJson['id'],
        deleted = parJson['deleted'] == 1,
        type = parJson['type'],
        by = parJson['by'],
        time = parJson['time'],
        text = parJson['text'],
        dead = parJson['dead'] == 1,
        parent = parJson['parent'],
        kids = jsonDecode(parJson['kids']),
        url = parJson['url'],
        score = parJson['score'],
        title = parJson['title'],
        descendants = parJson['descendants'];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "id": id,
      "deleted": deleted ? 1 : 0,
      "type": type,
      "by": by,
      "time": time,
      "text": text,
      "dead": dead ? 1 : 0,
      "parent": parent,
      "kids": jsonEncode(kids),
      "url": url,
      "score": score,
      "title": title,
      "descendants": descendants,
    };
  }
}

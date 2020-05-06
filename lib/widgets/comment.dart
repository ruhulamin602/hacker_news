import 'package:flutter/material.dart';
import 'package:news/models/item_model.dart';
import 'package:news/widgets/html_to_String.dart';
import 'package:news/widgets/loading_container.dart';

class Comment extends StatelessWidget {
  final int itemId;
  final Map<int, Future<ItemModels>> itemMap;
  final int depth;

  Comment({this.itemId, this.itemMap, this.depth});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: itemMap[itemId],
        builder: (context, AsyncSnapshot<ItemModels> snapshot) {
          if (!snapshot.hasData) {
            return loadingData();
          }
          final item = snapshot.data;
          final children = <Widget>[
            ListTile(
              contentPadding:
                  EdgeInsets.only(right: 16.0, left: (depth + 1) * 16.0),
              title: buildText(item),
              subtitle: Text(item.by == "" ? 'Deleted' : item.by),
            ),
            Divider(
              thickness: 3,
            ),
          ];
          item.kids.forEach((kids) => children.add(Comment(
                itemId: kids,
                itemMap: itemMap,
                depth: depth + 1,
              )));
          return Column(
            children: children,
          );
        });
  }

  Widget buildText(ItemModels item) {
    final text=item.text
    .replaceAll('<p>', '\n\n');
    final text1 = parseHtmlString(text);
    return Text(text1);
  }
}

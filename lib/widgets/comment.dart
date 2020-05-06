import 'package:flutter/material.dart';
import 'package:news/models/item_model.dart';

class Comment extends StatelessWidget {
  final int itemId;
  final Map<int, Future<ItemModels>> itemMap;

  Comment({this.itemId, this.itemMap});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: itemMap[itemId],
        builder: (context, AsyncSnapshot<ItemModels> snapshot) {
          if (!snapshot.hasData) {
            return Text('loading');
          }
          final item = snapshot.data;
          final children = <Widget>[
            ListTile(
              title: Text(item.by == null ? 'Deleted' : item.text),
              subtitle: Text(item.by == null ? '' : item.by),
            ),
          ];
          item.kids.forEach((kids) => children.add(Comment(
                itemId: kids,
                itemMap: itemMap,
              )));
          return Column(
            children: children,
          );
        });
  }
}

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:news/blocs/stories_provider.dart';
import 'package:news/models/item_model.dart';
import 'package:news/widgets/html_to_String.dart';
import 'package:news/widgets/loading_container.dart';
import 'package:news/widgets/toggled_text.dart';

class NewsListTile extends StatelessWidget {
  final int itemId;

  NewsListTile({this.itemId});

  @override
  Widget build(BuildContext context) {
    
    final bloc = StoriesProvider.of(context);
    return StreamBuilder(
      stream: bloc.item,
      builder: (context, AsyncSnapshot<Map<int, Future<ItemModels>>> snapshot) {
        if (!snapshot.hasData) {
          return loadingData();
        }
         
        return FutureBuilder(
            future: snapshot.data[itemId],
            builder: (
              context,
              AsyncSnapshot<ItemModels> itemsnapshot,
            ) {
              if (!itemsnapshot.hasData) {
                return loadingData();
              }

              return cardData(context, itemsnapshot.data, itemId.isOdd);
            });
      },
    );
  }

  Widget cardData(BuildContext context, ItemModels item, bool isOd) {
    return Container(
      color: Colors.white.withOpacity(.2),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Card(
            elevation: 3.0,
            margin: EdgeInsets.symmetric(horizontal: 15.0, vertical: 2.0),
            color: Colors.white,
            shape: Border.all(color: Colors.cyan),
            child: Column(
              children: <Widget>[
                ListTile(
                  onTap: () {
                    Navigator.pushNamed(context, '/${item.id}');
                  },
                  title: Text('${item.title}'),
                  subtitle: Text('${item.score} votes'),
                  enabled: !item.dead,
                  trailing: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Icon(Icons.chat_bubble_outline),
                      SizedBox(height: 10),
                      Text('${item.descendants == null ? 0 : item.descendants}')
                    ],
                  ),
                ),
                item.text == null
                    ? null
                    : Container(
                        margin: EdgeInsets.symmetric(
                            horizontal: 15.0, vertical: 2.0),
                        child: DescriptionTextWidget(
                          text: parseHtmlString(
                            item.text,
                          ),
                          textCount: 50,
                        ),
                      ),
              ],
            ),
          ),
          // Divider(
          //   thickness: 2,
          //   height: 10,
          //   endIndent: 20,
          //   indent: 20,
          //   color: Colors.black26,
          // )
        ],
      ),
    );
  }
}

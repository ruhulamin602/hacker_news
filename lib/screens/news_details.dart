import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:news/blocs/comment_provider.dart';
import 'package:news/models/item_model.dart';
import 'package:news/widgets/comment.dart';

class NewsDetail extends StatelessWidget {
  final int itemId;

  NewsDetail({this.itemId});

  @override
  Widget build(BuildContext context) {
    final bloc = CommentProviver.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("News Details"),
      ),
      body: buildBody(bloc),
    );
  }

  Widget buildBody(CommentBloc bloc) {
    return StreamBuilder(
        stream: bloc.itemWithcomments,
        builder:
            (context, AsyncSnapshot<Map<int, Future<ItemModels>>> snapshot) {
          if (!snapshot.hasData) {
            return Text('Loading');
          }
          final itemFuture = snapshot.data[itemId];
          return FutureBuilder(
              future: itemFuture,
              builder: (context, itemsnapshot) {
                if (!itemsnapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                }
                return buildList(itemsnapshot.data,snapshot.data);
              });
        });
  }
  Widget buildList(ItemModels item, Map<int, Future<ItemModels>> itemMap){
    final  children=<Widget>[];
    children.add(storyTitle(item));
    final commentList=item.kids.map((kidId)=> Comment(itemId: kidId, itemMap: itemMap,depth:0,)).toList();
    children.addAll(commentList);
      return ListView(
           children: children,
      );
  }
  Widget storyTitle(ItemModels item) {
    return Container(
      margin: EdgeInsets.all(10),
      alignment: Alignment.topCenter,
      child: Text(
        item.title,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

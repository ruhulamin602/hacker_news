import 'package:flutter/material.dart';
import 'package:news/blocs/stories_provider.dart';

import 'package:news/widgets/news_list_tile.dart';
import 'package:news/widgets/refresh.dart';

class NewsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = StoriesProvider.of(context);
    // TEMPORARY

    return Scaffold(
      appBar: AppBar(
        title: Text("News List"),
      ),
      body: Center(
        child: Container(
          child: buildList(bloc),
        ),
      ),
    );
  }
}

Widget buildList(StoriesBloc bloc) {
  return StreamBuilder(
    stream: bloc.topIds,
    builder: (context, AsyncSnapshot<List<int>> snapshot) {
      if (!snapshot.hasData) {
        return Center(
          child: CircularProgressIndicator(),
        );
      }

      return Refresh(
        child: ListView.builder(
          itemCount: snapshot.data.length,
          itemBuilder: (context, int index) {
            bloc.fetchItems(snapshot.data[index]);
            return NewsListTile(itemId: snapshot.data[index]);
          },
        ),
      );
    },
  );
}

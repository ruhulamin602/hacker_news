import 'package:flutter/material.dart';
import 'package:news/blocs/stories_provider.dart';

import 'package:news/widgets/news_list_tile.dart';
import 'package:news/widgets/refresh.dart';

class NewsList extends StatefulWidget {
  final ids;
  final title;
  NewsList({this.ids, this.title});
  @override
  _NewsListState createState() => _NewsListState();
}

class _NewsListState extends State<NewsList>
    with SingleTickerProviderStateMixin {
  // TabController _tabController;
 
  @override
  void initState() {
    super.initState();
    // _tabController = TabController(length: 1, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    // _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bloc = StoriesProvider.of(context);

    // TEMPORARY

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
        actions: <Widget>[
          Container(
            margin: EdgeInsets.only(right: 15),
            padding: EdgeInsets.symmetric(horizontal:0 , vertical: 7),
            child: RaisedButton(
              onPressed: () {
                widget.title == "Best News"
                    ? Navigator.pushNamed(context, '/top')
                    : Navigator.pushNamed(context, '/');
              },
              child: widget.title == "Best News"
                  ? Text('Top News')
                  : Text('Best News'),
                  padding: EdgeInsets.all(0),
                  color: Colors.amberAccent,
            ),
          )
        ],
        // bottom: TabBar(controller: _tabController, tabs: [
        //   Tab(
        //     text: 'Best',
        //   ),
        //   Tab(
        //     text: 'Top',
        //   )
        // ]),
      ),
      // body: TabBarView(
      // children: [
      body: Center(
        child: Container(
          child: buildList(bloc, widget.ids),
        ),
      ),
      // Center(
      //   child: Container(
      //     child: buildList(bloc, widget.ids),
      //   ),
      // ),
      // ],),
    );
  }
}

Widget buildList(StoriesBloc bloc, stream) {
  return StreamBuilder(
    stream: stream,
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

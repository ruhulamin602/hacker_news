
import 'package:flutter/material.dart';
import 'package:news/blocs/comment_provider.dart';
import 'package:news/screens/news_list.dart';
import 'blocs/stories_provider.dart';
import 'package:news/screens/news_details.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CommentProviver(
          child: StoriesProvider(
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          onGenerateRoute: routes,
        ),
      ),
    );
  }

  Route routes(RouteSettings settings) {
    if (settings.name == '/') {
      return MaterialPageRoute(
        builder: (context) {
          final bloc = StoriesProvider.of(context);
          bloc.fetchTopIds();
          return NewsList();
        },
      );
    }
    return MaterialPageRoute(builder: (context) {
      final itemId = int.parse(settings.name.replaceFirst('/', ''));

      return NewsDetail(itemId: itemId);
    });
  }
}

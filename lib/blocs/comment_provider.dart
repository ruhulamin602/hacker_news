import 'package:flutter/material.dart';
import 'comment_bloc.dart';
export 'comment_bloc.dart';

class CommentProviver extends InheritedWidget {
  final CommentBloc bloc;
  CommentProviver({Key key, Widget child})
      : bloc = CommentBloc(),
        super(key: key, child: child);

  @override
  bool updateShouldNotify(_) {
    return true;
  }

  static CommentBloc of(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<CommentProviver>()).bloc;
  }
}
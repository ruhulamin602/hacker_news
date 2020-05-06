import 'package:flutter/material.dart';

Widget loadingData() {
  return Container(
    color: Colors.white.withOpacity(.2),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        ListTile(
          title: Container(
            color: Colors.grey[200],
          ),
          subtitle: Container(
            color: Colors.grey[200],
          ),
        ),
        Divider(
          thickness: 2,
          height: 10,
          endIndent: 20,
          indent: 20,
          color: Colors.black26,
        )
      ],
    ),
  );
}

import 'package:flutter/material.dart';

Widget loadingData() {
  return Container(
    color: Colors.white.withOpacity(.2),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Card(
          margin: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
          elevation: 4,
          child: ListTile(
            title: Container(),
            subtitle: Container(),
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

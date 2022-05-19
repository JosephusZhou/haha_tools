import 'package:flutter/material.dart';

Widget backWidget() {
  return Padding(
    padding: const EdgeInsets.all(16),
    child: Row(
      children: const <Widget>[
        Icon(Icons.arrow_back_ios_new_rounded),
        Text("返回", style: TextStyle(fontSize: 16)),
      ],
    ),
  );
}

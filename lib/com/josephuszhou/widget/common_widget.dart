import 'package:flutter/material.dart';
import 'package:haha_tools/com/josephuszhou/widget/v_center_text.dart';

Widget backWidget() {
  return Padding(
    padding: const EdgeInsets.all(16),
    child: Row(
      children: const <Widget>[
        Icon(Icons.arrow_back_ios_new_rounded),
        VCenterText("返回", TextStyle(fontSize: 16, height: 1)),
      ],
    ),
  );
}

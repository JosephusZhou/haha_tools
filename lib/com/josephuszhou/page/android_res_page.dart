import 'package:flutter/material.dart';
import 'package:haha_tools/com/josephuszhou/base/base_state.dart';

import '../widget/common_widget.dart';

class AndroidResPage extends StatefulWidget {
  const AndroidResPage({Key? key}) : super(key: key);

  @override
  State<AndroidResPage> createState() => _AndroidResPageState();
}

class _AndroidResPageState extends BaseState<AndroidResPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          GestureDetector(
            onTap: () => {Navigator.pop(context)},
            child: backWidget(context),
          ),
        ],
      ),
    );
  }
}

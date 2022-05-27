import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';

import 'com/josephuszhou/page/home_page.dart';
import 'com/josephuszhou/util/config_util.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppConfig().loadConfig();
    return OKToast(
        child: MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(title: 'Home'),
    ));
  }
}

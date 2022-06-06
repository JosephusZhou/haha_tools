import 'package:file_drag_and_drop/file_drag_and_drop_channel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:oktoast/oktoast.dart';

import 'com/josephuszhou/page/home_page.dart';
import 'com/josephuszhou/util/config_util.dart';
import 'l10n/s.g.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dragAndDropChannel.initializedMainView();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppConfig().loadConfig();
    return OKToast(
      child: MaterialApp(
        onGenerateTitle: (BuildContext context) => S.of(context)!.appName,
        localizationsDelegates: const [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: S.supportedLocales,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const HomePage(),
      ),
    );
  }
}

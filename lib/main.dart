import 'package:file_drag_and_drop/file_drag_and_drop_channel.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:haha_tools/com/josephuszhou/page/sm_des_page.dart';
import 'package:oktoast/oktoast.dart';

import 'com/josephuszhou/constant/constants.dart';
import 'com/josephuszhou/page/android_res_page.dart';
import 'com/josephuszhou/page/generate_qrcode_page.dart';
import 'com/josephuszhou/page/home_page.dart';
import 'com/josephuszhou/page/read_qrcode_page.dart';
import 'com/josephuszhou/page/triple_des_page.dart';
import 'com/josephuszhou/util/config_util.dart';
import 'l10n/s.g.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (!kIsWeb) {
    await dragAndDropChannel.initializedMainView();
  }
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
        routes: _buildRoutes(context),
      ),
    );
  }

  Map<String, WidgetBuilder> _buildRoutes(BuildContext context) {
    return {
      "/": (context) => const HomePage(),
      Constants.androidResPage: (context) => const AndroidResPage(),
      Constants.tripleDesPage: (context) => const TripleDesPage(),
      Constants.smDesPage: (context) => const SMDesPage(),
      Constants.readQrCodePage: (context) => const ReadQrCodePage(),
      Constants.generateQrCodePage: (context) => const GenerateQrCodePage(),
    };
  }
}

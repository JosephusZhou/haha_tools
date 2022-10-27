import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';

import '../base/base_state.dart';
import '../constant/constants.dart';
import '../util/font_util.dart';
import '../util/sys_util.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends BaseState<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildCardItem(context, s.androidResTools, s.androidResToolsTips,
                  Icons.copy_outlined, () {
                Navigator.pushNamed(context, Constants.androidResPage);
              }, supportAndroid: false, supportIOS: false, supportWeb: false),
              buildCardItem(
                context,
                s.tripleDesTools,
                s.tripleDesToolsTips,
                Icons.enhanced_encryption,
                () {
                  Navigator.pushNamed(context, Constants.tripleDesPage);
                }, supportWeb: false
              ),
              buildCardItem(
                  context, s.qrcodeTools, s.qrcodeToolsTips1, Icons.qr_code,
                  () {
                Navigator.pushNamed(context, Constants.readQrCodePage);
              }, supportAndroid: false, supportIOS: false, supportWeb: false),
              buildCardItem(
                context,
                s.qrcodeTools,
                s.qrcodeToolsTips2,
                Icons.qr_code,
                () {
                  Navigator.pushNamed(context, Constants.generateQrCodePage);
                },
              ),
              buildCardItem(context, s.quotes, s.quotesToolsTips,
                  Icons.ssid_chart, () {
                    Navigator.pushNamed(context, Constants.quotesPage);
                  }),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildCardItem(BuildContext context, String title, String subTitle,
      IconData iconData, GestureTapCallback onTap,
      {bool supportWindows = true,
      bool supportMac = true,
      bool supportLinux = true,
      bool supportAndroid = true,
      bool supportIOS = true,
      bool supportWeb = true}) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, top: 16),
      child: GestureDetector(
        onTap: () {
          if (kIsWeb) {
            if (!supportWeb) {
              showToast(s.noSupportWeb);
              return;
            }
          } else {
            if (isWindows() && !supportWindows) {
              showToast(s.noSupportWindows);
              return;
            }
            if (isMacOS() && !supportMac) {
              showToast(s.noSupportMacOS);
              return;
            }
            if (isLinux() && !supportLinux) {
              showToast(s.noSupportLinux);
              return;
            }
            if (isAndroid() && !supportAndroid) {
              showToast(s.noSupportAndroid);
              return;
            }
            if (isIOS() && !supportIOS) {
              showToast(s.noSupportIOS);
              return;
            }
          }
          onTap();
        },
        child: SizedBox(
          width: 300,
          child: Card(
            elevation: 4,
            child: Padding(
              padding:
                  const EdgeInsets.only(top: 8, left: 16, right: 16, bottom: 8),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: ListTile(
                      title: Text(title),
                      subtitle: Text(subTitle),
                      leading: Icon(iconData),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: buildPlatformRow(supportWindows, supportMac,
                          supportLinux, supportAndroid, supportIOS, supportWeb),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> buildPlatformRow(
      bool supportWindows,
      bool supportMac,
      bool supportLinux,
      bool supportAndroid,
      bool supportIOS,
      bool supportWeb) {
    const double size = 16;
    const Widget marginWidget = SizedBox(width: 8);
    List<Widget> widgets = [];
    if (supportWindows) {
      widgets.add(const Icon(FontAwesome.windows, size: size));
      widgets.add(marginWidget);
    }
    if (supportMac) {
      widgets.add(const Icon(FontAwesome.desktop, size: size));
      widgets.add(marginWidget);
    }
    if (supportLinux) {
      widgets.add(const Icon(FontAwesome.linux, size: size));
      widgets.add(marginWidget);
    }
    if (supportAndroid) {
      widgets.add(const Icon(FontAwesome.android, size: size));
      widgets.add(marginWidget);
    }
    if (supportIOS) {
      widgets.add(const Icon(FontAwesome.apple, size: size));
      widgets.add(marginWidget);
    }
    if (supportWeb) {
      widgets.add(const Icon(FontAwesome.chrome, size: size));
      widgets.add(marginWidget);
    }
    return widgets.sublist(0, widgets.length - 1);
  }
}

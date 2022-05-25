import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:haha_tools/com/josephuszhou/page/android_res_page.dart';
import 'package:haha_tools/com/josephuszhou/page/read_qrcode_page.dart';
import 'package:haha_tools/com/josephuszhou/util/sys_util.dart';
import 'package:oktoast/oktoast.dart';

import '../util/font_util.dart';
import 'generate_qrcode_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildCardItem(context, "Android 资源工具", "复制 Android 多 dpi 资源",
                  Icons.copy_outlined, () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const AndroidResPage()));
              }, supportAndroid: false, supportIOS: false, supportWeb: false),
              buildCardItem(context, "二维码工具", "解析二维码内容", Icons.qr_code, () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ReadQrCodePage()));
              }, supportAndroid: false, supportIOS: false, supportWeb: false),
              buildCardItem(context, "二维码工具", "生成二维码内容", Icons.qr_code, () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const WriteQrCodePage()));
              }, supportAndroid: false, supportIOS: false, supportWeb: false),
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
          if (kIsWeb && !supportWeb) {
            showToast("Not support Web!");
            return;
          }
          if (isWindows() && !supportWindows) {
            showToast("No support Windows!");
            return;
          }
          if (isMacOS() && !supportMac) {
            showToast("No support MacOS!");
            return;
          }
          if (isLinux() && !supportLinux) {
            showToast("No support Linux!");
            return;
          }
          if (isAndroid() && !supportAndroid) {
            showToast("No support Android!");
            return;
          }
          if (isIOS() && !supportIOS) {
            showToast("No support iOS!");
            return;
          }
          onTap;
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
                  const SizedBox(height: 8,),
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

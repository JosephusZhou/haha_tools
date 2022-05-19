import 'package:flutter/material.dart';
import 'package:haha_tools/com/josephuszhou/page/android_res_page.dart';
import 'package:haha_tools/com/josephuszhou/page/read_qrcode_page.dart';

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
              }),
              buildCardItem(context, "二维码工具", "解析二维码内容", Icons.qr_code, () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ReadQrCodePage()));
              }),
              buildCardItem(context, "二维码工具", "生成二维码内容", Icons.qr_code, () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const WriteQrCodePage()));
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildCardItem(BuildContext context, String title, String subTitle,
      IconData iconData, GestureTapCallback onTap) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, top: 16),
      child: GestureDetector(
        onTap: onTap,
        child: SizedBox(
          width: 300,
          height: 100,
          child: Card(
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Align(
                alignment: Alignment.centerLeft,
                child: ListTile(
                  title: Text(title),
                  subtitle: Text(subTitle),
                  leading: Icon(iconData),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class AndroidResPage extends StatefulWidget {
  const AndroidResPage({Key? key}) : super(key: key);

  @override
  State<AndroidResPage> createState() => _AndroidResPageState();
}

class _AndroidResPageState extends State<AndroidResPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          GestureDetector(
            onTap: () => {Navigator.pop(context)},
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: const <Widget>[
                  Icon(Icons.arrow_back_ios_new_rounded),
                  Text("返回", style: TextStyle(fontSize: 16)),
                ],
              ),
            ),
          ),
          /*const Text(
            "将图片复制到剪贴板，点击按钮进行解析",
            style: TextStyle(fontSize: 14, color: Colors.black),
          ),
          Padding(
              padding: const EdgeInsets.all(8),
              child: MaterialButton(
                height: 40,
                color: Colors.blue,
                child: const Text(
                  "解析",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                onPressed: () {
                  readImages();
                },
              )),
          Padding(
            padding: const EdgeInsets.only(top: 16),
            child: Text(_imageContent),
          ),
          _buildQrCodeImage(),*/
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

import '../widget/common_widget.dart';
import '../util/triple_des_util.dart' as triple_des;

class TripleDesPage extends StatefulWidget {
  const TripleDesPage({Key? key}) : super(key: key);

  @override
  State<TripleDesPage> createState() => _TripleDesPageState();
}

class _TripleDesPageState extends State<TripleDesPage> {
  final TextEditingController _keyController = TextEditingController();
  final TextEditingController _ivController = TextEditingController();
  final TextEditingController _encryptController = TextEditingController();
  final TextEditingController _decryptController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    const Widget divMargin = SizedBox(
      width: 16,
      height: 8,
    );

    return Scaffold(
      body: Column(
        children: [
          GestureDetector(
            onTap: () => {Navigator.pop(context)},
            child: backWidget(),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 16, right: 16, top: 8, bottom: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("加密 Key："),
                      divMargin,
                      TextField(
                        controller: _keyController,
                        maxLines: 1,
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(
                            hintText: "请输入内容",
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey))),
                      ),
                      divMargin,
                      const Text("加密 Iv："),
                      TextField(
                        controller: _ivController,
                        maxLines: 1,
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(
                            hintText: "请输入内容",
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey))),
                      ),
                      divMargin,
                      const Text("明文内容："),
                      TextField(
                        controller: _encryptController,
                        maxLines: null,
                        keyboardType: TextInputType.multiline,
                        decoration: const InputDecoration(
                            hintText: "请输入需要加密的内容",
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey))),
                      ),
                      divMargin,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            flex: 1,
                            child: MaterialButton(
                              height: 50,
                              color: Colors.blue,
                              onPressed: encrypt,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Text(
                                    "加密",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 16),
                                  ),
                                  Icon(
                                    Icons.arrow_downward,
                                    color: Colors.white,
                                  )
                                ],
                              ),
                            ),
                          ),
                          divMargin,
                          Expanded(
                            flex: 1,
                            child: MaterialButton(
                              height: 50,
                              color: Colors.blue,
                              onPressed: decrypt,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Text(
                                    "解密",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 16),
                                  ),
                                  Icon(
                                    Icons.arrow_upward,
                                    color: Colors.white,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      divMargin,
                      const Text("密文内容："),
                      TextField(
                        controller: _decryptController,
                        maxLines: null,
                        keyboardType: TextInputType.multiline,
                        decoration: const InputDecoration(
                            hintText: "请输入需要解密的内容",
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey))),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void encrypt() {
    var key = _keyController.text;
    var iv = _ivController.text;
    var content = _encryptController.text;
    String? encryptText = triple_des.encrypt(content, key, iv);
    if (encryptText != null) {
      setState(() {
        _decryptController.text = encryptText;
      });
    }
  }

  void decrypt() {
    var key = _keyController.text;
    var iv = _ivController.text;
    var content = _decryptController.text;
    String? decryptText = triple_des.decrypt(content, key, iv);
    if (decryptText != null) {
      setState(() {
        _encryptController.text = decryptText;
      });
    }
  }
}

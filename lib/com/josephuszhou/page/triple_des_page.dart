import 'package:flutter/material.dart';
import 'package:haha_tools/com/josephuszhou/util/config_util.dart';
import 'package:oktoast/oktoast.dart';

import '../entity/config_entity.dart';
import '../util/triple_des_util.dart' as triple_des;
import '../widget/common_widget.dart';

class TripleDesPage extends StatefulWidget {
  const TripleDesPage({Key? key}) : super(key: key);

  @override
  State<TripleDesPage> createState() => _TripleDesPageState();
}

class _TripleDesPageState extends State<TripleDesPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _keyController = TextEditingController();
  final TextEditingController _ivController = TextEditingController();
  final TextEditingController _encryptController = TextEditingController();
  final TextEditingController _decryptController = TextEditingController();

  final List<TripleDesConfigEntity> _configList = AppConfig().readTripleDesConfig();

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
                      const Text("快捷选择已保存的加密参数："),
                      divMargin,
                      buildSaved3DesConfigWidget(),
                      divMargin,
                      const Text("保存加密参数的名称："),
                      divMargin,
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: _nameController,
                              maxLines: 1,
                              keyboardType: TextInputType.text,
                              decoration: const InputDecoration(
                                  hintText: "如果需要保存加密参数，请输入名称",
                                  border: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.grey))),
                            ),
                          ),
                          divMargin,
                          MaterialButton(
                            height: 50,
                            color: Colors.blue,
                            onPressed: saveKeyIv,
                            child: const Text(
                              "保存",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            ),
                          ),
                        ],
                      ),
                      divMargin,
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

  Widget buildSaved3DesConfigWidget() {
    return Wrap(
      children: List.from(_configList.map((e) => Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Stack(
                children: [
                  GestureDetector(
                    onTap: () {
                      selectKeyIv(e);
                    },
                    child: Container(
                      margin: const EdgeInsets.only(top: 8, right: 10),
                      decoration: const BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.all(
                          Radius.circular(12),
                        ),
                      ),
                      padding: const EdgeInsets.only(
                          left: 8, right: 8, top: 4, bottom: 4),
                      child: Text(
                        e.name,
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  Positioned(
                      right: 1,
                      child: GestureDetector(
                        onTap: () {
                          removeKeyIv(e.name);
                        },
                        child: const Icon(
                          Icons.remove_circle,
                          size: 20,
                        ),
                      )),
                ],
              ),
            ],
          ))),
    );
  }

  void saveKeyIv() {
    var name = _nameController.text;
    var key = _keyController.text;
    var iv = _ivController.text;

    if (key.isEmpty || iv.isEmpty || name.isEmpty) {
      showToast("名称和参数不能为空");
      return;
    }

    bool exist = false;
    for (var element in _configList) {
      if (element.name == name) {
        exist = true;
        element.key = key;
        element.iv = iv;
        break;
      }
    }

    if (!exist) {
      setState(() {
        _configList.add(TripleDesConfigEntity(name, key, iv));
      });
    }

    AppConfig().writeTripleDesConfig(_configList);
  }

  void removeKeyIv(String name) {
    var i = 0;
    for (; i < _configList.length; i++) {
      if (_configList[i].name == name) {
        break;
      }
    }

    setState(() {
      _configList.removeAt(i);
    });

    AppConfig().writeTripleDesConfig(_configList);
  }

  void selectKeyIv(TripleDesConfigEntity entity) {
    _nameController.text = entity.name;
    _keyController.text = entity.key;
    _ivController.text = entity.iv;
  }

  void encrypt() {
    var key = _keyController.text;
    var iv = _ivController.text;
    var content = _encryptController.text;

    if (key.isEmpty || iv.isEmpty || content.isEmpty) {
      showToast("参数和内容不能为空");
      return;
    }

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

    if (key.isEmpty || iv.isEmpty || content.isEmpty) {
      showToast("参数和内容不能为空");
      return;
    }

    String? decryptText = triple_des.decrypt(content, key, iv);
    if (decryptText != null) {
      setState(() {
        _encryptController.text = decryptText;
      });
    }
  }
}

import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:sm_crypto/sm_crypto.dart';

import '../base/base_state.dart';
import '../entity/config_entity.dart';
import '../style/widget_style.dart' as style;
import '../util/config_util.dart';
import '../util/triple_des_util.dart' as triple_des;
import '../widget/common_widget.dart';

class SMDesPage extends StatefulWidget {
  const SMDesPage({Key? key}) : super(key: key);

  @override
  State<SMDesPage> createState() => _SMDesPageState();
}

class _SMDesPageState extends BaseState<SMDesPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _keyController = TextEditingController();
  final TextEditingController _ivController = TextEditingController();
  final TextEditingController _encryptController = TextEditingController();
  final TextEditingController _decryptController = TextEditingController();

  final List<TripleDesConfigEntity> _configList =
      AppConfig().readTripleDesConfig();

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
            child: backWidget(context),
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
                      Text(s.quickSelectEnParams),
                      divMargin,
                      buildSaved3DesConfigWidget(),
                      divMargin,
                      Text(s.savedEnParamsName),
                      divMargin,
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: _nameController,
                              maxLines: 1,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                hintText: s.ifNeedPlzInputName,
                                border: style.inputBorder,
                              ),
                            ),
                          ),
                          divMargin,
                          MaterialButton(
                            height: 50,
                            color: Colors.blue,
                            onPressed: saveKeyIv,
                            child: Text(
                              s.save,
                              style: style.btnTextStyle,
                            ),
                          ),
                        ],
                      ),
                      divMargin,
                      Text(s.enKey),
                      divMargin,
                      TextField(
                        controller: _keyController,
                        maxLines: 1,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                            hintText: s.plzInputContent,
                            border: style.inputBorder),
                      ),
                      divMargin,
                      Text(s.enIv),
                      TextField(
                        controller: _ivController,
                        maxLines: 1,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                            hintText: s.plzInputContent,
                            border: style.inputBorder),
                      ),
                      divMargin,
                      Text(s.plainText),
                      TextField(
                        controller: _encryptController,
                        maxLines: null,
                        keyboardType: TextInputType.multiline,
                        decoration: InputDecoration(
                            hintText: s.plzInputNeedEnContent,
                            border: style.inputBorder),
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
                                children: [
                                  Text(
                                    s.encrypt,
                                    style: style.btnTextStyle,
                                  ),
                                  const Icon(
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
                                children: [
                                  Text(
                                    s.decrypt,
                                    style: style.btnTextStyle,
                                  ),
                                  const Icon(
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
                      Text(s.cipherText),
                      TextField(
                        controller: _decryptController,
                        maxLines: null,
                        keyboardType: TextInputType.multiline,
                        decoration: InputDecoration(
                            hintText: s.plzInputNeedDeContent,
                            border: style.inputBorder),
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
      showToast(s.nameAndParamsNotEmpty);
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
      showToast(s.paramsAndContentNotEmpty);
      return;
    }

    String hexKey = SM4.createHexKey(key: key);
    String hexIv = SM4.createHexKey(key: iv);
    String cbcEncryptData = SM4.encrypt(data: content, key: hexKey, mode: SM4CryptoMode.CBC, iv: hexIv);
    setState(() {
      _decryptController.text = cbcEncryptData;
    });
  }

  void decrypt() {
    var key = _keyController.text;
    var iv = _ivController.text;
    var content = _decryptController.text;

    if (key.isEmpty || iv.isEmpty || content.isEmpty) {
      showToast(s.paramsAndContentNotEmpty);
      return;
    }

    String hexKey = SM4.createHexKey(key: key);
    String hexIv = SM4.createHexKey(key: iv);
    String cbcDecryptData = SM4.decrypt(data: content, key: hexKey, mode: SM4CryptoMode.CBC, iv: hexIv);
    setState(() {
      _encryptController.text = cbcDecryptData;
    });
  }
}

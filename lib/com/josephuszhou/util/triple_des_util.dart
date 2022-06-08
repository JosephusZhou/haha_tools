import 'dart:convert';

import 'package:convert/convert.dart';
import 'package:dart_des/dart_des.dart';

import 'log_util.dart';

String? encrypt(String text, String key, String iv) {
  try {
    DES3 des3CBC = DES3(
        key: key.codeUnits,
        mode: DESMode.CBC,
        paddingType: DESPaddingType.PKCS5,
        iv: iv.codeUnits);
    var encrypted = hex.encode(des3CBC.encrypt(utf8.encode(text)));
    dLog(encrypted);
    return encrypted;
  } catch (e) {
    dLog(e);
  }
  return null;
}

String? decrypt(String text, String key, String iv) {
  try {
    DES3 des3CBC = DES3(
        key: key.codeUnits,
        mode: DESMode.CBC,
        paddingType: DESPaddingType.PKCS5,
        iv: iv.codeUnits);
    var decrypted = utf8.decode(des3CBC.decrypt(hex.decode(text)));
    dLog(decrypted);
    return decrypted;
  } catch (e) {
    dLog(e);
  }
  return null;
}

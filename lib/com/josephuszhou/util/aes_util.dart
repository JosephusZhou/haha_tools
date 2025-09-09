import 'package:encrypt/encrypt.dart';

import 'log_util.dart';

String? encrypt(String text, String base64Key, String base64Iv) {
  try {
    final key = Key.fromBase64(base64Key);
    final iv = IV.fromBase64(base64Iv);
    final encrypter = Encrypter(AES(key, mode: AESMode.cbc));
    final encrypted = encrypter.encrypt(text, iv: iv).base16;
    dLog(encrypted);
    return encrypted;
  } catch (e) {
    dLog(e);
  }
  return null;
}

String? decrypt(String text, String base64Key, String base64Iv) {
  try {
    final key = Key.fromBase64(base64Key);
    final iv = IV.fromBase64(base64Iv);
    final encrypter = Encrypter(AES(key, mode: AESMode.cbc));
    final decrypted = encrypter.decrypt16(text, iv: iv);
    dLog(decrypted);
    return decrypted;
  } catch (e) {
    dLog(e);
  }
  return null;
}

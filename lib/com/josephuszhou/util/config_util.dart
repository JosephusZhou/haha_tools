import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:haha_tools/com/josephuszhou/entity/config_entity.dart';
import 'package:haha_tools/com/josephuszhou/util/log_util.dart';
import 'package:path/path.dart' as p;

class AppConfig {
  static final AppConfig _instance = AppConfig._internal();

  factory AppConfig() {
    return _instance;
  }

  AppConfig._internal();

  late AppConfigEntity _appConfig;

  File? file;

  void loadConfig() async {
    if (kIsWeb) {
      return;
    }

    String? path;
    switch (Platform.operatingSystem) {
      case 'linux':
      case 'macos':
        path = Platform.environment['HOME'];
        break;
      case 'windows':
        path = Platform.environment['USERPROFILE'];
        break;
      case 'android':
      case 'ios':
      default:
        break;
    }

    if (path != null) {
      path = p.join(path, ".hahaTools", "config.json");
      dLog(path);

      file = File(path);
      if (file!.existsSync()) {
        String jsonString = file!.readAsStringSync();
        _appConfig = AppConfigEntity.fromJson(json.decode(jsonString));
      } else {
        file!.createSync(recursive: true);
        file!.writeAsStringSync("{}");
        _appConfig = AppConfigEntity.fromJson(json.decode("{}"));
      }
    } else {
      _appConfig = AppConfigEntity([], "");
    }
  }

  void writeConfig() {
    String newJsonString = json.encode(_appConfig.toJson());
    if (file != null) {
      file!.writeAsStringSync(newJsonString);
    }
  }

  List<TripleDesConfigEntity> readTripleDesConfig() {
    return _appConfig.tripleDesConfigList;
  }

  void writeTripleDesConfig(List<TripleDesConfigEntity> list) {
    _appConfig.tripleDesConfigList = list;
    writeConfig();
  }

  String readAndroidResDir() {
    return _appConfig.androidResDir;
  }

  void writeAndroidResDir(String dir) {
    _appConfig.androidResDir = dir;
    writeConfig();
  }
}

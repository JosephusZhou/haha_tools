import 'dart:io';

import 'package:file_drag_and_drop/drag_container_listener.dart';
import 'package:file_drag_and_drop/file_drag_and_drop_channel.dart';
import 'package:file_drag_and_drop/file_result.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:haha_tools/com/josephuszhou/util/config_util.dart';
import 'package:path/path.dart';

import '../base/base_state.dart';
import '../style/widget_style.dart' as style;
import '../widget/common_widget.dart';

class AndroidResPage extends StatefulWidget {
  const AndroidResPage({Key? key}) : super(key: key);

  @override
  State<AndroidResPage> createState() => _AndroidResPageState();
}

class _AndroidResPageState extends BaseState<AndroidResPage>
    implements DragContainerListener {
  final List<String> _mipDpiList = [
    "mipmap-mdpi",
    "mipmap-hdpi",
    "mipmap-xhdpi",
    "mipmap-xxhdpi",
    "mipmap-xxxhdpi",
  ];

  final List<String> _dpiList = [
    "mdpi",
    "hdpi",
    "xhdpi",
    "xxhdpi",
    "xxxhdpi",
  ];

  String _resDir = AppConfig().readAndroidResDir();

  final List<bool> _dpiSuffix = [true, true, true, true, true];

  String _dayNightSuffix = "";

  String _languageSuffix = "";

  bool _gitAdd = true;

  String _originalFileName = "";

  String _fileSuffix = "";

  List<String> _originalFileList = [];

  final TextEditingController _newFileNameController = TextEditingController();

  String _log = "";

  @override
  Widget build(BuildContext context) {
    const divMargin4 = SizedBox(
      height: 4,
    );
    const divMargin16 = SizedBox(
      height: 16,
    );

    if (_originalFileName.isEmpty) {
      _originalFileName = s.notSelFile;
    }

    return Scaffold(
      body: Column(
        children: [
          GestureDetector(
            onTap: () => {Navigator.pop(context)},
            child: backWidget(context),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.only(
                    left: 16, right: 16, top: 8, bottom: 8),
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      s.selProjResDir,
                      style: style.titleTextStyle,
                    ),
                    divMargin4,
                    Text(s.projResDirDemo),
                    divMargin16,
                    MaterialButton(
                      height: 50,
                      color: Colors.blue,
                      onPressed: selectDir,
                      child: Text(
                        s.selDir,
                        style: style.btnTextStyle,
                      ),
                    ),
                    divMargin4,
                    Text(_resDir),
                    divMargin16,
                    Text(
                      s.selConfigs,
                      style: style.titleTextStyle,
                    ),
                    divMargin4,
                    Text(s.freeCombineConfigs),
                    divMargin16,
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 1,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: buildDpiCheckBoxWidget(divMargin4),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              tagWidget(s.dayNightMode),
                              divMargin4,
                              radioWidget("", _dayNightSuffix, (value) {
                                setState(() {
                                  _dayNightSuffix = value!;
                                });
                              }),
                              divMargin4,
                              radioWidget("night", _dayNightSuffix, (value) {
                                setState(() {
                                  _dayNightSuffix = value!;
                                });
                              }),
                              divMargin4,
                              radioWidget("notnight", _dayNightSuffix, (value) {
                                setState(() {
                                  _dayNightSuffix = value!;
                                });
                              }),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              tagWidget(s.multiLanguage),
                              divMargin4,
                              radioWidget("", _languageSuffix, (value) {
                                setState(() {
                                  _languageSuffix = value!;
                                });
                              }),
                              divMargin4,
                              radioWidget("en", _languageSuffix, (value) {
                                setState(() {
                                  _languageSuffix = value!;
                                });
                              }),
                              divMargin4,
                              radioWidget("zh-rTW", _languageSuffix, (value) {
                                setState(() {
                                  _languageSuffix = value!;
                                });
                              }),
                              divMargin4,
                              radioWidget("ms", _languageSuffix, (value) {
                                setState(() {
                                  _languageSuffix = value!;
                                });
                              }),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              tagWidget(s.addCommand),
                              divMargin4,
                              checkWidget(_gitAdd, "git add", (value) {
                                setState(() {
                                  _gitAdd = value!;
                                });
                              }),
                            ],
                          ),
                        ),
                      ],
                    ),
                    divMargin16,
                    Text(
                      s.selSourceFile,
                      style: style.titleTextStyle,
                    ),
                    divMargin4,
                    Text(s.autoGetDiffDpiSource),
                    divMargin16,
                    GestureDetector(
                      onTap: selectFile,
                      child: Container(
                        constraints: const BoxConstraints(minHeight: 200),
                        decoration: const BoxDecoration(
                          color: Color(0x50999999),
                          borderRadius: BorderRadius.all(
                            Radius.circular(12),
                          ),
                        ),
                        alignment: const Alignment(0, 0),
                        child: buildSelectedFileWidget(),
                      ),
                    ),
                    divMargin16,
                    Row(
                      children: [
                        Text(s.originalFileName),
                        SelectableText(_originalFileName),
                      ],
                    ),
                    divMargin4,
                    Row(
                      children: [
                        Text(s.newFileName),
                        SizedBox(
                          width: 240,
                          height: 36,
                          child: TextField(
                            controller: _newFileNameController,
                            maxLines: 1,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              hintText: s.plzInputNewFileName,
                              border: style.inputBorder,
                              contentPadding: const EdgeInsets.all(8),
                            ),
                            style: const TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        )
                      ],
                    ),
                    divMargin16,
                    MaterialButton(
                      height: 50,
                      color: Colors.blue,
                      onPressed: () {
                        copyFileAndDoCommand(context);
                      },
                      child: Text(
                        s.performAction,
                        style: style.btnTextStyle,
                      ),
                    ),
                    divMargin4,
                    Text(_log),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// 构建 dpi 选择框 UI
  List<Widget> buildDpiCheckBoxWidget(Widget marginWidget) {
    List<Widget> list = [
      tagWidget(s.dpiDir),
    ];
    for (var i = 0; i < _mipDpiList.length; i++) {
      list.add(marginWidget);
      list.add(checkWidget(_dpiSuffix[i], _mipDpiList[i], (value) {
        setState(() {
          _dpiSuffix[i] = value!;
        });
      }));
    }
    return list;
  }

  /// 构建选择的资源文件 UI
  Widget buildSelectedFileWidget() {
    if (_originalFileList.isEmpty) {
      return Text(s.clickToSelOrDragFileHere);
    } else {
      return Column(
        children: _originalFileList.map((e) => Text(e)).toList(),
      );
    }
  }

  /// 选择目录
  void selectDir() async {
    String? dir = await FilePicker.platform.getDirectoryPath();
    if (dir != null) {
      setState(() {
        _resDir = dir;
      });
      AppConfig().writeAndroidResDir(dir);
    }
  }

  /// 选择文件
  void selectFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      String filePath = result.files.single.path!;
      getFiles(filePath);
    } else {
      getFiles(null);
    }
  }

  /// 处理选择的文件
  void getFiles(String? filePath) {
    if (filePath != null) {
      String fileName = basenameWithoutExtension(filePath);
      _fileSuffix = extension(filePath);

      // 获取同级根目录的文件
      String selectedDpi = "";
      for (var mipDpi in _mipDpiList) {
        if (filePath.contains(mipDpi)) {
          selectedDpi = mipDpi;
          break;
        }
      }

      List<String> newList = [];
      for (var mipDpi in _mipDpiList) {
        if (selectedDpi == mipDpi) {
          newList.add(filePath);
        } else {
          String otherFilePath = filePath.replaceAll(selectedDpi, mipDpi);
          File file = File(otherFilePath);
          if (file.existsSync()) {
            newList.add(otherFilePath);
          }
        }
      }

      setState(() {
        _originalFileName = fileName;
        _newFileNameController.text = "";
        _originalFileList = newList;
        _log = "";
      });
    } else {
      setState(() {
        _originalFileName = s.notSelFile;
        _newFileNameController.text = "";
        _originalFileList.clear();
        _log = "";
      });
    }
  }

  /// 复制文件并执行附加命令
  void copyFileAndDoCommand(BuildContext context) async {
    if (_resDir.isEmpty || _originalFileList.isEmpty) {
      return;
    }

    String log = "";
    bool confirmRewrite = false;
    for (var i = 0; i < _mipDpiList.length; i++) {
      var mipDpi = _mipDpiList[i];
      var dpi = _dpiList[i];
      var originalFilePath = "";
      for (var f in _originalFileList) {
        if (f.contains(mipDpi)) {
          originalFilePath = f;
          break;
        }
      }
      if (_dpiSuffix[i] && originalFilePath.isNotEmpty) {
        // mipmap-zh-rTW-night-mdpi
        String dpiDirName = "mipmap";
        if (_languageSuffix.isNotEmpty) {
          dpiDirName += "-$_languageSuffix";
        }
        if (_dayNightSuffix.isNotEmpty) {
          dpiDirName += "-$_dayNightSuffix";
        }
        dpiDirName += "-$dpi";

        String fileName = _newFileNameController.text.isNotEmpty
            ? _newFileNameController.text
            : _originalFileName;

        String newFilePath = join(_resDir, dpiDirName, fileName + _fileSuffix);

        bool copyTo = true;

        // 存在同名文件弹窗提示，但只提示一次
        if (!confirmRewrite) {
          File newFile = File(newFilePath);
          if (newFile.existsSync()) {
            bool? result = await showReWriteConfirmDialog(context);
            copyTo = result ?? false;
          }
        }

        if (copyTo) {
          confirmRewrite = true;
          File file = File(originalFilePath);
          await file.copy(newFilePath);
          log += "${s.copyTo}$newFilePath\n";
        }
      }
    }

    if (log.isNotEmpty) {
      if (_gitAdd) {
        await Process.run("bash", ["-c", "cd $_resDir && git add *"]);
        log += "git add *";
      }
      setState(() {
        _log = log;
      });
    }
  }

  /// 显示确认对话框
  Future<bool?> showReWriteConfirmDialog(BuildContext context) {
    return showDialog(context: context, builder: (context) {
      return AlertDialog(
        title: Text(s.warning),
        content: Text(s.rewriteWarningTips),
        actions: <Widget>[
          TextButton(
            child: Text(s.cancel),
            onPressed: () => Navigator.of(context).pop(),
          ),
          TextButton(
            child: Text(s.confirm),
            onPressed: () {
              Navigator.of(context).pop(true);
            },
          ),
        ],
      );
    });
  }

  @override
  void initState() {
    super.initState();
    dragAndDropChannel.addListener(this);
  }

  @override
  void dispose() {
    dragAndDropChannel.removeListener(this);
    super.dispose();
  }

  @override
  void draggingFileEntered() {
  }

  @override
  void draggingFileExit() {
  }

  @override
  void performDragFileOperation(List<DragFileResult> fileResults) {
    if (fileResults.isNotEmpty) {
      DragFileResult result = fileResults[0];
        String filePath = result.path;
        getFiles(filePath);
      } else {
        getFiles(null);
      }
    }

    @override
    void prepareForDragFileOperation() {
    }
  }

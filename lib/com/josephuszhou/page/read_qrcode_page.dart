import 'dart:typed_data';

import 'package:buffer_image/buffer_image.dart';
import 'package:flutter/material.dart';
import 'package:pasteboard/pasteboard.dart';

import '../base/base_state.dart';
import '../util/log_util.dart';
import '../util/qrcode_util.dart';
import '../widget/common_widget.dart';
import '../style/widget_style.dart' as style;

class ReadQrCodePage extends StatefulWidget {
  const ReadQrCodePage({Key? key}) : super(key: key);

  @override
  State<ReadQrCodePage> createState() => _ReadQrCodePageState();
}

class _ReadQrCodePageState extends BaseState<ReadQrCodePage> {

  String _imageContent = "";

  Uint8List? _imageBytes;

  @override
  Widget build(BuildContext context) {
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
                child: Column(
                  children: [
                    Text(
                      s.copyImageAndParse,
                      style: const TextStyle(fontSize: 14, color: Colors.black),
                    ),
                    Padding(
                        padding: const EdgeInsets.all(8),
                        child: MaterialButton(
                          height: 40,
                          color: Colors.blue,
                          child: Text(
                            s.parse,
                            style: style.btnTextStyle,
                          ),
                          onPressed: () {
                            readImages();
                          },
                        )),
                    Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: SelectableText(_imageContent),
                    ),
                    _buildQrCodeImage(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQrCodeImage() {
    if (_imageBytes != null) {
      return Padding(
        padding: const EdgeInsets.only(top: 16),
        child: SizedBox(
          width: 300,
          height: 300,
          child: Image.memory(_imageBytes!),
        ),
      );
    } else {
      return const Padding(
        padding: EdgeInsets.only(top: 16),
      );
    }
  }

  Future<void> readImages() async {
    final bytes = await Pasteboard.image;
    dLog("Read image bytes length: ${bytes?.length}");
    setState(() {
      _imageBytes = bytes;
    });
    var hasResult = false;
    if (bytes != null) {
      BufferImage? image = await BufferImage.fromFile(bytes);
      if (image != null) {
        var results =
            await decodeImageInIsolate(image.buffer, image.width, image.height);
        dLog(results);
        if (results != null) {
          hasResult = true;
          setState(() {
            _imageContent = results[0].text;
          });
        }
      }
    }
    if (!hasResult) {
      setState(() {
        _imageContent = s.noQrCodeFound;
      });
    }
  }
}

import 'dart:async';
import 'dart:isolate';
import 'dart:typed_data';

import 'package:buffer_image/buffer_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:zxing_lib/common.dart';
import 'package:zxing_lib/multi.dart';
import 'package:zxing_lib/qrcode.dart';
import 'package:zxing_lib/zxing.dart';

import '../style/qrcode_style.dart';
import 'log_util.dart';

Future<bool?> alert<bool>(BuildContext context, String message,
    {String? title, List<Widget>? actions}) {
  return showCupertinoDialog<bool>(
    context: context,
    barrierDismissible: true,
    builder: (context) {
      return Align(
        alignment: Alignment.center,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 200, horizontal: 50),
          child: CupertinoAlertDialog(
            title: title == null ? null : Text(title),
            content: Column(
              children: message
                  .split(RegExp("[\r\n]+"))
                  .map<Widget>((row) => Text(row))
                  .toList(),
            ),
            actions: actions ??
                [
                  CupertinoButton(
                    child: const Text('OK'),
                    onPressed: () {
                      Navigator.pop(context, true);
                    },
                  )
                ],
          ),
        ),
      );
    },
  );
}

class IsoMessage {
  final SendPort? sendPort;
  final Uint8List byteData;
  final int width;
  final int height;

  IsoMessage(this.sendPort, this.byteData, this.width, this.height);
}

Future<List<Result>?> decodeImageInIsolate(
    Uint8List image, int width, int height,
    {bool isRgb = true}) async {
  if (kIsWeb) {
    return isRgb
        ? decodeImage(IsoMessage(null, image, width, height))
        : decodeCamera(IsoMessage(null, image, width, height));
  }
  var complete = Completer<List<Result>?>();
  var port = ReceivePort();
  port.listen((message) {
    dLog("onData: $message");
    if (!complete.isCompleted) {
      complete.complete(message as List<Result>?);
    }
  }, onDone: () {
    dLog('iso close');
  }, onError: (error) {
    dLog('iso error: $error');
  });

  IsoMessage message = IsoMessage(port.sendPort, image, width, height);
  if (isRgb) {
    Isolate.spawn<IsoMessage>(decodeImage, message, debugName: "decodeImage");
  } else {
    Isolate.spawn<IsoMessage>(decodeCamera, message, debugName: "decodeCamera");
  }

  return complete.future;
}

Uint8List color2Uint(int color) {
  return Uint8List.fromList([
    color >> 16 & 0xff,
    color >> 8 & 0xff,
    color & 0xff,
    color >> 16 & 0xff
  ]);
}

int getColor(int r, int g, int b, [int a = 255]) {
  return (r << 16) + (g << 8) + b + (a << 24);
}

int getColorFromByte(List<int> byte, int index, {bool isLog = false}) {
  return getColor(
      byte[index], byte[index + 1], byte[index + 2], byte[index + 3]);
}

List<Result>? decodeImage(IsoMessage message) {
  int length = message.byteData.length;

  var pixels = List<int>.generate(
      length ~/ 4, (index) => getColorFromByte(message.byteData, index * 4));

  LuminanceSource imageSource =
      RGBLuminanceSource(message.width, message.height, pixels);

  BinaryBitmap bitmap = BinaryBitmap(HybridBinarizer(imageSource));

  MultipleBarcodeReader reader =
      GenericMultipleBarcodeReader(MultiFormatReader());
  try {
    dLog('start decode...');
    var results = reader.decodeMultiple(bitmap,
        {DecodeHintType.TRY_HARDER: true, DecodeHintType.ALSO_INVERTED: true});

    message.sendPort?.send(results);
    return results;
  } on NotFoundException catch (_) {
    dLog(_);
    message.sendPort?.send(null);
  }
  return null;
}

List<Result>? decodeCamera(IsoMessage message) {
  var yuvData = Int8List.fromList(message.byteData);

  LuminanceSource imageSource =
      PlanarYUVLuminanceSource(yuvData, message.width, message.height);

  BinaryBitmap bitmap = BinaryBitmap(HybridBinarizer(imageSource));

  MultipleBarcodeReader reader =
      GenericMultipleBarcodeReader(MultiFormatReader());
  try {
    var results = reader.decodeMultiple(bitmap,
        {DecodeHintType.TRY_HARDER: true, DecodeHintType.ALSO_INVERTED: true});
    message.sendPort?.send(results);
    return results;
  } on NotFoundException catch (_) {}
  return null;
}

Future<BufferImage> createQrcode(String content,
    {int pixelSize = 0,
    Color bgColor = Colors.white,
    Color color = Colors.black}) async {
  QRCodeStyle style = QRCodeStyle.normal;
  QRCode code = Encoder.encode(content);
  dLog(content);
  ByteMatrix matrix = code.matrix!;
  if (pixelSize < 1) {
    pixelSize = 350 ~/ matrix.width;
  }
  BufferImage image = BufferImage(matrix.width * pixelSize + pixelSize * 2,
      matrix.height * pixelSize + pixelSize * 2);
  image.drawRect(
      Rect.fromLTWH(0, 0, image.width.toDouble(), image.height.toDouble()),
      bgColor);
  BufferImage? blackImage = await style.blackBlock(pixelSize);
  BufferImage? whiteImage = await style.whiteBlock(pixelSize);
  for (int x = 0; x < matrix.width; x++) {
    for (int y = 0; y < matrix.height; y++) {
      if (matrix.get(x, y) == 1) {
        if (blackImage != null) {
          image.drawImage(
            blackImage,
            Offset(
              (pixelSize + x * pixelSize).toDouble(),
              (pixelSize + y * pixelSize).toDouble(),
            ),
          );
        }
      } else if (whiteImage != null) {
        image.drawImage(
          whiteImage,
          Offset(
            (pixelSize + x * pixelSize).toDouble(),
            (pixelSize + y * pixelSize).toDouble(),
          ),
        );
      }
    }
  }
  return image;
}

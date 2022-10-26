import 'dart:math';

import 'package:flutter/material.dart';
import 'package:haha_tools/com/josephuszhou/widget/kline/kline_config.dart';

import '../../util/log_util.dart';
import 'kline_entity.dart';

class KLinePainter extends CustomPainter {

  final KLineConfig config;

  final List<KLineEntity> dataList;

  double scrollX = 0.0;

  late double maxValue;

  late double minValue;

  late int leftIndex;

  late int rightIndex;

  late Paint candlePaint;

  late TextPainter textPainter;

  KLinePainter(this.config, this.dataList) {
    candlePaint = Paint()
      ..isAntiAlias = true
      ..style = PaintingStyle.fill;

    textPainter = TextPainter();
  }

  void reset() {
    maxValue = double.minPositive;
    minValue = double.maxFinite;
    leftIndex = 0;
    rightIndex = 0;
  }

  void calculate(Size size) {
    reset();

    int count = size.width ~/ config.itemWidth;

    leftIndex = 0;
    if (count >= dataList.length) {
      rightIndex = dataList.length - 1;
    } else {
      rightIndex = count;
    }

    for (int i = leftIndex; i <= rightIndex; i++) {
      var data = dataList[i];
      maxValue = max(data.high, maxValue);
      minValue = min(data.low, minValue);
    }

    var more = (maxValue - minValue) / 10;
    maxValue += more;
    minValue -= more;
  }

  double getX(int index) {
    return config.itemWidth * (index + 1) - config.itemWidth / 2;
  }

  double getY(double value) {
    var h = config.mainDrawHeight / (maxValue - minValue);
    return config.topPadding + h * (maxValue - value);
  }

  @override
  void paint(Canvas canvas, Size size) {
    dLog("KLineView: KlinePainter->paint");
    calculate(size);

    for (int i = leftIndex; i <= rightIndex; i++) {
      var item = dataList[i];
      if (item.close <= item.open) {
        candlePaint.color = config.downColor;
      } else {
        candlePaint.color = config.upColor;
      }

      var x = getX(i);
      var openY = getY(item.open);
      var closeY = getY(item.close);
      if (openY == closeY) {
        closeY = openY + 0.5;
      } else if (closeY > openY && closeY - openY < 0.5) {
        closeY = openY + 0.5;
      } else if (openY > closeY && openY - closeY < 0.5) {
        closeY = openY - 0.5;
      }
      Rect rect = Rect.fromLTRB(
          x - config.candleWidth / 2,
          openY,
          x + config.candleWidth / 2,
          closeY);
      canvas.drawRect(rect, candlePaint);

      rect = Rect.fromLTRB(
          x - config.candleLineWidth / 2,
          getY(item.high),
          x + config.candleLineWidth / 2,
          getY(item.low));
      canvas.drawRect(rect, candlePaint);
    }

    textPainter
      ..text = TextSpan(
          text: maxValue.toString(),
          style: const TextStyle(fontSize: 12.0, color: Colors.black))
      ..textDirection = TextDirection.rtl
      ..layout(maxWidth: size.width, minWidth: size.width)
      ..paint(canvas, Offset(-config.textMargin, config.topPadding + config.textMargin));

    textPainter
      ..text = TextSpan(
          text: minValue.toString(),
          style: const TextStyle(fontSize: 12.0, color: Colors.black))
      ..textDirection = TextDirection.rtl
      ..layout(maxWidth: size.width, minWidth: size.width)
      ..paint(canvas, Offset(-config.textMargin, config.topPadding + config.mainDrawHeight - textPainter.size.height - config.textMargin));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    if ((oldDelegate as KLinePainter).config == config &&
        oldDelegate.dataList == dataList) {
      dLog("KLineView: KLinePainter->not repaint");
      return false;
    }
    dLog("KLineView: KLinePainter->repaint");
    return true;
  }
}

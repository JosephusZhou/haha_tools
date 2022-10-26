import 'package:flutter/material.dart';
import 'package:haha_tools/com/josephuszhou/util/log_util.dart';

import 'kline_config.dart';

/// K 线图背景图
class KLineBgPainter extends CustomPainter {

  final KLineConfig config;

  late Paint _bgPaint;

  late Paint _gridLinePaint;

  KLineBgPainter(this.config) {
    _bgPaint = Paint()
      ..isAntiAlias = true
      ..style = PaintingStyle.fill
      ..color = config.bgColor;

    _gridLinePaint = Paint()
      ..isAntiAlias = true
      ..style = PaintingStyle.fill
      ..color = config.gridLineColor
      ..strokeWidth = config.gridLineWidth;
  }

  @override
  void paint(Canvas canvas, Size size) {
    dLog("KLineView: BgPainter->paint");
    Rect rect = Offset.zero & size;
    canvas.drawRect(rect, _bgPaint);

    double y;
    var rowHeight = (config.topPadding + config.mainDrawHeight) / config.row;
    for (int i = 1; i <= config.row; i ++) {
      y = i * rowHeight;
      canvas.drawLine(Offset(0, y), Offset(config.width, y), _gridLinePaint);
    }

    y = config.height - config.bottomPadding;
    canvas.drawLine(Offset(0, y), Offset(config.width, y), _gridLinePaint);

    var columnWidth = config.width / config.column;
    for (int i = 1; i < config.column; i ++) {
      double x = i * columnWidth;
      canvas.drawLine(Offset(x, 0), Offset(x, config.height - config.bottomPadding), _gridLinePaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    if ((oldDelegate as KLineBgPainter).config == config) {
      dLog("KLineView: BgPainter->not repaint");
      return false;
    }
    dLog("KLineView: BgPainter->repaint");
    return true;
  }
}
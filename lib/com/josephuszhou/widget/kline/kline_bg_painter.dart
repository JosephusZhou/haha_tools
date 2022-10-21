import 'package:flutter/material.dart';

import 'kline_view_config.dart';

/// K 线图背景图
class KLineBgPainter extends CustomPainter {

  final KLineViewConfig config;

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
      ..color = config.gridLineColor;
  }

  @override
  void paint(Canvas canvas, Size size) {
    Rect rect = Offset.zero & size;
    canvas.drawRect(rect, _bgPaint);


  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
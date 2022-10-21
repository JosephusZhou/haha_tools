import 'package:flutter/material.dart';

class KLineViewConfig {

  // 网格行数
  int row = 4;

  // 网格列数
  int column = 4;

  // 实时线、指标线的绘制宽度
  double lineWidth = 1;

  // 每个点的计算宽度
  double itemWidth = 10;

  // 每个蜡烛的绘制宽度
  double candleWidth = 8;

  // 每个蜡烛的影线的绘制宽度
  double candleLineWidth = 1;

  // 网格线宽度
  double gridLineWidth = 0.7;

  // 文字
  double textSize = 12;

  // 涨色
  Color upColor = const Color(0xFFFB6669);

  // 跌色
  Color downColor = const Color(0xFF16BB94);

  // 文字颜色
  Color textColor = const Color(0xFF666666);

  // 文字颜色 2，用于深色背景上的文字
  Color textColor2 = const Color(0xFFFFFFFF);

  // 背景颜色
  Color bgColor = const Color(0xFFDDDDDD);

  // 网格线颜色
  Color gridLineColor = const Color(0xFFCCCCCC);

  // 选中后十字线的颜色
  Color selectLineColor = const Color(0xFFFB5B39);

  // 指标线颜色1
  Color indexColor1 = const Color(0xFF39B0E8);

  // 指标线颜色2
  Color indexColor2 = const Color(0xFFDA8AE5);

  // 指标线颜色3
  Color indexColor3 = const Color(0xFF61D100);

  // 指标线颜色4
  Color indexColor4 = const Color(0xFFF6DC03);

}
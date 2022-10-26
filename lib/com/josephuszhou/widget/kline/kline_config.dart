import 'package:flutter/material.dart';

class KLineConfig {

  // k 线图宽度
  double width = 1080;

  // k 线图高度
  double height = 600;

  // 上边距，位于主图之上，用于显示指标数据
  double topPadding = 20;

  // 下边距，位于副图之下，用于显示时间
  double bottomPadding = 20;

  // 文字边距，防止贴边
  double textMargin = 4;

  // 主图、副图比例
  double mainDrawProp = 0.7;

  // 是否显示副图
  bool showSubDraw = true;

  // 主图高度，通过计算得出
  double _mainDrawHeight = -1;

  // 副图高度，通过计算得出
  double _subDrawHeight = -1;

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
  Color upColor = const Color(0xFFEF383C);

  // 跌色
  Color downColor = const Color(0xFF0D9172);

  // 文字颜色
  Color textColor = const Color(0xFF666666);

  // 文字颜色 2，用于深色背景上的文字
  Color textColor2 = const Color(0xFFFFFFFF);

  // 背景颜色
  Color bgColor = const Color(0xFFEEEEEE);

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

  // 返回主图高度
  double get mainDrawHeight {
    if (_mainDrawHeight < 0) {
      _calculateSize();
    }
    return _mainDrawHeight;
  }

  // 返回副图高度
  double get subDrawHeight {
    if (_subDrawHeight < 0) {
      _calculateSize();
    }
    return _subDrawHeight;
  }

  /// 计算 K 线图各区域高度
  void _calculateSize() {
    if (width <= 0 || height <= 0 || topPadding <= 0 || bottomPadding <= 0 || mainDrawProp <= 0) {
      throw Exception("KLineView size error, size should be greater than 0");
    }

    var drawHeight = height - topPadding - bottomPadding;
    if (showSubDraw) {
      _mainDrawHeight = drawHeight * mainDrawProp;
      _subDrawHeight = drawHeight - _mainDrawHeight;
      if (_subDrawHeight <= 0) {
        throw Exception("KLineView's SubDraw size should be greater than 0, if you want to hide the SubDraw, just set showSubDraw = false");
      }
    } else {
      _mainDrawHeight = drawHeight;
      _subDrawHeight = 0;
    }
  }


}
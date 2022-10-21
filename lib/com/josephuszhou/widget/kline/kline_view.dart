import 'package:flutter/widgets.dart';

import 'kline_bg_painter.dart';
import 'kline_entity.dart';
import 'kline_painter.dart';
import 'kline_view_config.dart';

/// K 线图
class KLineView extends StatefulWidget {
  // 配置
  final KLineViewConfig config;

  // 数据
  final List<KLineEntity> dataList;

  const KLineView(
    this.config,
    this.dataList, {
    Key? key,
  }) : super(key: key);

  @override
  State<KLineView> createState() => _KLineViewState();
}

class _KLineViewState extends State<KLineView> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CustomPaint(
          size: Size(MediaQuery.of(context).size.width - 200, 500),
          painter: KLineBgPainter(widget.config),
        ),
        CustomPaint(
          size: Size(MediaQuery.of(context).size.width - 200, 500),
          painter: KLinePainter(widget.config, widget.dataList),
        ),
      ],
    );
  }
}

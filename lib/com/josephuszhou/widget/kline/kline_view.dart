import 'package:flutter/widgets.dart';

import '../../util/log_util.dart';
import 'kline_bg_painter.dart';
import 'kline_entity.dart';
import 'kline_painter.dart';
import 'kline_config.dart';

/// K 线图
class KLineView extends StatefulWidget {

  // 配置
  final KLineConfig config;

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
    return GestureDetector(
        child: ClipRect(
            child: Stack(
      children: [
        CustomPaint(
          size: Size(widget.config.width, widget.config.height),
          painter: KLineBgPainter(widget.config),
        ),
        CustomPaint(
          size: Size(widget.config.width, widget.config.height),
          painter: KLinePainter(widget.config, widget.dataList),
        ),
      ],
    )),
    onHorizontalDragStart: (details) {
      dLog("aaaa");
    },);
  }
}

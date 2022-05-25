import 'package:flutter/widgets.dart';

/// 修正不同手机上leading和不居中的问题
class VCenterText extends StatelessWidget {
  final String data; // 展示文案
  final TextStyle style; // 文字样式 由于字体大小和颜色是必须的 所以此处为必穿参数
  final int maxLines; //最大行数
  final double height; // 文本高度 默认1.1更居中 但随着字体变大 这个值应该趋于1.0 允许手动调节
  final TextOverflow overflow; //裁剪模式
  final double textMaxWidth; // 文字能显示的最大宽度 如果 为autoFixSize则需要指定该值
  final TextAlign textAlign;

  const VCenterText(
    this.data,
    this.style, {
    Key? key,
    this.maxLines = 1,
    this.height = 1.1,
    this.overflow = TextOverflow.ellipsis,
    this.textMaxWidth = double.infinity,
    this.textAlign = TextAlign.center,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 如果需要修正大小
    return Text(
      data,
      maxLines: maxLines,
      textAlign: textAlign,
      style: style,
      strutStyle: StrutStyle(
        fontSize: style.fontSize,
        fontWeight: style.fontWeight,
        leading: 0,
        height: height,
        // 1.1更居中
        forceStrutHeight: true, // 关键属性 强制改为文字高度
      ),
      textHeightBehavior: const TextHeightBehavior(
          // 基线 发现不设置也能行
          applyHeightToFirstAscent: false,
          applyHeightToLastDescent: false),
    );
  }
}

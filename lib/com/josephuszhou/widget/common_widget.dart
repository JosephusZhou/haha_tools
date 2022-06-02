import 'package:flutter/material.dart';
import 'package:haha_tools/com/josephuszhou/widget/v_center_text.dart';

import '../../../l10n/s.g.dart';

/// 返回按钮
Widget backWidget(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(16),
    child: Row(
      children: <Widget>[
        const Icon(Icons.arrow_back_ios_new_rounded),
        VCenterText(
            S.of(context)!.back, const TextStyle(fontSize: 16, height: 1)),
      ],
    ),
  );
}

/// 标签：带圆角背景文本
Widget tagWidget(String text) {
  return Container(
    padding: const EdgeInsets.only(left: 8, right: 8, top: 4, bottom: 4),
    decoration: const BoxDecoration(
      color: Colors.blue,
      borderRadius: BorderRadius.all(Radius.circular(4)),
    ),
    child: Text(
      text,
      style: const TextStyle(color: Colors.white, fontSize: 12),
    ),
  );
}

/// 勾选框带文字
Widget checkWidget(
    bool checked, String text, ValueChanged<bool?> valueChanged) {
  return Row(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.end,
    children: [
      SizedBox(
        width: 16,
        height: 16,
        child: Checkbox(
          splashRadius: 0,
          value: checked,
          onChanged: valueChanged,
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
      ),
      const SizedBox(
        width: 4,
      ),
      Text(text),
    ],
  );
}

/// 单选框带文字
Widget radioWidget(
    String text, String groupText, ValueChanged<String?> valueChanged) {
  return Row(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.end,
    children: [
      SizedBox(
        width: 16,
        height: 16,
        child: Radio<String>(
          splashRadius: 0,
          value: text,
          groupValue: groupText,
          onChanged: valueChanged,
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
      ),
      const SizedBox(
        width: 4,
      ),
      Text(text),
    ],
  );
}

import 'package:flutter/material.dart';
import 'package:haha_tools/com/josephuszhou/widget/v_center_text.dart';

import '../../../l10n/s.g.dart';

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

import 'package:flutter/material.dart';

import '../../../l10n/s.g.dart';

abstract class BaseState<T extends StatefulWidget> extends State<T> {

  late S s;

  @override
  didChangeDependencies() {
    s = S.of(context)!;
    super.didChangeDependencies();
  }

}
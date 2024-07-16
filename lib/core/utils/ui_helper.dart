import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
abstract class UIHelper {
  static final double _verticalPadding = 10.h;
  static final double _horizontalPadding = 12.w;

  static get pagePadding => EdgeInsets.symmetric(
        vertical: _verticalPadding,
        horizontal: _horizontalPadding,
      );
}

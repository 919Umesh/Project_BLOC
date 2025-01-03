import 'package:flutter/material.dart';

import '../colors.dart';

class ContainerDecoration {
  static decoration({
    Color? color = Colors.white,
    Color? borderColor,
    BorderRadiusGeometry? borderRadius,
    Border? border,
    Gradient? gradient,
    double? radius,
    BoxShape? shape,
  }) {
    return BoxDecoration(
      color: color,
      border: border ?? Border.all(color: borderColor ?? kBorderColor),
      gradient: gradient,
      borderRadius: borderRadius ?? BorderRadius.circular(radius ?? 5.0),
      shape: shape ?? BoxShape.rectangle,
    );
  }
}

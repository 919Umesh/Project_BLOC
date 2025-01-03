import 'package:flutter/material.dart';

extension EmptyPadding on num {
  SizedBox get pHeight => SizedBox(height: toDouble());
  SizedBox get pWidth => SizedBox(width: toDouble());
}

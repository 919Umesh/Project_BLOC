import 'package:flutter/material.dart';

extension TextEditingControllerListExtensions on List<TextEditingController> {
  bool areControllersNotEmpty() {
    return any((controller) => controller.text.isNotEmpty);
  }
}

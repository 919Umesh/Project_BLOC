import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';

import '../../app/app.dart';

extension StringToastExtension on String {
  void successToast({ToastPosition position = ToastPosition.bottom}) {
    showToast(
      this,
      duration: const Duration(seconds: 3),
      position: ToastPosition.bottom,
      backgroundColor: kSuccessColor,
      radius: 13.0,
    );
  }

  void errorToast({ToastPosition position = ToastPosition.bottom}) {
    showToast(
      this,
      duration: const Duration(seconds: 3),
      position: ToastPosition.bottom,
      backgroundColor: kErrorColor,
      radius: 13.0,
    );
  }

  void customToast({
    Duration? duration = const Duration(seconds: 3),
    ToastPosition position = ToastPosition.bottom,
    Color? backgroundColor,
    double? radius = 13.0,
  }) {
    showToast(
      this,
      duration: duration,
      position: position,
      backgroundColor: backgroundColor,
      radius: radius,
    );
  }
}

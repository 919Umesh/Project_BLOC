import 'package:flutter/material.dart';

import '../colors.dart';
import '../textstyle.dart';

class TextFieldDecoration {
  static InputDecoration decoration({
    required String hintText,
    IconData? prefixIcon,
    IconData? suffixIcon,
    Widget? suffix,
    Widget? prefix,
    Color? fillColor,
  }) {
    return InputDecoration(
      prefixIcon: prefixIcon != null ? Icon(prefixIcon, color: kPrimaryColor) : null,
      suffixIcon: suffixIcon != null ? Icon(suffixIcon, color: kPrimaryColor) : null,
      suffix: suffix,
      prefix: prefix,
      fillColor: fillColor ?? kTextFormFieldColor,
      filled: true,
      counter: const Offstage(),
      isDense: true,
      hintText: hintText,
      labelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14.0),
      hintStyle: kHintText,
      contentPadding: const EdgeInsets.all(12.0),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15.0),
        borderSide: BorderSide.none,
      ),
      errorText: null,
      errorStyle: const TextStyle(fontSize: 0.0, color: null),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15.0),
        borderSide: BorderSide.none,
      ),
    );
  }
}

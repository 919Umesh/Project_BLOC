import 'package:flutter/material.dart';

extension PaddingExtension on Widget {
  Widget paddingAll(double value) {
    return Padding(
      padding: EdgeInsets.all(value),
      child: this,
    );
  }

  Widget paddingOnly([double lp = 0, rp = 0, tp = 0, bp = 0]) {
    return Padding(
      padding: EdgeInsets.only(left: lp, right: rp, top: tp, bottom: bp),
      child: this,
    );
  }

  Widget paddingTop([double value = 0]) {
    return Padding(
      padding: EdgeInsets.only(top: value),
      child: this,
    );
  }

  Widget paddingBottom([double value = 0]) {
    return Padding(
      padding: EdgeInsets.only(bottom: value),
      child: this,
    );
  }

  Widget paddingRight([double value = 0]) {
    return Padding(
      padding: EdgeInsets.only(right: value),
      child: this,
    );
  }

  Widget paddingLeft([double value = 0]) {
    return Padding(
      padding: EdgeInsets.only(left: value),
      child: this,
    );
  }

  Widget paddingVertical([double value = 0]) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: value, horizontal: 0.0),
      child: this,
    );
  }

  Widget paddingHorizontal([double value = 0]) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: value),
      child: this,
    );
  }

  Widget paddingSymmetric([double horizontal = 0, double vertical = 0]) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: vertical, horizontal: horizontal),
      child: this,
    );
  }
}

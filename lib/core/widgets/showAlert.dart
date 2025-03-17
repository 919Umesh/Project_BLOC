import 'package:flutter/material.dart';

class ShowAlert {
  final BuildContext context;

  ShowAlert(this.context);

  void alert({required Widget child}) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16), // Rounded corners
          ),
          child: child,
        );
      },
    );
  }
}
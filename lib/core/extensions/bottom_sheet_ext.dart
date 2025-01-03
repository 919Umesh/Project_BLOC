import 'package:flutter/material.dart';
import 'package:project_bloc/core/core.dart';

import '../../app/app.dart';

extension WidgetBottomSheetExtension on BuildContext {
  void showBottomSheet({
    required String title,
    required Widget child,
    double? height,
  }) {
    showModalBottomSheet(
      context: this,
      useSafeArea: true,
      isScrollControlled: true,
      backgroundColor: kPrimaryColor,
      builder: (BuildContext context) {
        return LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            return SizedBox(
              width: double.infinity,
              height: height ?? constraints.maxHeight * 0.85,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    title,
                    style: kWhiteTitleText,
                    textAlign: TextAlign.center,
                  ).paddingAll(8.0).paddingAll(5.0),
                  Flexible(
                    child: Container(
                      color: Colors.white,
                      child: child.paddingAll(15.0),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  void showAlertDialog({
    required String title,
    required Widget child,
    double? height,
    required List<Widget> actions,
  }) {
    showDialog<void>(
      context: this,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: child,
          actions: actions,
        );
      },
    );
    // showModalBottomSheet(
    //   context: this,
    //   useSafeArea: true,
    //   isScrollControlled: true,
    //   backgroundColor: kPrimaryColor,
    //   builder: (BuildContext context) {
    //     return LayoutBuilder(
    //       builder: (BuildContext context, BoxConstraints constraints) {
    //         return SizedBox(
    //           width: double.infinity,
    //           height: height ?? constraints.maxHeight * 0.85,
    //           child: Column(
    //             mainAxisAlignment: MainAxisAlignment.start,
    //             crossAxisAlignment: CrossAxisAlignment.stretch,
    //             mainAxisSize: MainAxisSize.min,
    //             children: [
    //               Text(
    //                 title,
    //                 style: kWhiteTitleText,
    //                 textAlign: TextAlign.center,
    //               ).paddingAll(8.0).paddingAll(5.0),
    //               Flexible(
    //                 child: Container(
    //                   color: Colors.white,
    //                   child: child.paddingAll(15.0),
    //                 ),
    //               ),
    //             ],
    //           ),
    //         );
    //       },
    //     );
    //   },
    // );
  }
}

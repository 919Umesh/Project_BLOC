import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_bloc/core/core.dart';

import '../../app/app.dart';

class LoadingScreen {
  static final LoadingScreen _instance = LoadingScreen._internal();

  factory LoadingScreen() => _instance;

  LoadingScreen._internal();

  Widget show() {
    return SafeArea(
      child: Stack(children: [
        Container(color: Colors.black.withAlpha(100)),
        _loadingContainer(),
      ]),
    );
  }

  Widget _loadingContainer({String text = "Loading"}) {
    return Center(
      child: Container(
        constraints: const BoxConstraints(maxHeight: 100.0, minHeight: 0.0),
        decoration: ContainerDecoration.decoration(
          borderColor: Colors.white,
          borderRadius: BorderRadius.circular(25.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(child: const CupertinoActivityIndicator().paddingAll(8.0)),
            Flexible(
              flex: 2,
              child: Material(
                color: Colors.transparent,
                child: Text(text, style: kMenuTitleText).paddingRight(20.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// child: BlocListener<LoginBloc, LoginState>(
//       listener: (BuildContext context, state) {
//         if (state is LoginLoading) {}
//         if (state is LoginSuccess) {
//           state.message.successToast();
//         }
//         if (state is LoginError) {
//           state.message.errorToast();
//         }
//       },
//       child: BlocBuilder<LoginBloc, LoginState>(
//         builder: (BuildContext context, state) {
//           if (state is LoginLoading) {
//             return loading.show();
//           }
//           return Scaffold(body: LoginFormSection().pSymmetric(10.0, 20.0));
//         },
//       ),
//     ),

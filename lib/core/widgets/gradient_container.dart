import 'package:flutter/material.dart';

class GradientContainer extends StatelessWidget {
  final Widget child;
  final Decoration? decoration;
  const GradientContainer({super.key, required this.child, this.decoration});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: decoration ??
          const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.indigo, Colors.greenAccent],
              begin: FractionalOffset(1.0, 0.0),
              end: FractionalOffset(0.0, 1.0),
              stops: [0.0, 1.0],
              tileMode: TileMode.clamp,
            ),
          ),
      child: child,
    );
  }
}

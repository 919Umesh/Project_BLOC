import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerEffect extends StatelessWidget {
  final double width;
  final double height;
  final double borderRadius;

  const ShimmerEffect({
    super.key,
    this.width = 50,
    this.height = 50,
    this.borderRadius = 4,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.white,
      highlightColor: Colors.red[500]!,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.green,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
    );
  }
}

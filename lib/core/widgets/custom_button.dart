import 'package:flutter/material.dart';

import '../../app/app.dart';
import '../core.dart';

class CustomButton extends StatefulWidget {
  final VoidCallback onTap;
  final double? fontSize;

  final String text;
  final double radius;
  final Color? color, fontColor;
  const CustomButton({
    super.key,
    required this.onTap,
    this.fontSize,
    required this.text,
    this.radius = 15.0,
    this.color,
    this.fontColor,
  });

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final Duration _animationDuration = const Duration(milliseconds: 300);
  final Tween<double> _tween = Tween<double>(begin: 1.0, end: 0.95);
  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: _animationDuration,
    )..addListener(() {
        setState(() {});
      });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _controller.forward().then((_) {
          _controller.reverse();
        });
        widget.onTap();
      },
      child: ScaleTransition(
        scale: _tween.animate(
          CurvedAnimation(
            parent: _controller,
            curve: Curves.easeOut,
            reverseCurve: Curves.easeIn,
          ),
        ),
        child: Container(
          width: double.infinity,
          decoration: ContainerDecoration.decoration(
            color: widget.color ?? kPrimaryColor,
            borderColor: widget.color ?? kPrimaryColor,
            radius: widget.radius,
          ),
          child: Text(
            widget.text,
            style: kButtonText.copyWith(
              fontSize: widget.fontSize,
              color: widget.fontColor,
            ),
            textAlign: TextAlign.center,
          ).paddingAll(11.0),
        ).paddingAll(5.0),
      ),
    );
  }
}

class CustomTextButton extends StatefulWidget {
  final VoidCallback onTap;
  final double? fontSize;
  final String text;
  final Color? fontColor;
  const CustomTextButton({
    super.key,
    required this.onTap,
    this.fontSize,
    required this.text,
    this.fontColor = kPrimaryColor,
  });

  @override
  State<CustomTextButton> createState() => _CustomTextButtonState();
}

class _CustomTextButtonState extends State<CustomTextButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final Duration _animationDuration = const Duration(milliseconds: 300);
  final Tween<double> _tween = Tween<double>(begin: 1.0, end: 0.95);
  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: _animationDuration,
    )..addListener(() {
        setState(() {});
      });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _controller.forward().then((_) {
          _controller.reverse();
        });
        widget.onTap();
      },
      child: ScaleTransition(
        scale: _tween.animate(
          CurvedAnimation(
            parent: _controller,
            curve: Curves.easeOut,
            reverseCurve: Curves.easeIn,
          ),
        ),
        child: Text(
          widget.text,
          style: kButtonText.copyWith(
            fontSize: widget.fontSize,
            color: widget.fontColor,
          ),
          textAlign: TextAlign.center,
        ).paddingAll(8.0),
      ),
    );
  }
}

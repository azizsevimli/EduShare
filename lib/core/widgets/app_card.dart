import 'package:flutter/material.dart';
import '../constants/constants.dart';

class AppCard extends StatelessWidget {
  final Widget child;
  final double width;
  final double? height;
  final double? padding;
  final Color? color;
  final Color? borderColor;
  final double? borderRadius;
  final double? borderWidth;
  final Color? shadowColor;
  final double? blurRadius;

  const AppCard({
    super.key,
    required this.child,
    required this.width,
    this.height,
    this.padding,
    this.color,
    this.borderColor,
    this.borderRadius,
    this.borderWidth,
    this.shadowColor,
    this.blurRadius,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: EdgeInsets.all(padding ?? 10.0),
      decoration: BoxDecoration(
        color: color ?? AppColors.white,
        borderRadius: BorderRadius.circular(borderRadius ?? 15.0),
        border: Border.all(
          width: borderWidth ?? 0.5,
          color: borderColor ?? AppColors.lightPeriwinkle,
        ),
        boxShadow: [
          BoxShadow(
            color: shadowColor ?? AppColors.lightPeriwinkle,
            blurRadius: blurRadius ?? 1.0,
            spreadRadius: 0.1,
            offset: const Offset(2.0, 2.0),
          ),
        ],
      ),
      child: child,
    );
  }
}

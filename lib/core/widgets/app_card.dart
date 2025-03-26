import 'package:flutter/material.dart';
import '../constants/constants.dart';

class AppCard extends StatelessWidget {
  final Widget child;
  final Size size;
  final Color? color;
  final Color? borderColor;
  final Color? shadowColor;
  final double? borderRadius;
  final double? borderWidth;

  const AppCard({
    super.key,
    required this.child,
    required this.size,
    this.color,
    this.borderColor,
    this.shadowColor,
    this.borderRadius,
    this.borderWidth,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width,
      height: size.height,
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: color ?? AppColors.white,
        borderRadius: BorderRadius.circular(borderRadius ?? 15.0),
        border: Border.all(
          width: borderWidth ?? 0.5,
          color: borderColor ?? AppColors.vanilla,
        ),
        boxShadow: [
          BoxShadow(
            color: shadowColor ?? AppColors.vanilla,
            blurRadius: 1.0,
            spreadRadius: 0.1,
            offset: const Offset(2.0, 2.0),
          ),
        ],
      ),
      child: child,
    );
  }
}

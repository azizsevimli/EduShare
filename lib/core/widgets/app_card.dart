import 'package:flutter/material.dart';
import '../constants/constants.dart';

class AppCard extends StatelessWidget {
  final Widget child;
  final double width;
  final double? height;
  final EdgeInsetsGeometry? margin;
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
    this.margin = const EdgeInsets.all(10.0),
    this.padding = 10.0,
    this.color = AppColors.white,
    this.borderColor = AppColors.lightPeriwinkle,
    this.borderRadius = 15.0,
    this.borderWidth = 0.5,
    this.shadowColor = AppColors.lightPeriwinkle,
    this.blurRadius = 1.0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      margin: margin!,
      padding: EdgeInsets.all(padding!),
      decoration: BoxDecoration(
        color: color!,
        borderRadius: BorderRadius.circular(borderRadius!),
        border: Border.all(
          width: borderWidth!,
          color: borderColor!,
        ),
        boxShadow: [
          BoxShadow(
            color: shadowColor!,
            blurRadius: blurRadius!,
            spreadRadius: 0.1,
            offset: const Offset(2.0, 2.0),
          ),
        ],
      ),
      child: child,
    );
  }
}

import 'package:flutter/material.dart';
import '../constants/constants.dart';

class CustomCircularIndicator extends StatelessWidget {
  final double? width;
  final double? height;
  final Color? bgColor;
  const CustomCircularIndicator({
    super.key,
    this.width,
    this.height,
    this.bgColor,
  });

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Container(
      width: width ?? size.width * 0.9,
      height: height ?? 150.0,
      decoration: BoxDecoration(
        color: bgColor ?? AppColors.white,
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: const Center(
        child: SizedBox(
          width: 30.0,
          height: 30.0,
          child: CircularProgressIndicator(
            backgroundColor: AppColors.white,
            color: AppColors.lightXanthous,
          ),
        ),
      ),
    );
  }
}

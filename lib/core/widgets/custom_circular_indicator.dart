import 'package:flutter/material.dart';

class CustomCircularIndicator extends StatelessWidget {
  final double width;
  final double height;
  final double size;
  final Color color;
  final Color bgColor;

  const CustomCircularIndicator({
    super.key,
    required this.width,
    required this.height,
    required this.size,
    required this.color,
    required this.bgColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Center(
        child: SizedBox(
          width: size,
          height: size,
          child: CircularProgressIndicator(
            backgroundColor: bgColor,
            color: color,
          ),
        ),
      ),
    );
  }
}

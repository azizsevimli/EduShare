import 'package:flutter/cupertino.dart';

import '../constants/constants.dart';

class OutlineLabel extends StatelessWidget {
  final String text;
  final Color color;
  final double? height;

  const OutlineLabel({
    super.key,
    required this.text,
    required this.color,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: color,
          width: 1,
        ),
      ),
      child: Center(
        child: Text(
          text,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          style: AppTextStyles.body3.copyWith(
            color: color,
          ),
        ),
      ),
    );
  }
}

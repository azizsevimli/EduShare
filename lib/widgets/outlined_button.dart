import 'package:flutter/material.dart';
import 'package:edushare/config/theme/theme.dart';

class OutlinedBtn extends StatelessWidget {
  final VoidCallback onPressed;
  final String txt;
  final IconData icon;

  const OutlinedBtn({
    super.key,
    required this.onPressed,
    required this.txt,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: onPressed,
      icon: Icon(
        icon,
        color: AppColor.white,
        size: 20,
      ),
      label: Text(
        txt,
        style: AppTxtStyle.body.copyWith(
          color: AppColor.white,
          fontWeight: FontWeight.w300,
        ),
      ),
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(AppColor.orange),
        side: const WidgetStatePropertyAll(
          BorderSide(
            width: 1,
            color: AppColor.lightBrown,
          ),
        ),
      ),
    );
  }
}

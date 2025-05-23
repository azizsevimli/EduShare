import 'package:flutter/material.dart';
import '../constants/constants.dart';

class MenuListTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;
  final Color? iconColor;
  final Color? textColor;

  const MenuListTile({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
    this.iconColor,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      iconColor: iconColor ?? AppColors.darkPeriwinkle,
      title: Text(title),
      titleTextStyle: AppTextStyles.body2.copyWith(
        color: textColor ?? AppColors.darkPeriwinkle,
      ),
      splashColor: textColor ?? AppColors.lightPeriwinkle,
      onTap: onTap,
    );
  }
}

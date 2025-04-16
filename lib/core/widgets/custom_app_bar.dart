
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../constants/constants.dart';

AppBar customAppBar({
  required String title,
  required BuildContext context,
  bool isBackButton = true,
  List<Widget>? actions,
}) {
  return AppBar(
    backgroundColor: AppColors.periwinkle,
    foregroundColor: AppColors.wine,
    title: Text(
      title,
      style: AppTextStyles.appBar,
    ),
    leading: isBackButton
        ? IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => context.pop(),
          )
        : null,
    actions: actions,
  );
}
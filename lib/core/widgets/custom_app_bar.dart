import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../models/user_model.dart';
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

AppBar chatPageAppBar({required BuildContext context, required UserModel user}) {
  return AppBar(
    leading: IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () => context.pop(),
    ),
    leadingWidth: 30.0,
    title: Row(
      children: [
        CircleAvatar(
          radius: 18.0,
          backgroundImage: NetworkImage(user.imageUrl),
        ),
        const SizedBox(width: 10.0),
        Text('${user.name} ${user.surname}'),
      ],
    ),
  );
}
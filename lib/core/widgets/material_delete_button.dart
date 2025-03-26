import 'package:flutter/material.dart';
import './custom_button.dart';
import './delete_dialog.dart';
import '../constants/constants.dart';

class MaterialDeleteButton extends StatelessWidget {
  final String title;
  final String id;
  final int imageCount;

  const MaterialDeleteButton({
    super.key,
    required this.title,
    required this.id,
    required this.imageCount,
  });

  void showDeleteDialog({required BuildContext context}) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => DeleteDialog(
        title: title,
        id: id,
        imageCount: imageCount,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomOutlinedButton(
      onPressed: () => showDeleteDialog(context: context),
      icon: Icons.delete_outline,
      fgColor: AppColors.red,
    );
  }
}

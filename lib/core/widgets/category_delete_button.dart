import 'package:flutter/material.dart';

import '../../services/category_service.dart';
import '../constants/constants.dart';
import '../utils/show_snackbar.dart';
import 'custom_button.dart';
import 'custom_circular_indicator.dart';

class CategoryDeleteButton extends StatefulWidget {
  final String name;
  final String id;

  const CategoryDeleteButton({
    super.key,
    required this.name,
    required this.id,
  });

  @override
  State<CategoryDeleteButton> createState() => _CategoryDeleteButtonState();
}

class _CategoryDeleteButtonState extends State<CategoryDeleteButton> {
  final CategoryServices categoryService = CategoryServices();
  bool isDeleting = false;

  Future<void> onDeleteCategory({required BuildContext context}) async {
    setState(() {
      isDeleting = true;
    });
    await categoryService.deleteCategory(
      id: widget.id,
      onSuccess: () {
        ShowSnackBar.showSnackBar(
          context,
          'Kategori başarıyla silindi.',
        );
        Navigator.pop(context);
      },
      onError: (String message) {
        ShowSnackBar.showSnackBar(
          context,
          message,
        );
      },
    );
    setState(() {
      isDeleting = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomOutlinedButton(
      icon: Icons.delete_outlined,
      fgColor: AppColors.red,
      onPressed: () => showDialog(
        context: context,
        builder: (context) => buildDialog(context),
      ),
    );
  }

  AlertDialog buildDialog(BuildContext context) {
    return AlertDialog(
      title: Text(
        'Kategori Silme',
        style: AppTextStyles.h3.copyWith(color: AppColors.red),
      ),
      content: Text(
        '${widget.name} kategorisini silmek istediğinize emin misiniz?',
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('İptal'),
        ),
        isDeleting
            ? const CustomCircularIndicator(
                width: 100.0,
                height: 40.0,
                bgColor: AppColors.red,
              )
            : CustomElevatedButton(
                text: 'Sil',
                icon: Icons.delete,
                width: 100.0,
                bgColor: AppColors.red,
                fgColor: Colors.white,
                onPressed: () => onDeleteCategory(context: context),
              ),
      ],
    );
  }
}

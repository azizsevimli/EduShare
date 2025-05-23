import 'package:flutter/material.dart';

import '../../models/category_model.dart';
import '../../services/category_service.dart';
import '../constants/constants.dart';
import '../utils/show_snackbar.dart';
import 'category_delete_button.dart';
import 'category_edit_modal.dart';
import 'custom_button.dart';

class CategoryManagementCard extends StatelessWidget {
  CategoryManagementCard({
    super.key,
    required this.category,
  });

  final CategoryModel category;

  final CategoryServices categoryService = CategoryServices();

  void onEditCategory({required BuildContext context}) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25.0),
        ),
      ),
      builder: (context) => Padding(
        padding: const EdgeInsets.fromLTRB(10.0, 50.0, 10.0, 20.0),
        child: CategoryEditModal(category: category),
      ),
    );
  }

  Future<void> onDeleteCategory({required BuildContext context}) async {
    await categoryService.deleteCategory(
        id: category.id!,
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
        });
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      padding: const EdgeInsets.fromLTRB(
        10.0,
        5.0,
        0.0,
        5.0,
      ),
      decoration: containerDecoration(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 5,
            child: buildText(),
          ),
          Expanded(
            flex: 1,
            child: buildButtons(context: context, category: category),
          )
        ],
      ),
    );
  }

  Column buildText() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          category.name,
          style: AppTextStyles.h3,
        ),
        const Divider(
          color: AppColors.periwinkle,
          thickness: 1.0,
        ),
        Text(
          category.subcategories.join(' / '),
          style: AppTextStyles.body2.copyWith(
            color: AppColors.grey,
          ),
        ),
      ],
    );
  }

  Column buildButtons({
    required BuildContext context,
    required CategoryModel category,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CustomOutlinedButton(
          icon: Icons.edit_outlined,
          onPressed: () => onEditCategory(context: context),
        ),
        const SizedBox(height: 5.0),
        CategoryDeleteButton(
          name: category.name,
          id: category.id!,
        ),
      ],
    );
  }

  BoxDecoration containerDecoration() {
    return BoxDecoration(
      color: Colors.white,
      border: Border.all(
        color: AppColors.periwinkle,
        width: 1.0,
      ),
      borderRadius: BorderRadius.circular(15.0),
    );
  }
}

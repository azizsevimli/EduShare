import 'package:edushare/core/constants/constants.dart';
import 'package:flutter/material.dart';

import '../../models/category_model.dart';
import '../../services/category_service.dart';
import '../utils/show_snackbar.dart';
import 'custom_button.dart';
import 'custom_circular_indicator.dart';
import 'custom_text_fields.dart';

class CategoryFormModal extends StatefulWidget {
  const CategoryFormModal({super.key});

  @override
  State<CategoryFormModal> createState() => _CategoryFormModalState();
}

class _CategoryFormModalState extends State<CategoryFormModal> {
  final CategoryServices _categoryService = CategoryServices();
  final TextEditingController categoryController = TextEditingController();
  final TextEditingController subcategoryController = TextEditingController();

  final List<String> subcategories = [];
  bool isLoading = false;

  void addSubcategory() {
    if (subcategoryController.text.isNotEmpty) {
      setState(() {
        subcategories.add(subcategoryController.text);
        subcategoryController.clear();
      });
    }
  }

  Future<void> onSave() async {
    if (categoryController.text.isEmpty) {
      ShowSnackBar.showSnackBar(context, 'Lütfen kategori adını girin.');
    } else if (subcategories.isEmpty) {
      ShowSnackBar.showSnackBar(
          context, 'Lütfen en az bir alt kategori ekleyin.');
    } else {
      setState(() {
        isLoading = true;
      });
      final category = CategoryModel(
        name: categoryController.text,
        subcategories: subcategories,
      );
      await _categoryService.addCategory(
        category: category,
        onError: (String message) {
          ShowSnackBar.showSnackBar(context, message);
          setState(() {
            isLoading = false;
          });
        },
        onSuccess: () {
          ShowSnackBar.showSnackBar(context, 'Kategori başarıyla eklendi.');
          setState(() {
            isLoading = false;
          });
          mounted ? Navigator.pop(context) : null;
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        const Text(
          'Yeni Kategori Ekle',
          style: AppTextStyles.appBar,
        ),
        const SizedBox(height: 10.0),
        CustomTextField(
          controller: categoryController,
          label: 'Kategori Adı',
          multiline: false,
        ),
        const SizedBox(height: 10.0),
        TextField(
          controller: subcategoryController,
          decoration: InputDecoration(
            labelText: 'Alt Kategori Adı',
            suffixIcon: IconButton(
              icon: const Icon(Icons.add, color: AppColors.tiffany),
              onPressed: addSubcategory,
            ),
          ),
        ),
        const SizedBox(height: 10.0),
        buildSubcategoriesList(size),
        isLoading
            ? const CustomCircularIndicator(
                bgColor: AppColors.periwinkle,
                height: 40.0,
              )
            : CustomElevatedButton(
                text: 'Kaydet',
                width: size.width,
                onPressed: onSave,
              ),
      ],
    );
  }

  Expanded buildSubcategoriesList(Size size) {
    return Expanded(
      child: ListView.separated(
        itemCount: subcategories.length,
        separatorBuilder: (context, index) => const SizedBox(height: 5.0),
        itemBuilder: (context, index) {
          return Container(
            width: size.width,
            height: 50.0,
            padding: const EdgeInsets.only(left: 10.0),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Text(
                    subcategories[index],
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close, color: AppColors.red),
                  onPressed: () {
                    setState(() {
                      subcategories.removeAt(index);
                    });
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

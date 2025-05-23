import 'package:edushare/core/constants/constants.dart';
import 'package:flutter/material.dart';

import '../../models/category_model.dart';
import '../../services/category_service.dart';
import '../utils/show_snackbar.dart';
import 'custom_button.dart';
import 'custom_circular_indicator.dart';
import 'custom_text_fields.dart';

class CategoryEditModal extends StatefulWidget {
  final CategoryModel category;

  const CategoryEditModal({
    super.key,
    required this.category,
  });

  @override
  State<CategoryEditModal> createState() => _CategoryEditModalState();
}

class _CategoryEditModalState extends State<CategoryEditModal> {
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

  @override
  void initState() {
    super.initState();
    categoryController.text = widget.category.name;
    subcategories.addAll(widget.category.subcategories);
  }

  @override
  void dispose() {
    super.dispose();
    categoryController.dispose();
    subcategoryController.dispose();
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
        id: widget.category.id,
      );
      await _categoryService.updateCategory(category: category);
      if (mounted) {
        Navigator.pop(context);
      }
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

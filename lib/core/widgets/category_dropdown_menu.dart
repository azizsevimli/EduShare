import 'package:flutter/material.dart';

import '../../models/category_model.dart';
import '../../services/category_service.dart';
import '../constants/constants.dart';

class CategoryDropdownMenu extends StatefulWidget {
  final TextEditingController controller;

  const CategoryDropdownMenu({
    super.key,
    required this.controller,
  });

  @override
  State<CategoryDropdownMenu> createState() => _CategoryDropdownMenuState();
}

class _CategoryDropdownMenuState extends State<CategoryDropdownMenu> {
  final CategoryServices _service = CategoryServices();
  late List<CategoryModel> _categories;

  Future<void> loadCategories() async {
    _categories = await _service.getCategories();
  }

  @override
  void initState() {
    super.initState();
    loadCategories().then((_) {
      setState(() {});
    });
  }

  void _showDepPicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return draggableScrollable(
          title: 'Kategori seçiniz',
          list: _categories,
          controller: widget.controller,
          context: context,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showDepPicker(context),
      child: AbsorbPointer(
        child: TextField(
          controller: widget.controller,
          decoration: const InputDecoration(
            labelText: 'Kategori',
            suffixIcon: Icon(Icons.arrow_drop_down),
          ),
        ),
      ),
    );
  }
}

class SubcategoriesDropdownMenu extends StatefulWidget {
  final TextEditingController controller;
  final String? category;

  const SubcategoriesDropdownMenu({
    super.key,
    required this.controller,
    this.category,
  });

  @override
  State<SubcategoriesDropdownMenu> createState() =>
      _SubcategoriesDropdownMenuState();
}

class _SubcategoriesDropdownMenuState extends State<SubcategoriesDropdownMenu> {
  final CategoryServices _service = CategoryServices();
  late List<String> _subcategories;

  Future<void> loadSubcategories({required String category}) async {
    _subcategories = await _service.fetchSubcategories(category: category);
  }

  @override
  void initState() {
    super.initState();
    if (widget.category != '') {
      loadSubcategories(category: widget.category!).then((_) {
        setState(() {});
      });
    }
  }

  void _showDepPicker({required BuildContext context}) {
    if (widget.category != '') {
      loadSubcategories(category: widget.category!).then((_) {
        if (context.mounted) {
          showModalBottomSheet(
            context: context,
            builder: (BuildContext context) {
              return draggableScrollable(
                title: 'Alt kategori seçiniz',
                list: _subcategories,
                controller: widget.controller,
                context: context,
                isSubcategory: true,
              );
            },
          );
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showDepPicker(context: context),
      child: AbsorbPointer(
        child: TextField(
          controller: widget.controller,
          decoration: InputDecoration(
            labelText: widget.category == ''
                ? 'Önce kategori seçimi yapınız'
                : 'Alt kategori',
            suffixIcon: const Icon(Icons.arrow_drop_down),
          ),
        ),
      ),
    );
  }
}

Widget draggableScrollable({
  required String title,
  required List<dynamic> list,
  required TextEditingController controller,
  required BuildContext context,
  bool? isSubcategory = false,
}) {
  return DraggableScrollableSheet(
    expand: false,
    builder: (_, scrollController) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15.0),
            child: Text(
              title,
              style: AppTextStyles.h3.copyWith(color: AppColors.tiffany),
            ),
          ),
          Expanded(
            child: ListView.builder(
              controller: scrollController,
              itemCount: list.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(isSubcategory! ? list[index] : list[index].name),
                  onTap: () {
                    controller.text =
                        isSubcategory ? list[index] : list[index].name;
                    Navigator.pop(context);
                  },
                );
              },
            ),
          ),
        ],
      );
    },
  );
}

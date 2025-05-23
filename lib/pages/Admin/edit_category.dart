import 'package:flutter/material.dart';

import '../../core/widgets/category_form_modal.dart';
import '../../core/widgets/category_management_card.dart';
import '../../core/widgets/custom_button.dart';
import '../../core/widgets/custom_circular_indicator.dart';
import '../../models/category_model.dart';
import '../../services/category_service.dart';

class EditCategoryPage extends StatefulWidget {
  const EditCategoryPage({super.key});

  @override
  State<EditCategoryPage> createState() => _EditCategoryPageState();
}

class _EditCategoryPageState extends State<EditCategoryPage> {
  final CategoryServices categoryService = CategoryServices();

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kategoriler'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomElevatedButton(
              text: 'Yeni Kategori Ekle',
              icon: Icons.add,
              width: size.width,
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(25.0),
                    ),
                  ),
                  builder: (context) => const Padding(
                    padding: EdgeInsets.fromLTRB(10.0, 50.0, 10.0, 20.0),
                    child: CategoryFormModal(),
                  ),
                );
              },
            ),
            FutureBuilder<List<CategoryModel>>(
              future: categoryService.getCategories(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CustomCircularIndicator(),
                  );
                }
                if (snapshot.hasError) {
                  return Center(
                    child: Text('Bir hata oluştu: ${snapshot.error}'),
                  );
                }
                final categories = snapshot.data ?? [];
                return Expanded(
                  child: ListView.separated(
                    padding: const EdgeInsets.only(top: 10.0),
                    itemCount: categories.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 10.0),
                    itemBuilder: (_, i) {
                      final category = categories[i];
                      return CategoryManagementCard(category: category);
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

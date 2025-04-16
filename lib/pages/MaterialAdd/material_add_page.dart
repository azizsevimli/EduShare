import 'dart:io';
import 'package:flutter/material.dart';
import '../../core/widgets/category_dropdown_menu.dart';
import '../../services/user_service.dart';
import '../../services/new_material_service.dart';
import '../../core/constants/constants.dart';
import '../../core/widgets/custom_text_fields.dart';
import '../../core/widgets/custom_button.dart';
import '../../core/widgets/material_image_picker.dart';
import '../../core/utils/show_snackbar.dart';
import '../../core/utils/generate_uuid.dart';

class MaterialAddPage extends StatefulWidget {
  const MaterialAddPage({super.key});

  @override
  State<MaterialAddPage> createState() => _MaterialAddPageState();
}

// TODO: 3. Ürün için kategori seçme eklenecek

class _MaterialAddPageState extends State<MaterialAddPage> {
  final UserServices _userService = UserServices();

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  TextEditingController subcategoryController = TextEditingController();
  TextEditingController subjectController = TextEditingController();

  List<File?> _images = [null, null, null, null];
  bool isPaid = false;
  String selectedCategory = '';

  void _updateImages(List<File?> newImages) {
    setState(() {
      _images = newImages;
    });
  }

  @override
  void initState() {
    super.initState();
    categoryController.addListener(() {
      setState(() {
        selectedCategory = categoryController.text;
        subcategoryController.text = '';
      });
    });
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    priceController.dispose();
    categoryController.dispose();
    subjectController.dispose();
    super.dispose();
  }

  // TODO: 3. Validation güncellenecek
  void addMaterial() {
    if (_images[0] == null ||
        titleController.text.isEmpty ||
        descriptionController.text.isEmpty ||
        categoryController.text.isEmpty ||
        subjectController.text.isEmpty) {
      ShowSnackBar.showSnackBar(
        context,
        'Lütfen tüm alanları doldurun!',
      );
    } else {
      uploadMaterial(
        id: generateMaterialId(),
        owner: _userService.getUserId()!,
        title: titleController.text.trim(),
        description: descriptionController.text.trim(),
        cost: isPaid ? priceController.text.trim() : '0',
        category: categoryController.text.trim(),
        subcategory: subcategoryController.text.trim(),
        subject: subjectController.text.trim(),
        images: _images,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const InputTitleSubtitle(
              title: 'Materyal Görselleri',
              subtitle: 'En az bir görsel yükleyin',
            ),
            const SizedBox(height: 5),
            MaterialImagePicker(
              selectedImages: _images,
              onImagesChanged: _updateImages,
            ),
            const SizedBox(height: 20),
            const InputTitleSubtitle(
              title: 'Materyal Başlığı',
              subtitle: 'Bir başlık girin',
            ),
            const SizedBox(height: 5),
            CustomTextField(
              controller: titleController,
              hint: 'Örn: Hesap Makinesi',
              ml: false,
            ),
            const SizedBox(height: 20),
            const InputTitleSubtitle(
              title: 'Materyal Açıklaması',
              subtitle: 'Materyal hakkında detaylı bilgi verin (En az 30 karakter)',
            ),
            const SizedBox(height: 5),
            CustomTextField(
              controller: descriptionController,
              hint: 'Marka model bilgisi, kullanım durumu, vb.',
              ml: true,
            ),
            const SizedBox(height: 20),
            const InputTitleSubtitle(
              title: 'Materyal Fiyatı',
              subtitle: 'Materyal fiyatını girin',
            ),
            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                buildRadio(title: 'Ücretsiz', v: false),
                const SizedBox(width: 20),
                buildRadio(title: 'Ücretli', v: true),
              ],
            ),
            const SizedBox(height: 5),
            if (isPaid == true)
              OnlyCostField(
                controller: priceController,
                hint: 'Ücret',
              ),
            const SizedBox(height: 20),
            const InputTitleSubtitle(
              title: 'Kategori',
              subtitle: 'Kategori ve alt kategoriyi seçin',
            ),
            const SizedBox(height: 10),
            CategoryDropdownMenu(
              controller: categoryController,
            ),
            const SizedBox(height: 20),
            SubcategoriesDropdownMenu(controller: subcategoryController, category: selectedCategory,),
            //AllDepartmentBottomSheet(controller: materialDepController),
            const SizedBox(height: 20),
            const InputTitleSubtitle(
              title: 'Ders',
              subtitle: 'İlgili dersi yazın',
            ),
            const SizedBox(height: 5),
            CustomTextField(
              controller: subjectController,
              hint: 'Örn: Mobil Programlama',
              ml: false,
            ),
            const SizedBox(height: 20),
            CustomElevatedButton(
              text: 'Materyal Ekle',
              onPressed: addMaterial,
              width: width,
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Row buildRadio({required String title, required bool v}) {
    return Row(
      children: [
        Radio<bool>(
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          splashRadius: 10,
          fillColor: const WidgetStatePropertyAll(AppColors.periwinkle),
          overlayColor: const WidgetStatePropertyAll(AppColors.periwinkle),
          value: v,
          groupValue: isPaid,
          onChanged: (value) {
            setState(() {
              isPaid = value!;
            });
          },
        ),
        Text(title),
      ],
    );
  }
}

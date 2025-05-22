import 'dart:io';
import 'package:flutter/material.dart';
import '../../core/widgets/category_dropdown_menu.dart';
import '../../core/widgets/custom_circular_indicator.dart';
import '../../services/material_service.dart';
import '../../services/user_service.dart';
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

class _MaterialAddPageState extends State<MaterialAddPage> {
  final UserServices _userService = UserServices();
  final MaterialServices _materialService = MaterialServices();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  TextEditingController subcategoryController = TextEditingController();
  TextEditingController subjectController = TextEditingController();

  List<File?> _images = [null, null, null, null];
  bool _isPaid = false;
  bool _isLoading = false;
  String _selectedCategory = '';

  void _updateImages(List<File?> newImages) {
    setState(() {
      _images = newImages;
    });
  }

  void _validateAndSubmit({required BuildContext context}) async {
    if (_images[0] == null) {
      ShowSnackBar.showSnackBar(
        context,
        'Lütfen bir görsel seçin!',
      );
      return;
    }

    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      await _materialService.uploadMaterial(
        id: generateMaterialId(),
        owner: _userService.getUserId()!,
        title: titleController.text.trim(),
        description: descriptionController.text.trim(),
        price: _isPaid ? priceController.text.trim() : '0',
        category: categoryController.text.trim(),
        subcategory: subcategoryController.text.trim(),
        subject: subjectController.text.trim(),
        images: _images,
      );
      setState(() {
        _isLoading = false;
      });
    } else {
      ShowSnackBar.showSnackBar(
        context,
        'Lütfen tüm alanları doğru şekilde doldurun!',
      );
    }
  }

  @override
  void initState() {
    super.initState();
    categoryController.addListener(() {
      setState(() {
        _selectedCategory = categoryController.text;
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

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 30.0),
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
            buildFormField(),
            const SizedBox(height: 20),
            _isLoading
                ? CustomCircularIndicator(
                    width: size.width,
                    height: 40,
                    bgColor: AppColors.periwinkle,
                  )
                : CustomElevatedButton(
                    text: 'Materyal Ekle',
                    onPressed: () => _validateAndSubmit(context: context),
                    width: size.width,
                  ),
          ],
        ),
      ),
    );
  }

  Form buildFormField() {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomTextFormField(
            controller: titleController,
            hint: 'Örn: Hesap Makinesi',
            title: 'Materyal Başlığı',
            subtitle: 'Bir başlık girin',
            multiline: false,
          ),
          const SizedBox(height: 20),
          CustomTextFormField(
            controller: descriptionController,
            hint: 'Marka model bilgisi, kullanım durumu, vb.',
            title: 'Materyal Açıklaması',
            subtitle: 'Materyal hakkında detaylı bilgi verin',
            multiline: true,
          ),
          const SizedBox(height: 5),
          const InputTitleSubtitle(
            title: 'Materyal Ücreti',
            subtitle: 'Materyal ücret tipi seçin',
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
          if (_isPaid == true)
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
          SubcategoriesDropdownMenu(
            controller: subcategoryController,
            category: _selectedCategory,
          ),
          const SizedBox(height: 20),
          CustomTextFormField(
            controller: subjectController,
            hint: 'Örn: Mobil Programlama',
            title: 'Ders',
            subtitle: 'İlgili dersi yazın',
            multiline: false,
          ),
        ],
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
          groupValue: _isPaid,
          onChanged: (value) {
            setState(() {
              _isPaid = value!;
            });
          },
        ),
        Text(title),
      ],
    );
  }
}

import 'dart:io';
import 'package:flutter/material.dart';
import '../../models/associate_model.dart';
import '../../models/bachelor_model.dart';
import '../../services/user_service.dart';
import '../../services/uni_and_dep_service.dart';
import '../../services/new_material_service.dart';
import '../../core/constants/constants.dart';
import '../../core/widgets/custom_text_fields.dart';
import '../../core/widgets/custom_button.dart';
import '../../core/widgets/school_dropdown_menu.dart';
import '../../core/widgets/material_image_picker.dart';
import '../../core/utils/show_snackbar.dart';
import '../../core/utils/generate_uuid.dart';

class MaterialAddPage extends StatefulWidget {
  const MaterialAddPage({super.key});

  @override
  State<MaterialAddPage> createState() => _MaterialAddPageState();
}

// TODO: Ürün için kategori seçme eklenecek

class _MaterialAddPageState extends State<MaterialAddPage> {
  final UserServices us = UserServices();
  final UniAndDepService uniAndDepService = UniAndDepService();
  TextEditingController materialTitleController = TextEditingController();
  TextEditingController materialDescriptionController = TextEditingController();
  TextEditingController materialCostController = TextEditingController();
  TextEditingController materialDepController = TextEditingController();
  TextEditingController materialSubjectController = TextEditingController();

  List<File?> _images = [null, null, null, null];
  bool isPaid = false;
  List<Object> departments = [];
  List<AssociateModel> associates = [];
  List<BachelorModel> bachelors = [];

  void _updateImages(List<File?> newImages) {
    setState(() {
      _images = newImages;
    });
  }

  Future<void> _loadData() async {
    associates = await uniAndDepService.loadAssociates();
    bachelors = await uniAndDepService.loadBachelors();
    setState(() {
      departments = [...associates, ...bachelors];
    });
  }

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  void dispose() {
    materialTitleController.dispose();
    materialDescriptionController.dispose();
    materialCostController.dispose();
    materialDepController.dispose();
    materialSubjectController.dispose();
    super.dispose();
  }

  // TODO: Validation güncellenecek
  void addMaterial() {
    if (_images[0] == null ||
        materialTitleController.text.isEmpty ||
        materialDescriptionController.text.isEmpty ||
        materialDepController.text.isEmpty ||
        materialSubjectController.text.isEmpty) {
      ShowSnackBar.showSnackBar(context, 'Lütfen tüm alanları doldurun!',);
    } else {
      uploadMaterial(
        id: generateMaterialId(),
        owner: us.getUserId()!,
        title: materialTitleController.text.trim(),
        description: materialDescriptionController.text.trim(),
        cost: isPaid ? materialCostController.text.trim() : '0',
        department: materialDepController.text.trim(),
        subject: materialSubjectController.text.trim(),
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
              title: 'Ürün Görselleri',
              subtitle: 'En az bir ürün görseli yükleyin',
            ),
            const SizedBox(height: 5),
            MaterialImagePicker(
              selectedImages: _images,
              onImagesChanged: _updateImages,
            ),
            const SizedBox(height: 20),
            const InputTitleSubtitle(
              title: 'Ürün Adı',
              subtitle: 'Ürünün adını girin',
            ),
            const SizedBox(height: 5),
            CustomTextField(
              controller: materialTitleController,
              hint: 'Örn: Hesap Makinesi',
              ml: false,
            ),
            const SizedBox(height: 20),
            const InputTitleSubtitle(
              title: 'Ürün Açıklaması',
              subtitle: 'Ürün hakkında detaylı bilgi verin (En az 30 karakter)',
            ),
            const SizedBox(height: 5),
            CustomTextField(
              controller: materialDescriptionController,
              hint: 'Marka model bilgisi, kullanım durumu, vb.',
              ml: true,
            ),
            const SizedBox(height: 20),
            const InputTitleSubtitle(
              title: 'Ürün Fiyatı',
              subtitle: 'Ürünün fiyatını girin',
            ),
            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                buildRadio('Ücretsiz', false),
                const SizedBox(width: 20),
                buildRadio('Ücretli', true),
              ],
            ),
            const SizedBox(height: 5),
            if (isPaid == true)
              OnlyCostField(
                controller: materialCostController,
                hint: 'Ücret',
              ),
            const SizedBox(height: 20),
            const InputTitleSubtitle(
              title: 'İlgili Bölüm',
              subtitle: 'Ürünün kullanıldığı bölümü seçin',
            ),
            const SizedBox(height: 5),
            AllDepartmentBottomSheet(controller: materialDepController),
            const SizedBox(height: 20),
            const InputTitleSubtitle(
              title: 'İlgili Ders',
              subtitle: 'Ürünün kullanıldığı dersi seçin',
            ),
            const SizedBox(height: 5),
            CustomTextField(
              controller: materialSubjectController,
              hint: 'Örn: Mühendislik Matematiği',
              ml: false,
            ),
            const SizedBox(height: 20),
            CustomElevatedButton(
              text: 'Ürünü Ekle',
              onPressed: addMaterial,
              width: width,
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Row buildRadio(String title, bool val) {
    return Row(
      children: [
        Radio<bool>(
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          splashRadius: 10,
          fillColor: const WidgetStatePropertyAll(AppColors.periwinkle),
          overlayColor: const WidgetStatePropertyAll(AppColors.periwinkle),
          value: val,
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

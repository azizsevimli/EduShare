import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../models/associate_model.dart';
import '../../models/bachelor_model.dart';
import '../../services/uni_and_dep_service.dart';
import '../../services/new_product_service.dart';
import '../../core/constants/constants.dart';
import '../../core/widgets/custom_text_fields.dart';
import '../../core/widgets/custom_button.dart';
import '../../core/widgets/school_dropdown_menu.dart';
import '../../core/widgets/product_image_picker.dart';
import '../../core/utils/show_snackbar.dart';
import '../../core/utils/generate_uuid.dart';

class ProductAddPage extends StatefulWidget {
  const ProductAddPage({super.key});

  @override
  State<ProductAddPage> createState() => _ProductAddPageState();
}

// TODO: Ürün için kategori seçme eklenecek

class _ProductAddPageState extends State<ProductAddPage> {
  String uid = FirebaseAuth.instance.currentUser!.uid;
  final UniAndDepService uniAndDepService = UniAndDepService();
  TextEditingController productTitleController = TextEditingController();
  TextEditingController productDescriptionController = TextEditingController();
  TextEditingController productCostController = TextEditingController();
  TextEditingController productDepController = TextEditingController();
  TextEditingController productClassController = TextEditingController();

  List<File?> _images = [null, null, null, null];
  bool? isPaid;
  List<Object> departments = [];
  List<AssociateModel> associates = [];
  List<BachelorModel> bachelors = [];

  void _updateImages(List<File?> newImages) {
    setState(() {
      _images = newImages;
    });
  }

  Future<void> loadData() async {
    associates = await uniAndDepService.loadAssociates();
    bachelors = await uniAndDepService.loadBachelors();
    setState(() {
      departments = [...associates, ...bachelors];
    });
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  void dispose() {
    productTitleController.dispose();
    productDescriptionController.dispose();
    productCostController.dispose();
    productDepController.dispose();
    productClassController.dispose();
    super.dispose();
  }

  void addProductBtn() {
    if (_images[0] == null ||
        productTitleController.text.isEmpty ||
        productDescriptionController.text.isEmpty ||
        productDepController.text.isEmpty ||
        productClassController.text.isEmpty) {
      ShowSnackBar.showSnackBar(context, 'Lütfen tüm alanları doldurun!');
    } else {
      uploadProduct(
        id: generateProductId(),
        owner: uid,
        title: productTitleController.text.trim(),
        description: productDescriptionController.text.trim(),
        cost: productCostController.text.trim(),
        department: productDepController.text.trim(),
        subject: productClassController.text.trim(),
        images: _images,
        isSold: false,
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
            ProductImagePicker(
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
              controller: productTitleController,
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
              controller: productDescriptionController,
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
                controller: productCostController,
                hint: 'Ücret',
              ),
            const SizedBox(height: 20),
            const InputTitleSubtitle(
              title: 'İlgili Bölüm',
              subtitle: 'Ürünün kullanıldığı bölümü seçin',
            ),
            const SizedBox(height: 5),
            AllDepartmentBottomSheet(controller: productDepController),
            const SizedBox(height: 20),
            const InputTitleSubtitle(
              title: 'İlgili Ders',
              subtitle: 'Ürünün kullanıldığı dersi seçin',
            ),
            const SizedBox(height: 5),
            CustomTextField(
              controller: productClassController,
              hint: 'Örn: Mühendislik Matematiği',
              ml: false,
            ),
            const SizedBox(height: 20),
            CustomElevatedButton(
              text: 'Ürünü Ekle',
              onPressed: addProductBtn,
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

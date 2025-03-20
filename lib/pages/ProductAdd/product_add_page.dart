import 'dart:io';
import 'package:flutter/material.dart';
import '../../models/associate_model.dart';
import '../../models/bachelor_model.dart';
import '../../services/uni_and_dep_service.dart';
import '../../services/new_product_service.dart';
import '../../core/constants/constants.dart';
import '../../core/widgets/input_widgets.dart';
import '../../core/widgets/custom_button.dart';
import '../../core/widgets/school_dropdown_menu.dart';
import '../../core/widgets/product_image_picker.dart';
import '../../core/utils/user_uid.dart';
import '../../core/utils/show_snackbar.dart';
import '../../core/utils/generate_uuid.dart';

class ProductAddPage extends StatefulWidget {
  const ProductAddPage({super.key});

  @override
  State<ProductAddPage> createState() => _ProductAddPageState();
}

class _ProductAddPageState extends State<ProductAddPage> {
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
          id: GenerateUuid.generateProductId(),
          owner: GetUser.getUserUID(),
          title: productTitleController.text.trim(),
          description: productDescriptionController.text.trim(),
          cost: productCostController.text.trim(),
          department: productDepController.text.trim(),
          subject: productClassController.text.trim(),
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
            InputTitleSubtitle(
              title: 'Ürün Görselleri',
              subtitle: 'En az bir ürün görseli yükleyin',
            ),
            SizedBox(height: 5),
            ProductImagePicker(
              selectedImages: _images,
              onImagesChanged: _updateImages,
            ),
            SizedBox(height: 20),
            InputTitleSubtitle(
              title: 'Ürün Adı',
              subtitle: 'Ürünün adını girin',
            ),
            SizedBox(height: 5),
            OnlyTextField(
              controller: productTitleController,
              hintText: 'Örn: Hesap Makinesi',
            ),
            SizedBox(height: 20),
            InputTitleSubtitle(
              title: 'Ürün Açıklaması',
              subtitle: 'Ürün hakkında detaylı bilgi verin (En az 30 karakter)',
            ),
            SizedBox(height: 5),
            MultiLinesTextField(
              controller: productDescriptionController,
              hintText: 'Marka model bilgisi, kullanım durumu, vb.',
            ),
            SizedBox(height: 20),
            InputTitleSubtitle(
              title: 'Ürün Fiyatı',
              subtitle: 'Ürünün fiyatını girin',
            ),
            SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                buildRadio('Ücretsiz', false),
                SizedBox(width: 20),
                buildRadio('Ücretli', true),
              ],
            ),
            SizedBox(height: 5),
            if (isPaid == true)
              OnlyCostField(
                controller: productCostController,
                hintText: 'Ücret',
              ),
            SizedBox(height: 20),
            InputTitleSubtitle(
              title: 'İlgili Bölüm',
              subtitle: 'Ürünün kullanıldığı bölümü seçin',
            ),
            SizedBox(height: 5),
            AllDepartmentBottomSheet(
              controller: productDepController,
              departments: departments,
            ),
            SizedBox(height: 20),
            InputTitleSubtitle(
              title: 'İlgili Ders',
              subtitle: 'Ürünün kullanıldığı dersi seçin',
            ),
            SizedBox(height: 5),
            OnlyTextField(
              controller: productClassController,
              hintText: 'Örn: Mühendislik Matematiği',
            ),
            SizedBox(height: 20),
            CustomElevatedButton(
              text: 'Ürünü Ekle',
              onPressed: addProductBtn,
              width: width,
            ),
            SizedBox(height: 30),
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
          fillColor: WidgetStatePropertyAll(AppColors.periwinkle),
          overlayColor: WidgetStatePropertyAll(AppColors.periwinkle),
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

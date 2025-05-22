import 'package:flutter/material.dart';
import '../../core/constants/constants.dart';
import '../../core/utils/show_snackbar.dart';
import '../../core/widgets/custom_app_bar.dart';
import '../../core/widgets/category_dropdown_menu.dart';
import '../../core/widgets/custom_button.dart';
import '../../core/widgets/custom_circular_indicator.dart';
import '../../core/widgets/custom_text_fields.dart';
import '../../models/material_model.dart';
import '../../services/material_service.dart';

class MaterialEditPage extends StatefulWidget {
  final String id;

  const MaterialEditPage({
    super.key,
    required this.id,
  });

  @override
  State<MaterialEditPage> createState() => _MaterialEditPageState();
}

class _MaterialEditPageState extends State<MaterialEditPage> {
  final MaterialServices _materialServices = MaterialServices();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();
  final TextEditingController subcategoryController = TextEditingController();
  final TextEditingController subjectController = TextEditingController();

  late MaterialModel? material;
  late String _category;
  bool _isLoading = false;
  bool _isUpdating = false;
  bool _isSelling = false;

  void loadMaterial() async {
    setState(() {
      _isLoading = true;
    });
    material = await _materialServices.getMaterialById(id: widget.id);
    if (material != null) {
      titleController.text = material!.title;
      descriptionController.text = material!.description;
      priceController.text = material!.price;
      categoryController.text = material!.category;
      subcategoryController.text = material!.subcategory;
      subjectController.text = material!.subject;
      setState(() {
        _category = material!.category;
        _isLoading = false;
      });
    }
  }

  void updateMaterial({required MaterialModel material}) async {
    setState(() {
      _isUpdating = true;
    });
    final MaterialModel updatedMaterial = MaterialModel(
      id: widget.id.trim(),
      title: titleController.text.trim(),
      description: descriptionController.text.trim(),
      price: priceController.text.trim(),
      category: categoryController.text.trim(),
      subcategory: subcategoryController.text.trim(),
      subject: subjectController.text.trim(),
      owner: material.owner,
      isSold: material.isSold,
      imageUrls: material.imageUrls,
      createdAt: material.createdAt,
    );
    await _materialServices.updateMaterial(material: updatedMaterial);
    setState(() {
      _isUpdating = false;
    });
    mounted ? Navigator.pop(context) : null;
  }

  void updateIsSold({required MaterialModel material}) async {
    setState(() {
      _isSelling = true;
    });
    await _materialServices.updateIsSold(material: material);
    setState(() {
      _isSelling = false;
    });
    mounted ? Navigator.pop(context) : null;
  }

  void _validateAndSubmit({required BuildContext context}) async {
    if (_formKey.currentState!.validate()) {
      updateMaterial(material: material!);
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
    loadMaterial();
    categoryController.addListener(() {
      setState(() {
        _category = categoryController.text;
        subcategoryController.text = '';
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    titleController.dispose();
    descriptionController.dispose();
    priceController.dispose();
    categoryController.dispose();
    subjectController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: customAppBar(
        title: 'Materyal Güncelleme',
        context: context,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: _isLoading
              ? const CustomCircularIndicator()
              : Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildFormField(),
                    const SizedBox(height: 20),
                    buildIsUpdatingButtons(
                      boolean: _isSelling,
                      child: CustomElevatedButton(
                        text: 'Satıldı Olarak İşaretle',
                        bgColor: AppColors.xanthous,
                        onPressed: () => updateIsSold(material: material!),
                        width: size.width,
                      ),
                      size: size,
                      color: AppColors.xanthous,
                    ),
                    const SizedBox(height: 20),
                    buildIsUpdatingButtons(
                      boolean: _isUpdating,
                      child: CustomElevatedButton(
                        text: 'Değişiklikleri Kaydet',
                        bgColor: AppColors.lightTiffany,
                        onPressed: () => _validateAndSubmit(context: context),
                        width: size.width,
                      ),
                      size: size,
                    )
                  ],
                ),
        ),
      ),
    );
  }

  Widget buildIsUpdatingButtons({
    required bool boolean,
    required Widget child,
    required Size size,
    Color? color
  }) {
    return boolean
        ? CustomCircularIndicator(
            width: size.width,
            height: 40,
            bgColor: color ?? AppColors.lightTiffany,
          )
        : child;
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
            subtitle: 'Uygun bir başlık girin',
            multiline: false,
          ),
          const SizedBox(height: 20),
          CustomTextFormField(
            controller: descriptionController,
            hint: 'Marka model bilgisi, kullanım durumu, vb.',
            title: 'Materyal Açıklaması',
            subtitle:
                'Materyal hakkında detaylı bilgi verin (En az 30 karakter)',
            multiline: true,
          ),
          const SizedBox(height: 5),
          OnlyCostField(
            controller: priceController,
            hint: 'Ücret',
            title: 'Materyal Fiyatı',
            subtitle: 'Materyal fiyatını girin',
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
            category: _category,
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
}

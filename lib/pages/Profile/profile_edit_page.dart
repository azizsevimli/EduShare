import 'dart:io';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../core/constants/constants.dart';
import '../../core/utils/image_source_options.dart';
import '../../core/widgets/app_card.dart';
import '../../core/widgets/custom_app_bar.dart';
import '../../core/widgets/personal_info_inputs.dart';
import '../../core/widgets/university_info_inputs.dart';
import '../../services/upload_image_service.dart';
import '../../core/widgets/custom_button.dart';

class ProfileEditPage extends StatefulWidget {
  final Map<String, dynamic> data;

  const ProfileEditPage({super.key, required this.data});

  @override
  State<ProfileEditPage> createState() => _ProfileEditPageState();
}

class _ProfileEditPageState extends State<ProfileEditPage> {
  final FirebaseFirestore ffs = FirebaseFirestore.instance;
  final _formKey = GlobalKey<FormState>();
  final ImagePicker _picker = ImagePicker();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController surnameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController uniController = TextEditingController();
  final TextEditingController depController = TextEditingController();
  final TextEditingController gradeController = TextEditingController();
  final TextEditingController degreeController = TextEditingController();
  File? _image;
  String? imageUrl;

  Future<void> _pickImage({required ImageSource source}) async {
    final pickedFile = await _picker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  // TODO: 6. Formkey ile verilerin doğruluğunu kontrol et ve UserService fonksiyonunu kullan
  Future<void> _updateProfile({required BuildContext context}) async {
    if (_image != null) {
      imageUrl = await uploadProfileImageToStorage(
        image: _image!,
        owner: widget.data['uid'],
      );
    }
    await ffs.collection('users').doc(widget.data['uid']).update({
      'name': nameController.text,
      'surname': surnameController.text,
      'mail': emailController.text,
      'phone': phoneController.text,
      'university': uniController.text,
      'department': depController.text,
      'degree': degreeController.text,
      'grade': gradeController.text,
      'imageUrl': imageUrl ?? widget.data['imageUrl'],
    });
    context.mounted ? context.go('/profile') : null;
  }

  @override
  void initState() {
    super.initState();
    nameController.text = widget.data['name'];
    surnameController.text = widget.data['surname'];
    emailController.text = widget.data['mail'];
    phoneController.text = widget.data['phone'];
    uniController.text = widget.data['university'];
    depController.text = widget.data['department'];
    gradeController.text = widget.data['grade'];
    degreeController.text = widget.data['degree'];

    degreeController.addListener(() {
      setState(() {
        depController.text = '';
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: customAppBar(
        context: context,
        title: 'Profili Düzenle',
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 5.0),
            child: CustomElevatedButton(
              onPressed: () => _updateProfile(context: context),
              text: 'Kaydet',
              width: 90.0,
              bgColor: AppColors.lightTiffany,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 20, 10, 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 50,
                backgroundImage: _image != null
                    ? FileImage(_image!)
                    : NetworkImage(widget.data['imageUrl']),
              ),
              CustomTextButton(
                text: 'Resmi güncelle',
                onPressed: () => showImageSourceOptions(
                  context: context,
                  image: _image,
                  onImageFromGallery: () {
                    Navigator.of(context).pop();
                    _pickImage(source: ImageSource.gallery);
                  },
                  onImageFromCamera: () {
                    Navigator.of(context).pop();
                    _pickImage(source: ImageSource.camera);
                  },
                  onRemoveImage: () {
                    Navigator.of(context).pop();
                    setState(() {
                      _image = null;
                    });
                  },
                ),
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    buildHeader('Kişisel Bilgiler'),
                    const SizedBox(height: 10.0),
                    AppCard(
                      width: size.width,
                      child: PersonalInfoInputs(
                        nameController: nameController,
                        surnameController: surnameController,
                        emailController: emailController,
                        phoneController: phoneController,
                      ),
                    ),
                    const SizedBox(height: 15.0),
                    buildHeader('Üniversite Bilgileri'),
                    const SizedBox(height: 10.0),
                    AppCard(
                      width: size.width,
                      child: UniversityInfoInputs(
                        uniController: uniController,
                        depController: depController,
                        degreeController: degreeController,
                        gradeController: gradeController,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Row buildHeader(String text) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: Text(
            text,
            style: AppTextStyles.body1.copyWith(
              color: AppColors.darkTiffany,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}

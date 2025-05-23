import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../core/constants/constants.dart';
import '../../core/utils/image_source_options.dart';
import '../../core/utils/show_snackbar.dart';
import '../../core/widgets/app_card.dart';
import '../../core/widgets/custom_app_bar.dart';
import '../../core/widgets/custom_button.dart';
import '../../core/widgets/personal_info_inputs.dart';
import '../../core/widgets/university_info_inputs.dart';
import '../../models/user_model.dart';
import '../../services/upload_image_service.dart';
import '../../services/url_to_file_service.dart';
import '../../services/user_service.dart';

class ProfileEditPage extends StatefulWidget {
  final Map<String, dynamic> data;

  const ProfileEditPage({super.key, required this.data});

  @override
  State<ProfileEditPage> createState() => _ProfileEditPageState();
}

class _ProfileEditPageState extends State<ProfileEditPage> {
  final UserServices _userService = UserServices();
  final ImagePicker _picker = ImagePicker();
  final _formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController surnameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController uniController = TextEditingController();
  final TextEditingController depController = TextEditingController();
  final TextEditingController gradeController = TextEditingController();
  final TextEditingController degreeController = TextEditingController();
  File? _image;
  File? _defaultImage;
  String? imageUrl;
  bool isLoading = false;

  Future<void> _pickImage({required ImageSource source}) async {
    final pickedFile = await _picker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  Future<void> _updateProfile({required BuildContext context}) async {
    if (_image != null && _image != _defaultImage) {
      imageUrl = await uploadProfileImageToStorage(
        image: _image!,
        owner: widget.data['uid'],
      );
    } else {
      imageUrl = defaultProfileImageUrl;
    }
    final UserModel user = UserModel(
      uid: widget.data['uid'],
      name: nameController.text,
      surname: surnameController.text,
      mail: widget.data['mail'],
      phone: widget.data['phone'],
      university: uniController.text,
      department: depController.text,
      degree: degreeController.text,
      grade: gradeController.text,
      imageUrl: imageUrl ?? widget.data['imageUrl'],
      favoriteMaterials: widget.data['favoriteMaterials'],
    );
    await _userService.updateUser(user: user);
    context.mounted ? Navigator.pop(context) : null;
  }

  void _validateAndSubmit({required BuildContext context}) {
    if (_formKey.currentState!.validate()) {
      _updateProfile(context: context);
    } else {
      ShowSnackBar.showSnackBar(
        context,
        'Lütfen tüm alanları doğru şekilde doldurun!',
      );
    }
  }

  Future<void> _imageUrlToFile() async {
    setState(() {
      isLoading = true;
    });
    if (widget.data['imageUrl'] != null) {
      if (widget.data['imageUrl'] != defaultProfileImageUrl) {
        _image = await urlToFile(imageUrl: widget.data['imageUrl']);
      }
      _defaultImage = await urlToFile(imageUrl: defaultProfileImageUrl);
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _imageUrlToFile();
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
  void dispose() {
    super.dispose();
    nameController.dispose();
    surnameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    uniController.dispose();
    depController.dispose();
    gradeController.dispose();
    degreeController.dispose();
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
              onPressed: () => _validateAndSubmit(context: context),
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
                backgroundImage: isLoading
                    ? null
                    : _image != null
                        ? FileImage(_image!)
                        : FileImage(_defaultImage!),
              ),
              CustomTextButton(
                text: 'Resmi güncelle',
                onPressed: () => showImageSourceOptions(
                  context: context,
                  image: _image == _defaultImage ? null : _image,
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
                      _image = _defaultImage;
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
                      margin: const EdgeInsets.all(0.0),
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
                      margin: const EdgeInsets.all(0.0),
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

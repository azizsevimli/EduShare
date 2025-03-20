import 'dart:io';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../services/upload_image_service.dart';
import '../../core/constants/constants.dart';
import '../../core/widgets/custom_button.dart';
import '../../core/widgets/custom_text_fields.dart';
import '../../core/widgets/school_dropdown_menu.dart';

class ProfileEditPage extends StatefulWidget {
  final Map<String, dynamic> data;

  const ProfileEditPage({super.key, required this.data});

  @override
  State<ProfileEditPage> createState() => _ProfileEditPageState();
}

class _ProfileEditPageState extends State<ProfileEditPage> {
  final FirebaseFirestore ffs = FirebaseFirestore.instance;
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

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  // TODO: Güncelleme  için giden verilerin doğruluğunu kontrol et

  Future<void> _updateProfile({required BuildContext ctx}) async {
    if (_image != null) {
      imageUrl = await uploadProfileImageToStorage(
        image: _image!,
        owner: widget.data['uuid'],
      );
    }
    await ffs.collection('users').doc(widget.data['uuid']).update({
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
    ctx.mounted ? ctx.go('/profile') : null;
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
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.vanilla,
        foregroundColor: AppColors.orange,
        title: Text(
          'Profile Edit',
          style: TextStyle(color: AppColors.orange),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(10, 20, 10, 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundImage: _image != null
                      ? FileImage(_image!)
                      : NetworkImage(widget.data['imageUrl']),
                ),
                CustomTextButton(onPressed: _pickImage, text: 'Resmi güncelle'),
              ],
            ),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: CustomTextField(
                    controller: nameController,
                    label: 'Ad',
                    hint: 'Adınızı girin',
                    ml: false,
                  ),
                ),
                SizedBox(width: 5.0),
                Expanded(
                  flex: 1,
                  child: CustomTextField(
                    controller: surnameController,
                    label: 'Soyad',
                    hint: 'Soyadınızı girin',
                    ml: false,
                  ),
                ),
              ],
            ),
            EmailField(controller: emailController, enabled: false),
            PhoneField(controller: phoneController, enabled: false),
            UniversityModalBottomSheet(controller: uniController),
            DepartmentModalBottomSheet(controller: depController, degree: degreeController.text),
            DegreeDropdownMenu(controller: degreeController),
            GradeDropdownMenu(controller: gradeController),
            CustomElevatedButton(
              text: 'Değişiklikleri Kaydet',
              onPressed: () => _updateProfile(ctx: context),
              width: width,
              icon: Icons.save_outlined,
            ),
          ],
        ),
      ),
    );
  }
}

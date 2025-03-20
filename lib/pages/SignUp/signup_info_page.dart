import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../services/new_user_service.dart';
import '../../services/uni_and_dep_service.dart';
import '../../models/university_model.dart';
import '../../models/associate_model.dart';
import '../../models/bachelor_model.dart';
import '../../core/utils/show_snackbar.dart';
import '../../core/constants/constants.dart';
import '../../core/widgets/school_dropdown_menu.dart';

class SignUpInfoPage extends StatefulWidget {
  final Map<String, dynamic>? data;

  const SignUpInfoPage({super.key, this.data});

  @override
  State<SignUpInfoPage> createState() => _SignUpInfoPageState();
}

class _SignUpInfoPageState extends State<SignUpInfoPage> {
  final UniAndDepService uniAndDepService = UniAndDepService();
  final TextEditingController uniController = TextEditingController();
  final TextEditingController depController = TextEditingController();
  final TextEditingController gradeController = TextEditingController();
  final TextEditingController degreeController = TextEditingController();

  List<String> grade = ['Hazırlık', '1', '2', '3', '4', '5', '6'];
  List<String> degree = ['Lisans', 'Önlisans'];
  List<UniversityModel> universities = [];
  List<AssociateModel> associates = [];
  List<BachelorModel> bachelors = [];

  String selectedDegree = '';

  @override
  void initState() {
    super.initState();
    _loadData();

    degreeController.addListener(() {
      setState(() {
        selectedDegree = degreeController.text;
        depController.text = '';
      });
    });
  }

  @override
  void dispose() {
    uniController.dispose();
    depController.dispose();
    gradeController.dispose();
    degreeController.dispose();
    super.dispose();
  }

  Future<void> _loadData() async {
    universities = await uniAndDepService.loadUniversities();
    associates = await uniAndDepService.loadAssociates();
    bachelors = await uniAndDepService.loadBachelors();
    setState(() {});
  }

  void signUpBtn() {
    if (uniController.text.isEmpty ||
        depController.text.isEmpty ||
        gradeController.text.isEmpty ||
        degreeController.text.isEmpty) {
      ShowSnackBar.showSnackBar(context, 'Lütfen tüm alanları doldurun!');
    } else {
      registerUser(
        name: widget.data?['name'],
        surname: widget.data?['surname'],
        mail: widget.data?['mail'],
        phone: widget.data?['phone'],
        password: widget.data?['password'],
        degree: degreeController.text.trim(),
        grade: gradeController.text.trim(),
        university: uniController.text.trim(),
        department: depController.text.trim(),
        onError: (String message) => ShowSnackBar.showSnackBar(context, message),
        onSuccess: (UserCredential userCredential) {
          ShowSnackBar.showSnackBar(
            context,
            'Kayıt başarılı: ${userCredential.user?.email}',
          );
          context.push('/home');
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 30.0),
                  child: Text(
                    'EduShare',
                    style: AppTextStyles.h1.copyWith(color: AppColors.orange),
                  ),
                ),
                Text('Tüm bilgileri doldurun ve kaydolun.',
                    style: AppTextStyles.body1),
                SizedBox(height: 30.0),
                DegreeDropdownMenu(controller: degreeController),
                SizedBox(height: 15.0),
                GradeDropdownMenu(controller: gradeController),
                SizedBox(height: 15.0),
                UniversityModalBottomSheet(
                  controller: uniController,
                ),
                SizedBox(height: 15.0),
                DepartmentModalBottomSheet(
                  controller: depController,
                  degree: selectedDegree,
                ),
                SizedBox(height: 30.0),
                SizedBox(
                  width: width * 0.4,
                  child: ElevatedButton(
                    onPressed: signUpBtn,
                    child: Text('Kayıt Ol'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

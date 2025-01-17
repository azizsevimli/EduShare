import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:edushare/services/new_user_service.dart';
import 'package:edushare/services/uni_and_dep_service.dart';
import 'package:edushare/models/university_model.dart';
import 'package:edushare/models/associate_model.dart';
import 'package:edushare/models/bachelor_model.dart';
import 'package:edushare/core/utils/utils.dart';
import 'package:edushare/core/constants/constants.dart';
import 'package:edushare/core/widgets/school_dropdown_menu.dart';

class ProfileInfoPage extends StatefulWidget {
  final Map<String, dynamic>? data;

  const ProfileInfoPage({super.key, this.data});

  @override
  State<ProfileInfoPage> createState() => _ProfileInfoPageState();
}

class _ProfileInfoPageState extends State<ProfileInfoPage> {
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
      Utils.showSnackBar(context, 'Lütfen tüm alanları doldurun!');
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
        onError: (String message) => Utils.showSnackBar(context, message),
        onSuccess: (UserCredential userCredential) {
          Utils.showSnackBar(
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
                Row(
                  children: [
                    DegreeDropdownMenu(controller: degreeController),
                    SizedBox(width: 10.0),
                    GradeDropdownMenu(controller: gradeController),
                  ],
                ),
                SizedBox(height: 15.0),
                UniDropdownMenu(
                  uniController: uniController,
                  universities: universities,
                ),
                SizedBox(height: 15.0),
                DepDropdownMenu(
                  depController: depController,
                  degree: selectedDegree,
                  associates: associates,
                  bachelors: bachelors,
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

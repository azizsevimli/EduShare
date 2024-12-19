import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:edushare/config/theme.dart';
import 'package:edushare/models/department_model.dart';
import 'package:edushare/models/university_model.dart';
import 'package:edushare/widgets/outlined_button.dart';

class ProfileEdit extends StatefulWidget {
  const ProfileEdit({super.key});
  @override
  State<ProfileEdit> createState() => _ProfileEditState();
}

class _ProfileEditState extends State<ProfileEdit> {
  University? _selectedUniversity;
  String? selectedDegree;
  String? selectedGrade;
  String? selectedDepartment;
  DepartmentModel? _departments;
  List<University> _universities = [];
  final List<String> degree = ['Lisans', 'Önlisans'];
  final List<String> grade = ['Hazırlık', '1', '2', '3', '4', '5', '6'];

  Future<void> _loadUniversities() async {
    final json = await rootBundle.loadString('assets/files/universities.json');
    final List<dynamic> data = jsonDecode(json);
    _universities = University.uniNames(data);
  }

  Future<void> _loadDepartments() async {
    final json = await rootBundle.loadString('assets/files/departments.json');
    final Map<String, dynamic> data = jsonDecode(json);
    _departments = DepartmentModel.fromJson(data);
  }

  @override
  void initState() {
    super.initState();
    _loadUniversities();
    _loadDepartments();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              /*---Page-Header---*/
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    /*---Back-Button---*/
                    IconButton(
                      onPressed: () {
                        GoRouter.of(context).pop();
                      },
                      icon: const Icon(
                        Icons.arrow_back,
                      ),
                    ),
                    const SizedBox(width: 10),
                    /*---Header-Text---*/
                    Text(
                      'Profil Düzenle',
                      style: AppTxtStyle.h2.copyWith(color: AppColor.orange),
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  /*--Profile-Photo---*/
                  const CircleAvatar(
                    radius: 70,
                    backgroundImage:
                    AssetImage('assets/images/panda_512x512.png'),
                  ),
                  const SizedBox(height: 10),
                  /*---Edit-Photo---*/
                  InkWell(
                    onTap: () {
                      debugPrint('Resim düzenlendi');
                    },
                    child: Text(
                      'Resmi düzenle',
                      style:
                      AppTxtStyle.caption.copyWith(color: AppColor.orange),
                    ),
                  ),
                  const SizedBox(height: 10),
                  /*---Form---*/
                  Form(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /*---Ad-Soyad---*/
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              child: inpTextField('Ad', 'Adınızı girin'),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: inpTextField('Soyad', 'Soyadınızı girin'),
                            ),
                          ],
                        ),
                        const SizedBox(height: 15),
                        Row(
                          children: [
                            /*---Degree---*/
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  inpHeader('Öğrenim Türü'),
                                  const SizedBox(height: 5),
                                  degDropMenu(),
                                ],
                              ),
                            ),
                            const SizedBox(width: 10),
                            /*---Grade---*/
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  inpHeader('Sınıf'),
                                  const SizedBox(height: 5),
                                  greDropMenu(),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 15),
                        /*---Universite---*/
                        inpHeader('Üniversite'),
                        const SizedBox(height: 5),
                        _universities.isEmpty
                            ? const CircularProgressIndicator()
                            : uniDropMenu(),
                        const SizedBox(height: 15),
                        /*---Department---*/
                        inpHeader('Bölüm'),
                        const SizedBox(height: 5),
                        depDropMenu(),
                        const SizedBox(height: 15),
                        /*---E-mail---*/
                        inpTextField('E-posta', 'exm@exm.com'),
                        const SizedBox(height: 15),
                        /*---Phone---*/
                        inpTextField('Telefon', '5555555555'),
                        const SizedBox(height: 15),
                        /*---Birthday---*/
                        inpTextField('Doğum Tarihi', 'Örn: 01.01.2000'),
                        const SizedBox(height: 15),
                        /*---Save-Button---*/
                        Row(
                          children: [
                            Expanded(
                              child: OutlinedBtn(
                                onPressed: () {
                                  context.pop();
                                },
                                txt: 'Kaydet',
                                icon: Icons.save,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  /*---Input-Header---*/
  Padding inpHeader(String header) {
    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: Text(
        header,
        style: AppTxtStyle.caption.copyWith(
          color: AppColor.darkBrown,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  /*---Input-Decoration---*/
  InputDecorationTheme inpDecTheme() {
    return InputDecorationTheme(
      filled: true,
      fillColor: AppColor.white,
      border: inpBorder(),
      hintStyle: AppTxtStyle.body.copyWith(
        color: AppColor.lightGray,
      ),
      enabledBorder: inpBorder(),
    );
  }

  /*---Input-Border---*/
  OutlineInputBorder inpBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(12.0),
      borderSide: const BorderSide(
        style: BorderStyle.solid,
      ),
    );
  }

  /*---Degree-DropMenu---*/
  DropdownMenu<String> degDropMenu() {
    return DropdownMenu<String>(
      initialSelection: selectedDegree,
      expandedInsets: const EdgeInsets.all(0),
      menuStyle: const MenuStyle(
        backgroundColor: WidgetStatePropertyAll(AppColor.white),
      ),
      inputDecorationTheme: inpDecTheme(),
      dropdownMenuEntries: degree.map(
            (d) {
          return DropdownMenuEntry<String>(
            value: d,
            label: d,
          );
        },
      ).toList(),
      onSelected: (selected) {
        setState(
              () {
            selectedDegree = selected;
          },
        );
      },
    );
  }

  /*---Grade-DropMenu---*/
  DropdownMenu<String> greDropMenu() {
    return DropdownMenu<String>(
      initialSelection: selectedGrade,
      expandedInsets: const EdgeInsets.all(0),
      menuStyle: const MenuStyle(
        backgroundColor: WidgetStatePropertyAll(AppColor.white),
      ),
      inputDecorationTheme: inpDecTheme(),
      dropdownMenuEntries: grade.map(
            (g) {
          return DropdownMenuEntry<String>(
            value: g,
            label: g,
          );
        },
      ).toList(),
      onSelected: (selected) {
        setState(
              () {
            selectedGrade = selected;
          },
        );
      },
    );
  }

  /*---University-DropMenu---*/
  DropdownMenu<University> uniDropMenu() {
    return DropdownMenu<University>(
      initialSelection: _selectedUniversity,
      expandedInsets: const EdgeInsets.all(0),
      hintText: 'Üniversite seçiniz',
      menuStyle: const MenuStyle(
        fixedSize: WidgetStatePropertyAll(Size(300, 300)),
        backgroundColor: WidgetStatePropertyAll(AppColor.white),
      ),
      inputDecorationTheme: inpDecTheme(),
      dropdownMenuEntries: _universities.map(
            (university) {
          return DropdownMenuEntry<University>(
            value: university,
            label: university.name ?? "Unknown",
          );
        },
      ).toList(),
      onSelected: (selected) {
        setState(
              () {
            _selectedUniversity = selected;
          },
        );
      },
    );
  }

  /*---Department-DropMenu---*/
  DropdownMenu<Object?> depDropMenu() {
    return DropdownMenu(
      initialSelection: selectedDepartment,
      expandedInsets: const EdgeInsets.all(0),
      hintText: 'Bölüm seçiniz',
      inputDecorationTheme: inpDecTheme(),
      menuStyle: const MenuStyle(
        fixedSize: WidgetStatePropertyAll(Size(300, 300)),
        backgroundColor: WidgetStatePropertyAll(AppColor.white),
      ),
      dropdownMenuEntries: selectedDegree == 'Lisans'
          ? _departments!.bachelor.map(
            (d) {
          return DropdownMenuEntry<Bachelor>(
            value: d,
            label: d.toString(),
          );
        },
      ).toList()
          : selectedDegree == 'Önlisans'
          ? _departments!.associate.map(
            (d) {
          return DropdownMenuEntry<Associate>(
            value: d,
            label: d.toString(),
          );
        },
      ).toList()
          : [],
      onSelected: (selected) {
        setState(
              () {
            selectedDepartment = selected.toString();
          },
        );
      },
    );
  }

  /*---Input-Field---*/
  Column inpTextField(String header, String hint) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /*---Header---*/
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Text(
            header,
            style: AppTxtStyle.caption.copyWith(
              color: AppColor.darkBrown,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const SizedBox(height: 5),
        /*---Input---*/
        SizedBox(
          height: 35,
          child: TextFormField(
            decoration: InputDecoration(
              filled: true,
              fillColor: AppColor.white,
              hintText: hint,
              hintStyle: AppTxtStyle.body.copyWith(
                color: AppColor.lightGray,
              ),
              enabledBorder: inpBorder(),
              focusedBorder: inpBorder(),
              contentPadding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
            ),
          ),
        )
      ],
    );
  }
}

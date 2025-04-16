import 'package:edushare/core/widgets/school_dropdown_menu.dart';
import 'package:flutter/material.dart';

class UniversityInfoInputs extends StatelessWidget {
  final TextEditingController uniController;
  final TextEditingController depController;
  final TextEditingController degreeController;
  final TextEditingController gradeController;

  const UniversityInfoInputs({
    super.key,
    required this.uniController,
    required this.depController,
    required this.degreeController,
    required this.gradeController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        UniversityModalBottomSheet(controller: uniController),
        const SizedBox(height: 15.0),
        DepartmentModalBottomSheet(
          controller: depController,
          degree: degreeController.text,
        ),
        const SizedBox(height: 15.0),
        DegreeDropdownMenu(controller: degreeController),
        const SizedBox(height: 15.0),
        GradeDropdownMenu(controller: gradeController),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:edushare/models/university_model.dart';
import 'package:edushare/models/associate_model.dart';
import 'package:edushare/models/bachelor_model.dart';
import 'package:edushare/core/constants/constants.dart';

class UniDropdownMenu extends StatefulWidget {
  final TextEditingController uniController;
  final List<UniversityModel> universities;

  const UniDropdownMenu({
    super.key,
    required this.uniController,
    required this.universities,
  });

  @override
  State<UniDropdownMenu> createState() => _UniDropdownMenuState();
}

class _UniDropdownMenuState extends State<UniDropdownMenu> {
  @override
  Widget build(BuildContext context) {
    return DropdownMenu<UniversityModel>(
      controller: widget.uniController,
      width: MediaQuery.of(context).size.width,
      label: const Text('Üniversite'),
      hintText: 'Üniversitenizi seçin',
      keyboardType: TextInputType.none,
      dropdownMenuEntries: widget.universities.map((university){
        return DropdownMenuEntry<UniversityModel>(
            value: university,
            label: university.name
        );
      }).toList(),
    );
  }
}

class DepDropdownMenu extends StatefulWidget {
  final TextEditingController depController;
  final String degree;
  final List<AssociateModel> associates;
  final List<BachelorModel> bachelors;

  const DepDropdownMenu({
    super.key,
    required this.depController,
    required this.degree,
    required this.associates,
    required this.bachelors,
  });

  @override
  State<DepDropdownMenu> createState() => _DepDropdownMenuState();
}

class _DepDropdownMenuState extends State<DepDropdownMenu> {
  @override
  Widget build(BuildContext context) {
    return _buildDropdownMenu();
  }

  Widget _buildDropdownMenu() {
    if (widget.degree == 'Lisans') {
      return DropdownMenu<BachelorModel>(
        controller: widget.depController,
        width: MediaQuery.of(context).size.width,
        label: const Text('Bölüm'),
        hintText: 'Bölümünüzü seçin',
        keyboardType: TextInputType.none,
        dropdownMenuEntries: widget.bachelors.map((bachelor) {
          return DropdownMenuEntry<BachelorModel>(
            value: bachelor,
            label: bachelor.name,
          );
        }).toList(),
      );
    } else if (widget.degree == 'Önlisans') {
      return DropdownMenu<AssociateModel>(
        controller: widget.depController,
        width: MediaQuery.of(context).size.width,
        label: const Text('Bölüm'),
        hintText: 'Bölümünüzü seçin',
        keyboardType: TextInputType.none,
        dropdownMenuEntries: widget.associates.map((associate) {
          return DropdownMenuEntry<AssociateModel>(
            value: associate,
            label: associate.name,
          );
        }).toList(),
      );
    } else {
      return Text(
        'Bölüm seçmek için önce "Derece" seçmelisiniz.',
        style: AppTextStyles.body1,
      );
    }
  }
}

class DegreeDropdownMenu extends StatefulWidget {
  final TextEditingController controller;

  const DegreeDropdownMenu({super.key, required this.controller});

  @override
  State<DegreeDropdownMenu> createState() => _DegreeDropdownMenuState();
}

class _DegreeDropdownMenuState extends State<DegreeDropdownMenu> {
  List<String> degree = ['Lisans', 'Önlisans'];
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return DropdownMenu<String>(
      width: width * 0.46,
      controller: widget.controller,
      label: const Text('Derece'),
      hintText: 'Derecenizi seçin',
      keyboardType: TextInputType.none,
      dropdownMenuEntries: degree.map((degree) {
        return DropdownMenuEntry<String>(
          value: degree,
          label: degree,
        );
      }).toList(),
    );
  }
}

class GradeDropdownMenu extends StatefulWidget {
  final TextEditingController controller;

  const GradeDropdownMenu({super.key, required this.controller});

  @override
  State<GradeDropdownMenu> createState() => _GradeDropdownMenuState();
}

class _GradeDropdownMenuState extends State<GradeDropdownMenu> {
  List<String> grade = ['Hazırlık', '1', '2', '3', '4', '5', '6'];

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return DropdownMenu<String>(
      width: width * 0.46,
      controller: widget.controller,
      label: const Text('Sınıf'),
      hintText: 'Sınıfınızı seçin',
      keyboardType: TextInputType.none,
      dropdownMenuEntries: grade.map((grade) {
        return DropdownMenuEntry<String>(
          value: grade,
          label: grade,
        );
      }).toList(),
    );
  }
}

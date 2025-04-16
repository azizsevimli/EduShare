import 'package:flutter/material.dart';
import '../../models/university_model.dart';
import '../../models/associate_model.dart';
import '../../models/bachelor_model.dart';
import '../../services/uni_and_dep_service.dart';
import '../constants/constants.dart';

class UniversityModalBottomSheet extends StatefulWidget {
  final TextEditingController controller;

  const UniversityModalBottomSheet({
    super.key,
    required this.controller,
  });

  @override
  State<UniversityModalBottomSheet> createState() =>
      _UniversityModalBottomSheet();
}

class _UniversityModalBottomSheet extends State<UniversityModalBottomSheet> {
  final UniAndDepService service = UniAndDepService();
  List<UniversityModel> universities = [];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    universities = await service.loadUniversities();
    setState(() {});
  }

  void _showUniversityPicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return DraggableScrollableSheet(
          expand: false,
          builder: (BuildContext context, ScrollController scrollController) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15.0),
                  child: Text(
                    'Üniversite seçiniz',
                    style: AppTextStyles.h3.copyWith(color: AppColors.tiffany),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    controller: scrollController,
                    itemCount: universities.length,
                    itemBuilder: (BuildContext context, int index) {
                      final university = universities[index];
                      return ListTile(
                        title: Text(university.name),
                        onTap: () {
                          widget.controller.text = university.name;
                          Navigator.pop(context);
                        },
                      );
                    },
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showUniversityPicker(context),
      child: AbsorbPointer(
        child: TextField(
          controller: widget.controller,
          decoration: const InputDecoration(
            labelText: 'Üniversite',
            suffixIcon: Icon(Icons.arrow_drop_down),
          ),
        ),
      ),
    );
  }
}

class DepartmentModalBottomSheet extends StatefulWidget {
  final TextEditingController controller;
  final String degree;

  const DepartmentModalBottomSheet({
    super.key,
    required this.controller,
    required this.degree,
  });

  @override
  State<DepartmentModalBottomSheet> createState() => _DepartmentModalBottomSheet();
}

class _DepartmentModalBottomSheet extends State<DepartmentModalBottomSheet> {
  final UniAndDepService service = UniAndDepService();
  List<AssociateModel> associates = [];
  List<BachelorModel> bachelors = [];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    associates = await service.loadAssociates();
    bachelors = await service.loadBachelors();
    setState(() {});
  }

  void _showDepPicker(BuildContext context) {
    List<String> items = [];
    if (widget.degree == 'Lisans') {
      items = bachelors.map((e) => e.name).toList();
    } else if (widget.degree == 'Önlisans') {
      items = associates.map((e) => e.name).toList();
    }

    if (items.isEmpty) return;

    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return DraggableScrollableSheet(
          expand: false,
          builder: (BuildContext context, ScrollController scrollController) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15.0),
                  child: Text(
                    'Bölüm seçiniz',
                    style: AppTextStyles.h3.copyWith(color: AppColors.tiffany),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    controller: scrollController,
                    itemCount: items.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        title: Text(items[index]),
                        onTap: () {
                          widget.controller.text = items[index];
                          Navigator.pop(context);
                        },
                      );
                    },
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showDepPicker(context),
      child: AbsorbPointer(
        child: TextField(
          controller: widget.controller,
          decoration: InputDecoration(
            labelText: widget.degree.isEmpty ? 'Önce derece seçimi yapınız' : 'Bölüm',
            suffixIcon: const Icon(Icons.arrow_drop_down),
          ),
        ),
      ),
    );
  }
}

class AllDepartmentBottomSheet extends StatefulWidget{
  final TextEditingController controller;

  const AllDepartmentBottomSheet({
    super.key,
    required this.controller,
  });

  @override
  State<AllDepartmentBottomSheet> createState() => _AllDepartmentBottomSheet();
}

class _AllDepartmentBottomSheet extends State<AllDepartmentBottomSheet> {
  final UniAndDepService service = UniAndDepService();
  List<Object> departments = [];
  List<AssociateModel> associates = [];
  List<BachelorModel> bachelors = [];

  Future<void> loadData() async {
    associates = await service.loadAssociates();
    bachelors = await service.loadBachelors();
    setState(() {
      departments = [...associates, ...bachelors];
      departments.sort((a, b) {
        String nameA = (a is AssociateModel) ? a.name : (a as BachelorModel).name;
        String nameB = (b is AssociateModel) ? b.name : (b as BachelorModel).name;

        return nameA.compareTo(nameB);
      });
    });
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  void _showDepartmentPicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return DraggableScrollableSheet(
          expand: false,
          builder: (BuildContext context, ScrollController scrollController) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15.0),
                  child: Text(
                    'Bölüm seçiniz',
                    style: AppTextStyles.h3.copyWith(color: AppColors.tiffany),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    controller: scrollController,
                    itemCount: departments.length,
                    itemBuilder: (BuildContext context, int index) {
                      final department = departments[index];
                      final String label;
                      if (department is BachelorModel ||
                          department is AssociateModel) {
                        label = (department as dynamic).name;
                      } else {
                        label = department.toString();
                      }
                      return ListTile(
                        title: Text(label),
                        onTap: () {
                          widget.controller.text = label;
                          Navigator.pop(context);
                        },
                      );
                    },
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showDepartmentPicker(context),
      child: AbsorbPointer(
        child: TextField(
          controller: widget.controller,
          readOnly: true,
          decoration: const InputDecoration(
            labelText: 'Bölüm',
            suffixIcon: Icon(Icons.arrow_drop_down),
          ),
        ),
      ),
    );
  }
}

class DegreeDropdownMenu extends StatelessWidget {
  final TextEditingController controller;

  const DegreeDropdownMenu({super.key, required this.controller});

  void _showDegreePicker(BuildContext context) {
    final List<String> degree = ['Lisans', 'Önlisans'];

    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return DraggableScrollableSheet(
          expand: false,
          builder: (BuildContext context, ScrollController scrollController) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15.0),
                  child: Text(
                    'Derece seçiniz',
                    style: AppTextStyles.h3.copyWith(color: AppColors.tiffany),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    controller: scrollController,
                    itemCount: degree.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        title: Text(degree[index]),
                        onTap: () {
                          controller.text = degree[index];
                          Navigator.pop(context);
                        },
                      );
                    },
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showDegreePicker(context),
      child: AbsorbPointer(
        child: TextField(
          controller: controller,
          decoration: const InputDecoration(
            labelText: 'Derece',
            suffixIcon: Icon(Icons.arrow_drop_down),
          ),
        ),
      ),
    );
  }
}

class GradeDropdownMenu extends StatelessWidget {
  final TextEditingController controller;

  const GradeDropdownMenu({super.key, required this.controller});

  void _showGradePicker(BuildContext context) {
    final List<String> grade = ['Hazırlık', '1', '2', '3', '4', '5', '6'];

    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return DraggableScrollableSheet(
          expand: false,
          builder: (BuildContext context, ScrollController scrollController) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15.0),
                  child: Text(
                    'Sınıf seçiniz',
                    style: AppTextStyles.h3.copyWith(color: AppColors.tiffany),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    controller: scrollController,
                    shrinkWrap: true,
                    itemCount: grade.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        title: Text(grade[index]),
                        onTap: () {
                          controller.text = grade[index];
                          Navigator.pop(context);
                        },
                      );
                    },
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showGradePicker(context),
      child: AbsorbPointer(
        child: TextField(
          controller: controller,
          decoration: const InputDecoration(
            labelText: 'Sınıf',
            suffixIcon: Icon(Icons.arrow_drop_down),
          ),
        ),
      ),
    );
  }
}

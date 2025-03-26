import 'package:flutter/material.dart';
import '../../models/material_model.dart';
import '../../services/user_service.dart';
import '../../core/widgets/custom_button.dart';
import '../../core/widgets/my_materials_list.dart';

class MyMaterialsPage extends StatefulWidget {
  const MyMaterialsPage({super.key});

  @override
  State<MyMaterialsPage> createState() => _MyMaterialsPageState();
}

class _MyMaterialsPageState extends State<MyMaterialsPage> {
  final UserServices us = UserServices();
  late Future<List<MaterialModel>> materialFuture;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    materialFuture = us.getUserMaterials();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: _buildButton(
                    index: 0,
                    text: 'Satışta Olanlar',
                  ),
                ),
                const SizedBox(width: 5.0),
                Expanded(
                  flex: 1,
                  child: _buildButton(
                    index: 1,
                    text: 'Satılanlar',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10.0),
            MyMaterialsList(
              future: materialFuture,
              index: _selectedIndex,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildButton({
    required int index,
    required String text,
  }) {
    final bool isSelected = _selectedIndex == index;

    return isSelected
        ? CustomElevatedButton(
            onPressed: () {},
            text: text,
          )
        : CustomOutlinedButton(
            onPressed: () {
              setState(() {
                _selectedIndex = index;
              });
            },
            text: text,
          );
  }
}

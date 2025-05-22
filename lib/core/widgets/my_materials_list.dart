import 'package:flutter/material.dart';
import './material_management_card.dart';
import '../../models/material_model.dart';
import 'custom_circular_indicator.dart';
import 'material_card.dart';

class MyMaterialsList extends StatelessWidget {
  final Future<List<MaterialModel>> future;
  final int index;
  final String type;

  const MyMaterialsList({
    super.key,
    required this.future,
    required this.index,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<MaterialModel>>(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CustomCircularIndicator(),
          );
        }
        if (snapshot.hasError) {
          return const Center(
            child: Text("Veriler yüklenirken bir hata oluştu!"),
          );
        }
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(
            child: Text("Henüz materyal yüklemediniz."),
          );
        }

        List<MaterialModel> materials = snapshot.data!;
        List<MaterialModel> soldMaterials = [];
        List<MaterialModel> unsoldMaterials = [];

        for (var material in materials) {
          if (material.isSold) {
            soldMaterials.add(material);
          } else {
            unsoldMaterials.add(material);
          }
        }

        return type == "my"
            ? ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount:
                    index == 0 ? unsoldMaterials.length : soldMaterials.length,
                itemBuilder: (context, i) {
                  final material =
                      index == 0 ? unsoldMaterials[i] : soldMaterials[i];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: MaterialManagementCard(material: material),
                  );
                },
              )
            : GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.65,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount:
                    index == 0 ? unsoldMaterials.length : soldMaterials.length,
                itemBuilder: (context, i) {
                  final material =
                      index == 0 ? unsoldMaterials[i] : soldMaterials[i];
                  return MaterialCard(material: material);
                },
              );
      },
    );
  }
}

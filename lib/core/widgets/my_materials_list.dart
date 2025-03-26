import 'package:flutter/material.dart';
import './material_management_card.dart';
import '../../models/material_model.dart';

class MyMaterialsList extends StatelessWidget {
  final Future<List<MaterialModel>> future;
  final int index;

  const MyMaterialsList({
    super.key,
    required this.future,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<MaterialModel>>(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (snapshot.hasError) {
          return const Center(
            child: Text("Veriler yüklenirken bir hata oluştu!"),
          );
        }
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(
            child: Text("Henüz ürün yüklemediniz."),
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

        return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: index == 0
              ? unsoldMaterials.length
              : soldMaterials.length,
          itemBuilder: (context, index) {
            final material = index == 0
                ? unsoldMaterials[index]
                : soldMaterials[index];
            return Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: MaterialManagementCard(material: material),
            );
          },
        );
      },
    );
  }
}

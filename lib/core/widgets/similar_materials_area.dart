import 'package:flutter/material.dart';
import './material_card.dart';
import './custom_circular_indicator.dart';
import '../constants/constants.dart';
import '../../models/material_model.dart';
import '../../services/material_service.dart';

class SimilarMaterialsArea extends StatefulWidget {
  final String subcategory;
  final String id;
  const SimilarMaterialsArea({super.key, required this.subcategory, required this.id,});

  @override
  State<SimilarMaterialsArea> createState() => _SimilarMaterialsAreaState();
}

class _SimilarMaterialsAreaState extends State<SimilarMaterialsArea> {
  final MaterialServices _materialService = MaterialServices();
  late Future<List<MaterialModel>> _materialsFuture;

  @override
  void initState() {
    super.initState();
    _materialsFuture = _materialService.fetchSimilarMaterials(
      subcategory: widget.subcategory,
      id: widget.id,
    );
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Benzer Materyaller',
          style: AppTextStyles.h3.copyWith(color: AppColors.xanthous),
        ),
        const SizedBox(height: 10),
        FutureBuilder<List<MaterialModel>>(
          future: _materialsFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CustomCircularIndicator();
            }
            if (snapshot.hasError) {
              debugPrint(snapshot.error.toString());
              return Text("Hata: ${snapshot.error}");
            }
            if (!snapshot.hasData || snapshot.data == null) {
              return const Text("Benzer materyal bulunamadı.");
            }

            final List<MaterialModel> materials = snapshot.data!;

            return buildSimilarList(size: size, materials: materials);
          },
        ),
      ],
    );
  }

  SingleChildScrollView buildSimilarList({
    required List<MaterialModel> materials,
    required Size size,
  }) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SizedBox(
        height: size.width * 0.65,
        child: ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          scrollDirection: Axis.horizontal,
          separatorBuilder: (_, __) => const SizedBox(width: 10),
          itemCount: materials.length,
          itemBuilder: (context, index) {
            final MaterialModel material = materials[index];
            return Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: MaterialCard(material: material),
            );
          },
        ),
      ),
    );
  }
}

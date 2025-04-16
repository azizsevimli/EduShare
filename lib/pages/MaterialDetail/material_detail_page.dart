import 'package:flutter/material.dart';
import '../../core/widgets/custom_circular_indicator.dart';
import '../../models/material_model.dart';
import '../../services/material_service.dart';
import '../../core/widgets/material_image_area.dart';
import '../../core/widgets/material_info_area.dart';
import '../../core/widgets/similar_materials_area.dart';

class MaterialDetailPage extends StatefulWidget {
  final String materialId;

  const MaterialDetailPage({
    super.key,
    required this.materialId,
  });

  @override
  State<MaterialDetailPage> createState() => _MaterialDetailPageState();
}

class _MaterialDetailPageState extends State<MaterialDetailPage> {
  MaterialServices materialServices = MaterialServices();
  late MaterialModel material;

  @override
  void initState() {
    super.initState();
    materialServices.getMaterialById(id: widget.materialId);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: FutureBuilder<MaterialModel?>(
          future: materialServices.getMaterialById(id: widget.materialId),
          builder: (
            BuildContext context,
            AsyncSnapshot<MaterialModel?> snapshot,
          ) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CustomCircularIndicator(),
              );
            }
            if (snapshot.hasError) {
              return Text("Hata oluştu: ${snapshot.error}");
            }
            if (!snapshot.hasData || snapshot.data == null) {
              return const Text("Ürün bulunamadı");
            }
            material = snapshot.data!;

            return SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MaterialImageArea(
                    id: material.id,
                    imageUrls: material.imageUrls,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MaterialInfoArea(material: material),
                        const SizedBox(height: 20),
                        SimilarMaterialsArea(subcategory: material.subcategory, id: material.id),
                      ],
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

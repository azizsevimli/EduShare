import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import './card_image_area.dart';
import './custom_circular_indicator.dart';
import '../constants/constants.dart';
import '../../models/material_model.dart';
import '../../services/material_service.dart';

class ChatMaterialCard extends StatelessWidget {
  final String materialId;
  final MaterialServices materialService;

  const ChatMaterialCard({
    super.key,
    required this.materialId,
    required this.materialService,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.push('/material-detail/$materialId');
      },
      child: Container(
        height: 80.0,
        width: double.infinity,
        decoration: containerDecoration(),
        child: FutureBuilder<MaterialModel?>(
          future: materialService.getMaterialById(id: materialId),
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
              return const Text("Materyal bulunamadı");
            }
            final material = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10.0,
                vertical: 5.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CardImageArea(urls: material.imageUrls),
                  const SizedBox(width: 10),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(material.title,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyles.h3),
                      Text(
                        material.description,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  BoxDecoration containerDecoration() {
    return const BoxDecoration(
      color: AppColors.white,
      border: Border(
        bottom: BorderSide(
          color: AppColors.black,
          width: 1.0,
        ),
      ),
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(20.0),
        bottomRight: Radius.circular(20.0),
      ),
    );
  }
}

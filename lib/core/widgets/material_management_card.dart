import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import './app_card.dart';
import './custom_button.dart';
import './card_image_area.dart';
import './my_material_info.dart';
import './material_delete_button.dart';
import '../../models/material_model.dart';

class MaterialManagementCard extends StatelessWidget {
  final MaterialModel material;

  const MaterialManagementCard({
    super.key,
    required this.material,
  });

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    void goMaterialEditPage() {
      context.push('/my-materials/edit/${material.id}');
    }

    return AppCard(
      width: size.width,
      height: size.height * 0.15,
      child: buildChild(onRoute: goMaterialEditPage),
    );
  }

  Row buildChild({required Function() onRoute}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          flex: 3,
          child: CardImageArea(urls: material.imageUrls),
        ),
        Expanded(
          flex: 5,
          child: MyMaterialInfo(material: material),
        ),
        if (!material.isSold) ...[
          Flexible(
            flex: 1,
            child: buildButtons(onRoute: onRoute),
          ),
        ]
      ],
    );
  }

  Column buildButtons({required Function() onRoute}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        CustomOutlinedButton(
          onPressed: onRoute,
          icon: Icons.edit_outlined,
        ),
        MaterialDeleteButton(
          title: material.title,
          id: material.id,
          imageCount: material.imageUrls.length,
        ),
      ],
    );
  }
}

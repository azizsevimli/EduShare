import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import './favorite_button.dart';
import '../constants/constants.dart';
import '../../models/material_model.dart';
import '../../core/widgets/card_image_area.dart';

class MaterialCard extends StatefulWidget {
  final MaterialModel material;

  const MaterialCard({
    super.key,
    required this.material,
  });

  @override
  State<MaterialCard> createState() => _MaterialCardState();
}

class _MaterialCardState extends State<MaterialCard> {
  void goMaterialDetailPage() {
    context.push('/material-detail/${widget.material.id}');
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: goMaterialDetailPage,
      child: _buildContainer(
        width: size.width * 0.4,
        height: size.height * 0.3,
        child: _buildColumn(material: widget.material),
      ),
    );
  }

  Widget _buildColumn({required MaterialModel material}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CardImageArea(urls: material.imageUrls),
        _buildRow(
          leftWidget: Expanded(
            child: Text(
              material.title,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyles.body1,
            ),
          ),
          rightWidget: FavoriteButton(id: material.id),
          alignment: MainAxisAlignment.spaceBetween,
        ),
        _buildRow(
          leftWidget: const Icon(Icons.school_outlined, size: 16),
          rightWidget: Expanded(
            child: Text(
              material.category,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyles.body3,
            ),
          ),
          alignment: MainAxisAlignment.start,
        ),
        _buildRow(
          leftWidget: material.isSold
              ? null
              : Text(material.price, style: AppTextStyles.body1),
          rightWidget: material.isSold
              ? Text(
                  "SATILDI",
                  style: AppTextStyles.h3.copyWith(color: AppColors.red),
                )
              : const Icon(Icons.currency_lira, size: 16),
          alignment: material.isSold
              ? MainAxisAlignment.center
              : MainAxisAlignment.end,
        ),
      ],
    );
  }

  Widget _buildRow({
    Widget? leftWidget,
    required Widget rightWidget,
    required MainAxisAlignment alignment,
  }) {
    return Row(
      mainAxisAlignment: alignment,
      children: [
        if (leftWidget != null) leftWidget,
        const SizedBox(width: 5),
        rightWidget,
      ],
    );
  }

  Widget _buildContainer({
    required Widget child,
    required double width,
    required double height,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          width: 0.5,
          color: AppColors.rose,
        ),
      ),
      width: width,
      height: height,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: child,
      ),
    );
  }
}

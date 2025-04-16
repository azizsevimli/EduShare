import 'package:flutter/cupertino.dart';

import '../../models/material_model.dart';
import '../constants/constants.dart';
import 'outline_label.dart';

class MyMaterialInfo extends StatelessWidget {
  final MaterialModel material;

  const MyMaterialInfo({super.key, required this.material});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            material.title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyles.h3.copyWith(
              color: AppColors.wine,
            ),
          ),
          Text(
            material.description,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            style: AppTextStyles.body3.copyWith(
              color: AppColors.black,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: OutlineLabel(
                  text: material.category,
                  color: AppColors.lightTiffany,
                ),
              ),
              const SizedBox(width: 10.0),
              Text(
                '${material.price} TL',
                style: AppTextStyles.body2.copyWith(
                  color: AppColors.tiffany,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(width: 10.0),
            ],
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../constants/constants.dart';

class SimilarMaterialsArea extends StatelessWidget {
  final String department;

  const SimilarMaterialsArea({
    super.key,
    required this.department,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Benzer Materyaller',
          style: AppTextStyles.h3.copyWith(color: AppColors.brown),
        ),
        const SizedBox(height: 10),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // TODO: Benzer ürünler listesi eklenecek
              Text('Bu kısıma $department \'a benzer materyaller gelecek'),
            ],
          ),
        ),
      ],
    );
  }
}

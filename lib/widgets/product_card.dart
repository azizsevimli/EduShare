import 'package:flutter/material.dart';
import 'package:edushare/config/theme.dart';

class ProductCardView extends StatelessWidget {
  const ProductCardView({
    super.key,
    required this.screenWidth,
    required this.screenHeight,
  });

  final double screenWidth;
  final double screenHeight;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: screenWidth * 0.45,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(10),
        /*boxShadow: const [
          BoxShadow(
            blurRadius: 5,
            offset: Offset(3, 3),
            color: AppColor.black,
            blurStyle: BlurStyle.normal,
          ),
        ],*/
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            /*----Product-Image----*/
            Container(
              alignment: Alignment.center,
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                color: AppColor.lightBone,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(
                Icons.image,
                size: 100,
              ),
            ),
            const SizedBox(height: 10),
            /*----Product-Name----*/
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Ürün Adı',
                  style: AppTxtStyle.h3.copyWith(fontWeight: FontWeight.w600),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.favorite_outline_rounded,
                  ),
                )
              ],
            ),
            /*----Product-Location----*/
            Row(
              children: [
                const Icon(Icons.location_pin, size: 15),
                Text(
                  'Konum',
                  style: AppTxtStyle.caption.copyWith(
                    decoration: TextDecoration.underline,
                    color: AppColor.gray,
                  ),
                ),
              ],
            ),
            /*----Product-Price----*/
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  '250 TL',
                  style: AppTxtStyle.body.copyWith(fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

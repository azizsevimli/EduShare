import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import './favorite_button.dart';
import '../constants/constants.dart';
import '../../models/product_model.dart';

class ProductCard extends StatefulWidget {
  final ProductModel product;

  const ProductCard({
    super.key,
    required this.product,
  });

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void goProductDetailPage() {
    context.push('/product-detail/${widget.product.id}');
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: goProductDetailPage,
      child: _buildContainer(
        width: size.width * 0.4,
        height: size.height * 0.3,
        child: _buildColumn(product: widget.product),
      ),
    );
  }

  Widget _buildColumn({required ProductModel product}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _buildImage(urls: product.imageUrls),
        _buildRow(
          leftWidget: Expanded(
            child: Text(
              product.title,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyles.body1,
            ),
          ),
          rightWidget: FavoriteButton(id: product.id),
          alignment: MainAxisAlignment.spaceBetween,
        ),
        _buildRow(
          leftWidget: const Icon(Icons.school_outlined, size: 16),
          rightWidget: Expanded(
            child: Text(
              product.department,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyles.body3,
            ),
          ),
          alignment: MainAxisAlignment.start,
        ),
        _buildRow(
          leftWidget: Text(product.price, style: AppTextStyles.body1),
          rightWidget: const Icon(Icons.currency_lira, size: 16),
          alignment: MainAxisAlignment.end,
        ),
      ],
    );
  }

  Widget _buildImage({required List<String> urls}) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: AspectRatio(
            aspectRatio: 1,
            child: PageView.builder(
              controller: _pageController,
              itemCount: urls.length,
              itemBuilder: (context, index) {
                return Image.network(
                  urls[index],
                  fit: BoxFit.cover,
                  width: double.infinity,
                );
              },
            ),
          ),
        ),
        Positioned(
          bottom: 8,
          left: 0,
          right: 0,
          child: Center(
            child: SmoothPageIndicator(
              controller: _pageController,
              count: urls.length,
              effect: const ExpandingDotsEffect(
                activeDotColor: AppColors.vanilla,
                dotColor: AppColors.vanilla,
                dotHeight: 6,
                dotWidth: 6,
                expansionFactor: 2,
              ),
            ),
          ),
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
        boxShadow: const [
          BoxShadow(
            color: AppColors.vanilla,
            blurRadius: 1,
            spreadRadius: 0.1,
            offset: Offset(2, 2),
          ),
        ],
        borderRadius: BorderRadius.circular(15),
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

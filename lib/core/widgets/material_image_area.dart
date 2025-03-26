import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import './favorite_button.dart';
import '../constants/constants.dart';

class MaterialImageArea extends StatelessWidget {
  final String id;
  final List<String> imageUrls;

  const MaterialImageArea({
    super.key,
    required this.id,
    required this.imageUrls,
  });

  @override
  Widget build(BuildContext context) {
    final PageController pageController = PageController();
    final Size size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width,
      height: size.height * 0.3,
      child: Stack(
        children: [
          _buildImageArea(pageController: pageController),
          Positioned(
            top: 0,
            child: _buildIconRow(context: context, size: size),
          ),
          Positioned(
            bottom: 10,
            left: 0,
            right: 0,
            child: _buildIndicator(pageController: pageController),
          ),
        ],
      ),
    );
  }

  PageView _buildImageArea({
    required PageController pageController,
  }) {
    return PageView.builder(
      controller: pageController,
      itemCount: imageUrls.length,
      itemBuilder: (BuildContext context, int index) {
        return Image.network(
          imageUrls[index],
          fit: BoxFit.cover,
        );
      },
    );
  }

  Center _buildIndicator({
    required PageController pageController,
  }) {
    return Center(
      child: SmoothPageIndicator(
        controller: pageController,
        count: imageUrls.length,
        effect: const ExpandingDotsEffect(
          dotWidth: 8,
          dotHeight: 8,
          expansionFactor: 2,
          dotColor: AppColors.vanilla,
          activeDotColor: AppColors.orange,
        ),
      ),
    );
  }

  Widget _buildIconRow({
    required BuildContext context,
    required Size size,
  }) {
    return SizedBox(
      width: size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back),
            color: AppColors.white,
            iconSize: 28,
            onPressed: () => context.pop(),
          ),
          FavoriteButton(id: id),
        ],
      ),
    );
  }
}

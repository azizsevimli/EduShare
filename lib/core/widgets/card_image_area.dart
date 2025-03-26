import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../constants/constants.dart';

class CardImageArea extends StatelessWidget {
  final List<String> urls;

  const CardImageArea({
    super.key,
    required this.urls,
  });

  @override
  Widget build(BuildContext context) {
    final PageController pageController = PageController();

    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: AspectRatio(
            aspectRatio: 1,
            child: PageView.builder(
              controller: pageController,
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
              controller: pageController,
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
}

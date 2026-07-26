import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import 'package:fruit/core/constants/app_colors.dart';

/// Promotional image carousel with animated page-indicator dots.
///
/// Set [enableAutoPlay] to false during widget tests to prevent timer-based
/// hangs when using [WidgetTester.pump] instead of [pumpAndSettle].
class PromoBanner extends StatefulWidget {
  final List<String> bannerPaths;
  final bool enableAutoPlay;

  const PromoBanner({
    super.key,
    required this.bannerPaths,
    this.enableAutoPlay = true,
  });

  @override
  State<PromoBanner> createState() => _PromoBannerState();
}

class _PromoBannerState extends State<PromoBanner> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.sizeOf(context).width;
    // Clamp height so it looks good on phones and tablets alike.
    final double bannerHeight = (screenWidth * 0.46).clamp(150.0, 300.0);

    return Column(
      children: [
        CarouselSlider.builder(
          itemCount: widget.bannerPaths.length,
          itemBuilder: (context, itemIndex, _) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(14),
              child: Image.asset(
                widget.bannerPaths[itemIndex],
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            );
          },
          options: CarouselOptions(
            height: bannerHeight,
            viewportFraction: 0.85,
            autoPlay: widget.enableAutoPlay,
            autoPlayInterval: const Duration(seconds: 4),
            autoPlayAnimationDuration: const Duration(milliseconds: 600),
            autoPlayCurve: Curves.easeInOut,
            enlargeCenterPage: true,
            enlargeFactor: 0.18,
            onPageChanged: (index, _) => setState(() => _currentIndex = index),
          ),
        ),
        const SizedBox(height: 10),
        // Animated dot indicators
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(widget.bannerPaths.length, (i) {
            final bool active = _currentIndex == i;
            return AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              margin: const EdgeInsets.symmetric(horizontal: 3),
              width: active ? 22 : 7,
              height: 7,
              decoration: BoxDecoration(
                color: active ? AppColors.primary : AppColors.divider,
                borderRadius: BorderRadius.circular(4),
              ),
            );
          }),
        ),
      ],
    );
  }
}

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import 'package:fruit/core/app_theme.dart';
import 'package:fruit/features/home/home_data.dart';

class PromoBanner extends StatefulWidget {
  final List<BannerItem> bannerItems;
  final bool enableAutoPlay;

  const PromoBanner({
    super.key,
    required this.bannerItems,
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
    final bool isTabletOrWider = screenWidth >= tabletBreakpoint;

    final double bannerHeight = isTabletOrWider
        ? (screenWidth * 0.35).clamp(260.0, 300.0)
        : (screenWidth * 0.46).clamp(150.0, 200.0);

    final double headlineSize = isTabletOrWider ? 17.0 : 13.0;
    final double subtextSize = isTabletOrWider ? 13.0 : 11.0;

    return Column(
      children: [
        CarouselSlider.builder(
          itemCount: widget.bannerItems.length,
          itemBuilder: (context, itemIndex, _) {
            final item = widget.bannerItems[itemIndex];
            return ClipRRect(
              borderRadius: BorderRadius.circular(14),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(item.imagePath, fit: BoxFit.cover),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [
                            Colors.black.withValues(alpha: 0.62),
                            Colors.transparent,
                          ],
                          stops: const [0.0, 0.75],
                        ),
                      ),
                      padding: EdgeInsets.fromLTRB(
                        isTabletOrWider ? 20 : 14,
                        isTabletOrWider ? 28 : 20,
                        isTabletOrWider ? 20 : 14,
                        isTabletOrWider ? 18 : 14,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            item.headline,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: headlineSize,
                              fontWeight: FontWeight.bold,
                              shadows: const [
                                Shadow(color: Colors.black38, blurRadius: 4),
                              ],
                            ),
                          ),
                          const SizedBox(height: 3),
                          Text(
                            item.subtext,
                            style: TextStyle(
                              color: Colors.white.withValues(alpha: 0.92),
                              fontSize: subtextSize,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
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
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(widget.bannerItems.length, (i) {
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

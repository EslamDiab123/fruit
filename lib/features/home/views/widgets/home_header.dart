import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:fruit/core/app_theme.dart';

class GroceryHeader extends StatelessWidget {
  final String address;

  const GroceryHeader({super.key, this.address = '61 Hopper Street'});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.sizeOf(context).width;
    final bool isTablet =
        screenWidth >= tabletBreakpoint && screenWidth <= desktopBreakpoint;
    final double hPad = isTablet ? 32.0 : 20.0;
    final double headingSize = isTablet ? 27.0 : 22.0;

    return Padding(
      padding: EdgeInsets.fromLTRB(hPad, 16, hPad, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SvgPicture.asset(
                'assets/icons/Icons (1).svg',
                width: 18,
                height: 18,
              ),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  address,
                  style: AppTextStyles.addressText,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const Icon(
                Icons.keyboard_arrow_down,
                size: 20,
                color: AppColors.textSecondary,
              ),
              const SizedBox(width: 12),
              SvgPicture.asset('assets/icons/Icons.svg', width: 26, height: 26),
            ],
          ),
          const SizedBox(height: 14),
          Text('Good Morning! 👋', style: AppTextStyles.greetingSub),
          const SizedBox(height: 2),
          Text(
            'Find fresh groceries',
            style: AppTextStyles.greeting.copyWith(fontSize: headingSize),
          ),
        ],
      ),
    );
  }
}

class SearchField extends StatelessWidget {
  final ValueChanged<String> onChanged;
  final TextEditingController? controller;

  const SearchField({super.key, required this.onChanged, this.controller});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final horizontalPadding =
        width >= tabletBreakpoint && width <= desktopBreakpoint ? 32.0 : 20.0;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: horizontalPadding,
        vertical: 10,
      ),
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        textInputAction: TextInputAction.search,
        decoration: InputDecoration(
          hintText: 'Search for products…',
          hintStyle: const TextStyle(color: AppColors.textMuted, fontSize: 14),
          prefixIcon: Padding(
            padding: const EdgeInsets.all(12),
            child: SvgPicture.asset(
              'assets/icons/Search.svg',
              width: 20,
              height: 20,
              colorFilter: const ColorFilter.mode(
                AppColors.textMuted,
                BlendMode.srcIn,
              ),
            ),
          ),
          filled: true,
          fillColor: AppColors.cardBackground,
          contentPadding: const EdgeInsets.symmetric(vertical: 14),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
          ),
        ),
      ),
    );
  }
}

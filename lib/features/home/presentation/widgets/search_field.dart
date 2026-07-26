import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:fruit/core/constants/app_breakpoints.dart';
import 'package:fruit/core/constants/app_colors.dart';

/// A styled search input that calls [onChanged] on every keystroke.
///
/// Pass a [controller] when you need to read or clear the value externally.
/// Horizontal padding scales up to 32 px on tablets.
class SearchField extends StatelessWidget {
  final ValueChanged<String> onChanged;
  final TextEditingController? controller;

  const SearchField({super.key, required this.onChanged, this.controller});

  @override
  Widget build(BuildContext context) {
    final double w = MediaQuery.sizeOf(context).width;
    final double hPad = w >= AppBreakpoints.tablet ? 32.0 : 20.0;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: hPad, vertical: 10),
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

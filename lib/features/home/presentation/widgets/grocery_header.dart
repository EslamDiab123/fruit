import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:fruit/core/constants/app_colors.dart';
import 'package:fruit/core/constants/app_text_styles.dart';

/// App-bar replacement for the Home Page.
///
/// Shows the delivery address row and a greeting below it.
class GroceryHeader extends StatelessWidget {
  final String address;

  const GroceryHeader({super.key, this.address = '61 Hopper Street'});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
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
          const Text('Good Morning! 👋', style: AppTextStyles.greetingSub),
          const SizedBox(height: 2),
          const Text('Find fresh groceries', style: AppTextStyles.greeting),
        ],
      ),
    );
  }
}

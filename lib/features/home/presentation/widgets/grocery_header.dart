import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:fruit/core/constants/app_breakpoints.dart';
import 'package:fruit/core/constants/app_colors.dart';
import 'package:fruit/core/constants/app_text_styles.dart';

/// App-bar replacement for the Home Page.
///
/// Shows the delivery address row and a greeting below it.
/// Typography and padding scale up on tablet (≥ 600 px).
class GroceryHeader extends StatelessWidget {
  final String address;

  const GroceryHeader({super.key, this.address = '61 Hopper Street'});

  @override
  Widget build(BuildContext context) {
    final double w = MediaQuery.sizeOf(context).width;
    final bool isTabletOrWider = w >= AppBreakpoints.tablet;
    final double hPad = isTabletOrWider ? 32.0 : 20.0;

    return Padding(
      padding: EdgeInsets.fromLTRB(hPad, 16, hPad, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SvgPicture.asset(
                'assets/icons/Icons (1).svg',
                width: isTabletOrWider ? 20 : 18,
                height: isTabletOrWider ? 20 : 18,
              ),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  address,
                  style: AppTextStyles.addressText.copyWith(
                    fontSize: isTabletOrWider ? 16.0 : 15.0,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const Icon(
                Icons.keyboard_arrow_down,
                size: 20,
                color: AppColors.textSecondary,
              ),
              const SizedBox(width: 12),
              SvgPicture.asset(
                'assets/icons/Icons.svg',
                width: isTabletOrWider ? 30 : 26,
                height: isTabletOrWider ? 30 : 26,
              ),
            ],
          ),
          const SizedBox(height: 14),
          Text(
            'Good Morning! 👋',
            style: AppTextStyles.greetingSub.copyWith(
              fontSize: isTabletOrWider ? 16.0 : 14.0,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            'Find fresh groceries',
            style: AppTextStyles.greeting.copyWith(
              fontSize: isTabletOrWider ? 27.0 : 22.0,
            ),
          ),
        ],
      ),
    );
  }
}

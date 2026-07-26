import 'package:flutter/material.dart';

import 'package:fruit/core/constants/app_breakpoints.dart';
import 'package:fruit/core/constants/app_text_styles.dart';

/// A row containing a bold section title and an optional "See all" action.
///
/// Font size and horizontal padding scale up on tablets.
class SectionHeader extends StatelessWidget {
  final String title;
  final String actionLabel;
  final VoidCallback? onActionTap;

  const SectionHeader({
    super.key,
    required this.title,
    this.actionLabel = 'See all',
    this.onActionTap,
  });

  @override
  Widget build(BuildContext context) {
    final double w = MediaQuery.sizeOf(context).width;
    final bool isTabletOrWider = w >= AppBreakpoints.tablet;
    final double hPad = isTabletOrWider ? 32.0 : 20.0;
    final double fontSize = isTabletOrWider ? 19.0 : 16.0;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: hPad, vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Text(
              title,
              style: AppTextStyles.sectionTitle.copyWith(fontSize: fontSize),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          if (onActionTap != null)
            GestureDetector(
              onTap: onActionTap,
              behavior: HitTestBehavior.opaque,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 2),
                child: Text(actionLabel, style: AppTextStyles.seeAll),
              ),
            ),
        ],
      ),
    );
  }
}

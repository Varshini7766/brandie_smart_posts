import 'package:flutter/material.dart';

import '../../../common/app_colors.dart';
import '../../../common/app_constants.dart';

class SmartPostIndicators extends StatelessWidget {
  const SmartPostIndicators({
    required this.activeIndex,
    required this.count,
    super.key,
  });

  final int activeIndex;
  final int count;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppConstants.ten,
        vertical: AppConstants.twelve,
      ),
      decoration: BoxDecoration(
        color: AppColors.glass,
        borderRadius: BorderRadius.circular(AppConstants.thirty),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: List<Widget>.generate(
          count,
          (index) => AnimatedContainer(
            duration: AppConstants.pageAnimationDuration,
            width: AppConstants.pageIndicatorSize,
            height: AppConstants.pageIndicatorSize,
            margin: EdgeInsets.only(
              bottom: index == count - 1
                  ? AppConstants.zero
                  : AppConstants.pageIndicatorGap,
            ),
            decoration: BoxDecoration(
              color: index == activeIndex
                  ? AppColors.brandGreen
                  : AppColors.white,
              shape: BoxShape.circle,
            ),
          ),
        ),
      ),
    );
  }
}

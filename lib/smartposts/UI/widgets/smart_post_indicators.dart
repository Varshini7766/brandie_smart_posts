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
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: List<Widget>.generate(
        count,
        (index) => AnimatedContainer(
          duration: AppConstants.pageAnimationDuration,
          width: AppConstants.pageIndicatorSize,
          height: AppConstants.pageIndicatorSize,
          margin: const EdgeInsets.only(bottom: AppConstants.pageIndicatorGap),
          decoration: BoxDecoration(
            color: index == activeIndex
                ? AppColors.brandGreen
                : AppColors.white,
            shape: BoxShape.circle,
          ),
        ),
      ),
    );
  }
}

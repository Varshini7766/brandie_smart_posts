import 'package:flutter/material.dart';

import '../../../common/app_colors.dart';
import '../../../common/app_constants.dart';
import '../../../common/app_strings.dart';

class SmartPostsTabs extends StatelessWidget {
  const SmartPostsTabs({
    required this.activeIndex,
    required this.onSelected,
    super.key,
  });

  final int activeIndex;
  final ValueChanged<int> onSelected;

  static const _labels = <String>[
    AppStrings.smartPost,
    AppStrings.library,
    AppStrings.communities,
    AppStrings.shareAndWin,
  ];
  static const _widths = <double>[
    AppConstants.smartPostTabWidth,
    AppConstants.libraryTabWidth,
    AppConstants.communitiesTabWidth,
    AppConstants.shareAndWinTabWidth,
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppConstants.tabHeight,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppConstants.horizontalPadding,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List<Widget>.generate(
            _labels.length,
            (index) => SizedBox(
              width: _widths[index],
              child: InkWell(
                onTap: () => onSelected(index),
                child: Center(
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      _labels[index],
                      maxLines: AppConstants.singleLine,
                      style: AppTextStyles.tab.copyWith(
                        color: index == activeIndex
                            ? AppColors.brandGreen
                            : AppColors.tabText,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

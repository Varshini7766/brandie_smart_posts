import 'package:flutter/material.dart';

import '../../../common/app_colors.dart';
import '../../../common/app_constants.dart';

class SmartPostsBottomNavigation extends StatelessWidget {
  const SmartPostsBottomNavigation({
    required this.activeIndex,
    required this.onSelected,
    super.key,
  });

  final int activeIndex;
  final ValueChanged<int> onSelected;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppConstants.bottomNavigationHeight,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          Align(
            alignment: Alignment.topCenter,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List<Widget>.generate(
                AppAssets.bottomNavigationIcons.length,
                (index) => IconButton(
                  onPressed: () => onSelected(index),
                  icon: Semantics(
                    selected: index == activeIndex,
                    child: SizedBox.square(
                      dimension: AppConstants.navIconSize,
                      child: Image.asset(
                        AppAssets.bottomNavigationIcons[index],
                        fit: BoxFit.contain,
                        filterQuality: FilterQuality.high,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Container(
            width: AppConstants.homeIndicatorWidth,
            height: AppConstants.homeIndicatorHeight,
            margin: const EdgeInsets.only(bottom: AppConstants.two),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(AppConstants.two),
            ),
          ),
        ],
      ),
    );
  }
}

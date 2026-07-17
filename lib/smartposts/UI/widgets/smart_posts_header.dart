import 'package:flutter/material.dart';

import '../../../common/app_colors.dart';
import '../../../common/app_constants.dart';

class SmartPostsHeader extends StatelessWidget {
  const SmartPostsHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppConstants.headerHeight,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          SizedBox(
            width: AppConstants.headerLogoWidth,
            height: AppConstants.headerLogoHeight,
            child: Image.asset(
              AppAssets.headerLogo,
              fit: BoxFit.contain,
              filterQuality: FilterQuality.high,
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Container(
              width: AppConstants.headerIconSize,
              height: AppConstants.headerIconSize,
              decoration: const BoxDecoration(
                color: AppColors.cameraGreen,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.camera_alt,
                color: AppColors.white,
                size: AppConstants.cameraIconSize,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

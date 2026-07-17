import 'package:flutter/material.dart';

import '../../common/app_colors.dart';
import '../../common/app_constants.dart';
import '../../common/app_strings.dart';
import '../models/smart_post.dart';

class SocialSplashScreen extends StatelessWidget {
  const SocialSplashScreen({required this.platform, super.key});

  final SharePlatform platform;

  bool get _isMetaPlatform =>
      platform.name == AppStrings.instagram ||
      platform.name == AppStrings.instagramStories ||
      platform.name == AppStrings.facebook ||
      platform.name == AppStrings.facebookStories ||
      platform.name == AppStrings.messenger ||
      platform.name == AppStrings.whatsApp ||
      platform.name == AppStrings.whatsAppBusiness;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Center(
              child: Semantics(
                label: platform.name,
                image: true,
                child: Image.asset(
                  platform.assetPath,
                  width: AppConstants.socialSplashIconSize,
                  height: AppConstants.socialSplashIconSize,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            if (_isMetaPlatform)
              Positioned(
                left: AppConstants.zero,
                right: AppConstants.zero,
                bottom: AppConstants.socialSplashFooterBottom,
                child: Column(
                  children: <Widget>[
                    Text(
                      AppStrings.from,
                      style: AppTextStyles.label.copyWith(
                        color: AppColors.shareLoadingText,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      AppStrings.meta,
                      style: AppTextStyles.bodyBold.copyWith(
                        color: AppColors.metaRed,
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}

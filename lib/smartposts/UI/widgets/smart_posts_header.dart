import 'package:flutter/material.dart';

import '../../../common/app_colors.dart';
import '../../../common/app_constants.dart';
import '../../../common/app_strings.dart';

class SmartPostsHeader extends StatelessWidget {
  const SmartPostsHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppConstants.headerHeight,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Align(
            alignment: Alignment.centerLeft,
            child: _HeaderAction(
              label: AppStrings.assistant,
              icon: Icons.circle_outlined,
              showAiBadge: true,
            ),
          ),
          SizedBox(
            width: AppConstants.headerLogoWidth,
            height: AppConstants.headerLogoHeight,
            child: ClipRect(
              child: Transform.translate(
                offset: const Offset(
                  AppConstants.zero,
                  AppConstants.headerLogoCropOffset,
                ),
                child: ColorFiltered(
                  colorFilter: const ColorFilter.mode(
                    AppColors.black,
                    BlendMode.srcIn,
                  ),
                  child: Image.asset(
                    AppAssets.oriflameLogo,
                    width: AppConstants.headerLogoSourceSize,
                    height: AppConstants.headerLogoSourceSize,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
          ),
          const Align(
            alignment: Alignment.centerRight,
            child: _HeaderAction(
              label: AppStrings.camera,
              icon: Icons.camera_alt_outlined,
            ),
          ),
        ],
      ),
    );
  }
}

class _HeaderAction extends StatelessWidget {
  const _HeaderAction({
    required this.label,
    required this.icon,
    this.showAiBadge = false,
  });

  final String label;
  final IconData icon;
  final bool showAiBadge;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: AppConstants.ninety,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Stack(
            clipBehavior: Clip.none,
            children: <Widget>[
              Container(
                width: AppConstants.headerIconSize,
                height: AppConstants.headerIconSize,
                decoration: const BoxDecoration(
                  color: AppColors.black,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  color: AppColors.white,
                  size: AppConstants.twentyFour,
                ),
              ),
              if (showAiBadge)
                Positioned(
                  right: -AppConstants.six,
                  top: -AppConstants.six,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppConstants.four,
                    ),
                    decoration: BoxDecoration(
                      gradient: AppColors.assistantGradient,
                      borderRadius: BorderRadius.circular(
                        AppConstants.glassRadius,
                      ),
                    ),
                    child: const Text(
                      AppStrings.ai,
                      style: TextStyle(
                        color: AppColors.white,
                        fontSize: AppConstants.eight,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: AppConstants.four),
          Text(
            label,
            maxLines: AppConstants.singleLine,
            softWrap: false,
            overflow: TextOverflow.visible,
            style: AppTextStyles.headerLabel.copyWith(
              color: AppColors.mutedText,
            ),
          ),
        ],
      ),
    );
  }
}

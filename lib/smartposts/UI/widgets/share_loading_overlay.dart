import 'dart:ui';

import 'package:flutter/material.dart';

import '../../../common/app_colors.dart';
import '../../../common/app_constants.dart';
import '../../../common/app_strings.dart';

class ShareLoadingOverlay extends StatelessWidget {
  const ShareLoadingOverlay({required this.step, super.key});

  final int step;

  static const _labels = <String>[
    AppStrings.shareLoadingSalesLink,
    AppStrings.shareLoadingCaption,
    AppStrings.shareLoadingProfile,
    AppStrings.shareLoadingSocial,
  ];

  @override
  Widget build(BuildContext context) {
    final activeStep = step.clamp(0, _labels.length - 1);
    final progress = (activeStep + 1) / _labels.length;

    return Positioned.fill(
      child: AbsorbPointer(
        child: ClipRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: AppConstants.shareLoadingBlurSigma,
              sigmaY: AppConstants.shareLoadingBlurSigma,
            ),
            child: ColoredBox(
              color: AppColors.shareLoadingOverlay,
              child: Center(
                child: Container(
                  width: AppConstants.shareLoadingDialogWidth,
                  height: AppConstants.shareLoadingDialogHeight,
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(
                      AppConstants.shareLoadingDialogRadius,
                    ),
                    boxShadow: const <BoxShadow>[
                      BoxShadow(
                        color: AppColors.overlay,
                        blurRadius: AppConstants.twelve,
                        offset: Offset(AppConstants.zero, AppConstants.four),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const SizedBox(
                        width: AppConstants.shareLoadingSpinnerSize,
                        height: AppConstants.shareLoadingSpinnerSize,
                        child: CircularProgressIndicator(
                          strokeWidth: AppConstants.four,
                          color: AppColors.shareLoadingProgress,
                          backgroundColor: AppColors.shareLoadingTrack,
                        ),
                      ),
                      const SizedBox(height: AppConstants.eight),
                      AnimatedSwitcher(
                        duration: AppConstants.pageAnimationDuration,
                        child: Text(
                          _labels[activeStep],
                          key: ValueKey<int>(activeStep),
                          style: AppTextStyles.label.copyWith(
                            color: AppColors.shareLoadingText,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      const SizedBox(height: AppConstants.eight),
                      Container(
                        width: AppConstants.shareLoadingProgressWidth,
                        height: AppConstants.shareLoadingProgressHeight,
                        decoration: BoxDecoration(
                          color: AppColors.shareLoadingTrack,
                          borderRadius: BorderRadius.circular(
                            AppConstants.shareLoadingProgressHeight,
                          ),
                        ),
                        alignment: Alignment.centerLeft,
                        child: AnimatedFractionallySizedBox(
                          duration: AppConstants.shareLoadingStepDuration,
                          curve: Curves.easeInOut,
                          widthFactor: progress,
                          child: Container(
                            decoration: BoxDecoration(
                              color: AppColors.shareLoadingProgress,
                              borderRadius: BorderRadius.circular(
                                AppConstants.shareLoadingProgressHeight,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
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

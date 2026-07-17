import 'package:flutter/material.dart';

import '../../../common/app_colors.dart';
import '../../../common/app_constants.dart';
import '../../../common/app_strings.dart';

class SmartPostsLoadingView extends StatelessWidget {
  const SmartPostsLoadingView({required this.completedSteps, super.key});

  final int completedSteps;

  static const _steps = <String>[
    AppStrings.loadingPopular,
    AppStrings.loadingCaption,
    AppStrings.loadingReferral,
    AppStrings.loadingMusic,
  ];

  @override
  Widget build(BuildContext context) {
    final allComplete = completedSteps >= _steps.length;
    return ColoredBox(
      color: AppColors.white,
      child: Center(
        child: SizedBox(
          width: AppConstants.loadingDialogWidth,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const Text(
                AppStrings.loadingTitle,
                textAlign: TextAlign.center,
                style: AppTextStyles.loadingTitle,
              ),
              const SizedBox(height: AppConstants.thirty),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppConstants.thirty,
                ),
                child: Column(
                  children: <Widget>[
                    for (var index = 0; index < _steps.length; index++)
                      Padding(
                        padding: const EdgeInsets.only(
                          bottom: AppConstants.loadingStepGap,
                        ),
                        child: _LoadingStep(
                          label: _steps[index],
                          isComplete: index < completedSteps,
                          isActive: index == completedSteps && !allComplete,
                        ),
                      ),
                    AnimatedOpacity(
                      opacity: allComplete
                          ? AppConstants.one
                          : AppConstants.zero,
                      duration: AppConstants.pageAnimationDuration,
                      child: const Text(
                        AppStrings.allSet,
                        textAlign: TextAlign.center,
                        style: AppTextStyles.productTitle,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _LoadingStep extends StatelessWidget {
  const _LoadingStep({
    required this.label,
    required this.isComplete,
    required this.isActive,
  });

  final String label;
  final bool isComplete;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        SizedBox(
          width: AppConstants.loadingIconSize,
          height: AppConstants.loadingIconSize,
          child: isComplete
              ? const Icon(
                  Icons.check_circle,
                  color: AppColors.brandGreen,
                  size: AppConstants.loadingIconSize,
                )
              : isActive
              ? const CircularProgressIndicator(
                  strokeWidth: AppConstants.two,
                  color: AppColors.black,
                )
              : const Icon(
                  Icons.radio_button_unchecked,
                  color: AppColors.loadingTrack,
                  size: AppConstants.loadingIconSize,
                ),
        ),
        const SizedBox(width: AppConstants.eight),
        Expanded(child: Text(label, style: AppTextStyles.tab)),
      ],
    );
  }
}

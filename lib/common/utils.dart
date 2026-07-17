import 'package:flutter/material.dart';

import 'app_constants.dart';
import 'app_strings.dart';

abstract final class AppUtils {
  static double widthScale(BuildContext context) {
    return MediaQuery.sizeOf(context).width / AppConstants.referenceWidth;
  }

  static double scaled(BuildContext context, double value) {
    return value * widthScale(context);
  }

  static void showFeedback(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(message),
          duration: AppConstants.feedbackDuration,
        ),
      );
  }

  static String captionCharacterCount(int currentLength) {
    return '$currentLength'
        '${AppStrings.captionCharacterSeparator}'
        '${AppConstants.captionMaxLength}';
  }

  static String clampCaption(String caption) {
    if (caption.length <= AppConstants.captionMaxLength) {
      return caption;
    }
    return caption.substring(0, AppConstants.captionMaxLength);
  }

  /// Keeps the mandatory referral lines as part of caption content and the
  /// 2200-character budget. Body text is trimmed first if needed.
  static String ensureReferralSuffix(String caption) {
    final suffix = AppStrings.referralSuffix;
    var body = caption;
    final referralIndex = body.lastIndexOf(AppStrings.referralCode);
    if (referralIndex != -1) {
      body = body.substring(0, referralIndex).trimRight();
    }

    final maxBodyLength = AppConstants.captionMaxLength - suffix.length;
    if (body.length > maxBodyLength) {
      body = body.substring(0, maxBodyLength).trimRight();
    }

    return '$body$suffix';
  }
}

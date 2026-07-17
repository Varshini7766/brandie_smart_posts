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

  static String captionPreview(String caption) {
    if (caption.length <= AppConstants.captionPreviewLength) {
      return caption;
    }
    return caption.substring(0, AppConstants.captionPreviewLength).trimRight();
  }
}

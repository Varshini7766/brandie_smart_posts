import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_constants.dart';

abstract final class AppTheme {
  static ThemeData get light {
    return ThemeData(
      useMaterial3: true,
      fontFamily: AppAssets.fontFamily,
      fontFamilyFallback: AppAssets.fontFamilyFallback,
      scaffoldBackgroundColor: AppColors.white,
      colorScheme: const ColorScheme.light(
        primary: AppColors.brandGreen,
        surface: AppColors.white,
        onSurface: AppColors.black,
      ),
      splashFactory: InkSparkle.splashFactory,
      textSelectionTheme: const TextSelectionThemeData(
        cursorColor: AppColors.brandGreen,
        selectionColor: Color(0x555BC98B),
      ),
    );
  }
}

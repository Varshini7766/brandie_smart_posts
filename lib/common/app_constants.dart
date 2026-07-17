import 'package:flutter/material.dart';

import 'app_colors.dart';

abstract final class AppConstants {
  static const referenceWidth = 375.0;
  static const referenceHeight = 812.0;
  static const headerHeight = 59.0;
  static const tabHeight = 46.0;
  static const smartPostTabWidth = 67.0;
  static const libraryTabWidth = 46.0;
  static const communitiesTabWidth = 82.0;
  static const shareAndWinTabWidth = 74.0;
  static const bottomNavigationHeight = 68.0;
  static const horizontalPadding = 16.0;
  static const contentWidth = 343.0;
  static const profileSize = 44.0;
  static const statusBadgeHeight = 20.0;
  static const statusBadgeRadius = 15.0;
  static const socialIconSize = 32.0;
  static const socialIconInnerSize = 21.0;
  static const socialIconGap = 12.0;
  static const quickShareTrailingPadding = 32.0;
  static const storyRingWidth = 1.7;
  static const pageIndicatorSize = 10.0;
  static const pageIndicatorGap = 8.0;
  static const glassRadius = 8.0;
  static const productImageSize = 40.0;
  static const shareModeHeight = 30.0;
  static const shareModeGap = 4.0;
  static const shareModeRadius = 18.0;
  static const shareModeIconSize = 16.0;
  static const suggestionProfileSize = 26.0;
  static const captionCardHeight = 126.0;
  static const captionPreviewLines = 8;
  static const contentCardGap = 4.0;
  static const contentBottomOffset = 132.0;
  static const shareRowBottomOffset = 83.0;
  static const postCounterTop = 16.0;
  static const postCounterRight = 16.0;
  static const indicatorRight = 16.0;
  static const headerIconSize = 40.0;
  static const cameraIconSize = 32.0;
  static const headerLogoWidth = 117.0;
  static const headerLogoHeight = 32.0;
  static const navIconSize = 32.0;
  static const homeIndicatorWidth = 117.0;
  static const homeIndicatorHeight = 3.0;
  static const loadingDialogWidth = 274.0;
  static const loadingDialogTop = 52.0;
  static const loadingStepGap = 18.0;
  static const loadingIconSize = 20.0;
  static const shareLoadingDialogWidth = 220.0;
  static const shareLoadingDialogHeight = 96.0;
  static const shareLoadingDialogRadius = 4.0;
  static const shareLoadingSpinnerSize = 32.0;
  static const shareLoadingProgressWidth = 106.0;
  static const shareLoadingProgressHeight = 5.0;
  static const shareLoadingBlurSigma = 8.0;
  static const socialSplashIconSize = 64.0;
  static const socialSplashFooterBottom = 42.0;
  static const editorHorizontalPadding = 16.0;
  static const editorHeaderHeight = 56.0;
  static const editorCaptionMinHeight = 160.0;
  static const editorSheetRadius = 16.0;
  static const editorSheetMaxHeightFactor = 0.72;
  static const editorBodyLineHeight = 20 / 14;
  static const saveButtonWidth = 56.0;
  static const saveButtonHeight = 28.0;
  // Instagram caption character limit used for the editor counter.
  static const captionMaxLength = 2200;
  static const captionNearLimitThreshold = 100;
  static const captionCollapsedLines = 2;
  static const singleLine = 1;
  static const animationSteps = 4;
  static const zero = 0.0;
  static const one = 1.0;
  static const two = 2.0;
  static const four = 4.0;
  static const six = 6.0;
  static const eight = 8.0;
  static const ten = 10.0;
  static const twelve = 12.0;
  static const fourteen = 14.0;
  static const sixteen = 16.0;
  static const eighteen = 18.0;
  static const twenty = 20.0;
  static const twentyFour = 24.0;
  static const thirty = 30.0;
  static const forty = 40.0;
  static const fortyEight = 48.0;
  static const fiftyTwo = 52.0;
  static const sixty = 60.0;
  static const ninety = 90.0;
  static const defaultTabIndex = 0;
  static const defaultNavigationIndex = 2;
  static const defaultPostIndex = 0;

  static const loadingStepDuration = Duration(milliseconds: 700);
  static const loadingCompletePause = Duration(milliseconds: 800);
  static const shareLoadingStepDuration = Duration(milliseconds: 1200);
  static const introLoaderDuration = Duration(milliseconds: 19270);
  static const productRevealDelay = Duration(seconds: 3);
  static const pageAnimationDuration = Duration(milliseconds: 280);
  static const feedbackDuration = Duration(seconds: 2);
  static const pageScrollPhysics = PageScrollPhysics(
    parent: ClampingScrollPhysics(),
  );
}

abstract final class AppTextStyles {
  static const headerLabel = TextStyle(
    fontSize: 10,
    height: 1,
    leadingDistribution: TextLeadingDistribution.even,
    fontWeight: FontWeight.w400,
  );
  static const tab = TextStyle(
    fontSize: 14,
    height: 1,
    leadingDistribution: TextLeadingDistribution.even,
    fontWeight: FontWeight.w700,
  );
  static const body = TextStyle(
    fontSize: 12,
    height: 1,
    leadingDistribution: TextLeadingDistribution.even,
    fontWeight: FontWeight.w400,
  );
  static const bodyBold = TextStyle(
    fontSize: 12,
    height: 1,
    leadingDistribution: TextLeadingDistribution.even,
    fontWeight: FontWeight.w700,
  );
  static const captionReferral = TextStyle(
    fontSize: 12,
    height: 1,
    leadingDistribution: TextLeadingDistribution.even,
    fontWeight: FontWeight.w400,
    fontStyle: FontStyle.italic,
  );
  static const label = TextStyle(
    fontSize: 10,
    height: 1.2,
    leadingDistribution: TextLeadingDistribution.even,
    fontWeight: FontWeight.w700,
  );
  static const captionMeta = TextStyle(
    fontSize: 10,
    height: 1,
    leadingDistribution: TextLeadingDistribution.even,
    fontWeight: FontWeight.w400,
  );
  static const captionMetaBold = TextStyle(
    fontSize: 10,
    height: 1,
    leadingDistribution: TextLeadingDistribution.even,
    fontWeight: FontWeight.w700,
  );
  static const productTitle = TextStyle(
    fontSize: 14,
    height: 1,
    leadingDistribution: TextLeadingDistribution.even,
    fontWeight: FontWeight.w700,
  );
  static const editorTitle = TextStyle(
    color: AppColors.editorText,
    fontSize: 20,
    height: 1,
    leadingDistribution: TextLeadingDistribution.even,
    fontWeight: FontWeight.w700,
  );
  static const editorBody = TextStyle(
    color: AppColors.editorText,
    fontSize: 14,
    height: AppConstants.editorBodyLineHeight,
    leadingDistribution: TextLeadingDistribution.even,
    fontWeight: FontWeight.w400,
  );
  static const editorAction = TextStyle(
    color: AppColors.white,
    fontSize: 14,
    height: 1,
    leadingDistribution: TextLeadingDistribution.even,
    fontWeight: FontWeight.w700,
  );
  static const loadingTitle = TextStyle(
    fontSize: 20,
    height: 1,
    leadingDistribution: TextLeadingDistribution.even,
    fontWeight: FontWeight.w700,
  );
}

abstract final class AppTextStruts {
  static const caption = StrutStyle(
    fontFamily: AppAssets.fontFamily,
    fontSize: 12,
    height: 1,
    leadingDistribution: TextLeadingDistribution.even,
    forceStrutHeight: true,
  );

  static const editorBody = StrutStyle(
    fontFamily: AppAssets.fontFamily,
    fontSize: 14,
    height: AppConstants.editorBodyLineHeight,
    leadingDistribution: TextLeadingDistribution.even,
    forceStrutHeight: true,
  );
}

abstract final class AppAssets {
  static const fontFamily = 'Helvetica';
  static const fontFamilyFallback = <String>['Arial', 'sans-serif'];
  static const headerLogo = 'assets/icons/oriflame_logo.png';
  static const bottomNavigationIcons = <String>[
    'assets/icons/nav_offers.png',
    'assets/icons/nav_search.png',
    'assets/icons/nav_home.png',
    'assets/icons/nav_chat.png',
    'assets/icons/nav_profile.png',
  ];
  static const introLoader = 'assets/smart_post_loading_animation.gif';
  static const telegram = 'assets/icons/telegram.png';
  static const messenger = 'assets/icons/messenger.png';
  static const tikTok = 'assets/icons/tiktok.png';
  static const facebook = 'assets/icons/facebook.png';
  static const whatsApp = 'assets/icons/whatsapp.png';
  static const whatsAppBusiness = 'assets/icons/whatsapp_business.png';
  static const instagram = 'assets/icons/instagram.png';
  static const profile = 'assets/images/profile.png';
  static const productThumbnail = 'assets/images/product_thumbnail.png';
  static const lipstickPost = 'assets/images/lipstick_post.jpg';
  static const perfumePost = 'assets/images/perfume_post.jpg';
  static const mascaraPost = 'assets/images/mascara_post.jpg';
}

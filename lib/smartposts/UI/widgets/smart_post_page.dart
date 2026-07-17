import 'package:flutter/material.dart';

import '../../../common/app_colors.dart';
import '../../../common/app_constants.dart';
import '../../../common/app_strings.dart';
import '../../../common/utils.dart';
import '../../../common_widgets/glass_panel.dart';
import '../../models/smart_post.dart';

class SmartPostPage extends StatelessWidget {
  const SmartPostPage({
    required this.post,
    required this.postIndex,
    required this.postCount,
    required this.productVisible,
    required this.onEditCaption,
    required this.onShare,
    required this.onProductTap,
    super.key,
  });

  final SmartPost post;
  final int postIndex;
  final int postCount;
  final bool productVisible;
  final VoidCallback onEditCaption;
  final ValueChanged<String> onShare;
  final VoidCallback onProductTap;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        Image.asset(post.backgroundAsset, fit: BoxFit.cover),
        const DecoratedBox(
          decoration: BoxDecoration(gradient: AppColors.postScrim),
        ),
        Positioned(
          left: AppConstants.horizontalPadding,
          top: AppConstants.horizontalPadding,
          child: _PostIdentity(profileAsset: post.profileAsset),
        ),
        Positioned(
          right: AppConstants.postCounterRight,
          top: AppConstants.postCounterTop,
          child: _PostCounter(current: postIndex + 1, count: postCount),
        ),
        Positioned(
          right: AppConstants.indicatorRight,
          top: AppConstants.indicatorTop,
          child: _PostIndicators(activeIndex: postIndex, count: postCount),
        ),
        Positioned(
          left: AppConstants.horizontalPadding,
          right: AppConstants.horizontalPadding,
          bottom: AppConstants.contentBottomOffset,
          child: _PostDetails(
            post: post,
            productVisible: productVisible,
            onEditCaption: onEditCaption,
            onProductTap: onProductTap,
          ),
        ),
        Positioned(
          left: AppConstants.horizontalPadding,
          right: AppConstants.zero,
          bottom: AppConstants.shareRowBottomOffset,
          child: _QuickShareRow(onShare: onShare),
        ),
      ],
    );
  }
}

class _PostIdentity extends StatelessWidget {
  const _PostIdentity({required this.profileAsset});

  final String profileAsset;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: AppConstants.profileSize,
          height: AppConstants.profileSize,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.white, width: AppConstants.one),
            image: DecorationImage(
              image: AssetImage(profileAsset),
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(width: AppConstants.four),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              height: AppConstants.statusBadgeHeight,
              padding: const EdgeInsets.symmetric(
                horizontal: AppConstants.eight,
                vertical: AppConstants.four,
              ),
              decoration: BoxDecoration(
                color: AppColors.readyPink,
                borderRadius: BorderRadius.circular(
                  AppConstants.statusBadgeRadius,
                ),
              ),
              child: const Row(
                children: <Widget>[
                  Icon(
                    Icons.auto_awesome,
                    size: AppConstants.twelve,
                    color: AppColors.white,
                  ),
                  SizedBox(width: AppConstants.four),
                  Text(
                    AppStrings.readyToShare,
                    style: TextStyle(
                      color: AppColors.white,
                      fontSize: AppConstants.twelve,
                      fontWeight: FontWeight.w700,
                      height: AppConstants.one,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppConstants.four),
            Text(
              AppStrings.communityPerformance,
              style: AppTextStyles.bodyBold.copyWith(color: AppColors.white),
            ),
          ],
        ),
      ],
    );
  }
}

class _PostCounter extends StatelessWidget {
  const _PostCounter({required this.current, required this.count});

  final int current;
  final int count;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppConstants.eight,
        vertical: AppConstants.two,
      ),
      decoration: BoxDecoration(
        color: AppColors.glass,
        borderRadius: BorderRadius.circular(AppConstants.thirty),
      ),
      child: Text(
        '$current ${AppStrings.of} $count',
        style: AppTextStyles.label.copyWith(color: AppColors.white),
      ),
    );
  }
}

class _PostIndicators extends StatelessWidget {
  const _PostIndicators({required this.activeIndex, required this.count});

  final int activeIndex;
  final int count;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List<Widget>.generate(
        count,
        (index) => Container(
          width: AppConstants.pageIndicatorSize,
          height: AppConstants.pageIndicatorSize,
          margin: const EdgeInsets.only(bottom: AppConstants.pageIndicatorGap),
          decoration: BoxDecoration(
            color: index == activeIndex
                ? AppColors.brandGreen
                : AppColors.white,
            shape: BoxShape.circle,
          ),
        ),
      ),
    );
  }
}

class _PostDetails extends StatelessWidget {
  const _PostDetails({
    required this.post,
    required this.productVisible,
    required this.onEditCaption,
    required this.onProductTap,
  });

  final SmartPost post;
  final bool productVisible;
  final VoidCallback onEditCaption;
  final VoidCallback onProductTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        if (post.product != null)
          AnimatedSlide(
            offset: productVisible
                ? Offset.zero
                : const Offset(AppConstants.zero, AppConstants.one),
            duration: AppConstants.pageAnimationDuration,
            child: AnimatedOpacity(
              opacity: productVisible ? AppConstants.one : AppConstants.zero,
              duration: AppConstants.pageAnimationDuration,
              child: _ProductCard(product: post.product!, onTap: onProductTap),
            ),
          ),
        if (post.product != null)
          const SizedBox(height: AppConstants.contentCardGap),
        const _ShareModeSelector(),
        const SizedBox(height: AppConstants.eight),
        _CaptionCard(post: post, onEdit: onEditCaption),
      ],
    );
  }
}

class _ProductCard extends StatelessWidget {
  const _ProductCard({required this.product, required this.onTap});

  final ProductPromotion product;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return IntrinsicWidth(
      child: GlassPanel(
        color: AppColors.productGlass,
        padding: const EdgeInsets.all(AppConstants.six),
        onTap: onTap,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(AppConstants.two),
              child: Image.asset(
                product.imagePath,
                width: AppConstants.productImageSize,
                height: AppConstants.productImageSize,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: AppConstants.four),
            ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: AppConstants.productTextMaxWidth,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    product.name,
                    maxLines: AppConstants.singleLine,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.productTitle.copyWith(
                      color: AppColors.white,
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      Text(
                        product.price,
                        style: AppTextStyles.bodyBold.copyWith(
                          color: AppColors.white,
                        ),
                      ),
                      const SizedBox(width: AppConstants.four),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppConstants.four,
                          vertical: AppConstants.one,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.discountGreen,
                          borderRadius: BorderRadius.circular(
                            AppConstants.four,
                          ),
                        ),
                        child: Text(
                          product.discount,
                          style: AppTextStyles.label.copyWith(
                            color: AppColors.white,
                          ),
                        ),
                      ),
                    ],
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

class _ShareModeSelector extends StatelessWidget {
  const _ShareModeSelector();

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: <Widget>[
        Expanded(
          child: _ShareModePill(
            label: AppStrings.forPost,
            icon: Icons.edit_outlined,
            active: true,
          ),
        ),
        SizedBox(width: AppConstants.shareModeGap),
        Expanded(
          child: _ShareModePill(
            label: AppStrings.forStory,
            icon: Icons.refresh,
          ),
        ),
        SizedBox(width: AppConstants.shareModeGap),
        Expanded(
          child: _ShareModePill(
            label: AppStrings.forMessage,
            icon: Icons.chat_bubble_outline,
          ),
        ),
      ],
    );
  }
}

class _ShareModePill extends StatelessWidget {
  const _ShareModePill({
    required this.label,
    required this.icon,
    this.active = false,
  });

  final String label;
  final IconData icon;
  final bool active;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppConstants.shareModeHeight,
      decoration: BoxDecoration(
        color: active ? AppColors.shareModeActive : AppColors.shareModeInactive,
        borderRadius: BorderRadius.circular(AppConstants.shareModeRadius),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            icon,
            color: AppColors.white,
            size: AppConstants.shareModeIconSize,
          ),
          const SizedBox(width: AppConstants.four),
          Flexible(
            child: Text(
              label,
              maxLines: AppConstants.singleLine,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyles.body.copyWith(color: AppColors.white),
            ),
          ),
        ],
      ),
    );
  }
}

class _CaptionCard extends StatelessWidget {
  const _CaptionCard({required this.post, required this.onEdit});

  final SmartPost post;
  final VoidCallback onEdit;

  @override
  Widget build(BuildContext context) {
    return GlassPanel(
      color: AppColors.captionOverlay,
      padding: const EdgeInsets.all(AppConstants.zero),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text.rich(
            TextSpan(
              children: <InlineSpan>[
                TextSpan(text: AppUtils.captionPreview(post.caption)),
                const TextSpan(text: AppStrings.ellipsis),
                const TextSpan(
                  text: AppStrings.seeMore,
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                    decorationColor: AppColors.white,
                  ),
                ),
              ],
            ),
            maxLines: AppConstants.captionPreviewLines,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyles.body.copyWith(
              color: AppColors.white,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: AppConstants.eight),
          Row(
            children: <Widget>[
              ClipOval(
                child: Image.asset(
                  post.profileAsset,
                  width: AppConstants.suggestionProfileSize,
                  height: AppConstants.suggestionProfileSize,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: AppConstants.four),
              const Icon(
                Icons.music_note,
                color: AppColors.white,
                size: AppConstants.sixteen,
              ),
              Flexible(
                child: Text.rich(
                  TextSpan(
                    children: <InlineSpan>[
                      const TextSpan(text: AppStrings.suggested),
                      TextSpan(
                        text: post.songTitle,
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                      TextSpan(text: post.songArtist),
                    ],
                  ),
                  maxLines: AppConstants.singleLine,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.body.copyWith(color: AppColors.white),
                ),
              ),
              const SizedBox(width: AppConstants.four),
              InkWell(
                onTap: onEdit,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    const Icon(
                      Icons.edit_outlined,
                      color: AppColors.white,
                      size: AppConstants.sixteen,
                    ),
                    const SizedBox(width: AppConstants.four),
                    Text(
                      AppStrings.editCaption,
                      style: AppTextStyles.body.copyWith(
                        color: AppColors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _QuickShareRow extends StatelessWidget {
  const _QuickShareRow({required this.onShare});

  final ValueChanged<String> onShare;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppConstants.socialIconSize,
      child: Row(
        children: <Widget>[
          Text(
            AppStrings.quickShareTo,
            style: AppTextStyles.bodyBold.copyWith(color: AppColors.white),
          ),
          const SizedBox(width: AppConstants.eight),
          Expanded(
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: SmartPostFixtures.sharePlatforms.length,
              separatorBuilder: (_, _) =>
                  const SizedBox(width: AppConstants.socialIconGap),
              itemBuilder: (context, index) {
                final platform = SmartPostFixtures.sharePlatforms[index];
                return Semantics(
                  label: platform.name,
                  button: true,
                  child: InkWell(
                    onTap: () => onShare(platform.name),
                    customBorder: const CircleBorder(),
                    child: Container(
                      width: AppConstants.socialIconSize,
                      height: AppConstants.socialIconSize,
                      padding: EdgeInsets.all(platform.innerPadding),
                      decoration: const BoxDecoration(
                        color: AppColors.socialIconFaded,
                        shape: BoxShape.circle,
                        border: Border.fromBorderSide(
                          BorderSide(color: AppColors.socialIconBorder),
                        ),
                      ),
                      child: Image.asset(platform.assetPath),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

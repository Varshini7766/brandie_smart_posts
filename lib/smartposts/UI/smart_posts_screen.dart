import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../common/app_constants.dart';
import '../../common/app_strings.dart';
import '../../common/utils.dart';
import '../bloc/smart_posts_bloc.dart';
import '../bloc/smart_posts_event.dart';
import '../bloc/smart_posts_state.dart';
import '../models/smart_post.dart';
import 'social_splash_screen.dart';
import 'widgets/caption_editor_sheet.dart';
import 'widgets/share_loading_overlay.dart';
import 'widgets/smart_post_page.dart';
import 'widgets/smart_posts_bottom_navigation.dart';
import 'widgets/smart_posts_header.dart';
import 'widgets/smart_posts_intro_video.dart';
import 'widgets/smart_posts_tabs.dart';

class SmartPostsScreen extends StatefulWidget {
  const SmartPostsScreen({super.key});

  @override
  State<SmartPostsScreen> createState() => _SmartPostsScreenState();
}

class _SmartPostsScreenState extends State<SmartPostsScreen> {
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Widget _carouselItem({required int index, required Widget child}) {
    return AnimatedBuilder(
      animation: _pageController,
      child: child,
      builder: (context, child) {
        final currentPage =
            _pageController.hasClients &&
                _pageController.position.hasContentDimensions
            ? _pageController.page ?? index.toDouble()
            : AppConstants.defaultPostIndex.toDouble();
        final distance = (currentPage - index).abs().clamp(
          AppConstants.zero,
          AppConstants.one,
        );
        final scale =
            (AppConstants.one - (distance * AppConstants.carouselScaleRange))
                .clamp(AppConstants.carouselMinimumScale, AppConstants.one);
        final opacity =
            (AppConstants.one - (distance * AppConstants.carouselOpacityRange))
                .clamp(AppConstants.carouselMinimumOpacity, AppConstants.one);

        return Opacity(
          opacity: opacity,
          child: Transform.scale(scale: scale, child: child),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SmartPostsBloc, SmartPostsState>(
      listenWhen: (previous, current) =>
          previous.shareLaunchStatus != current.shareLaunchStatus,
      listener: (context, state) {
        if (state.shareLaunchStatus != ShareLaunchStatus.ready ||
            state.selectedSharePlatform == null) {
          return;
        }

        final platform = SmartPostFixtures.sharePlatforms.firstWhere(
          (item) => item.name == state.selectedSharePlatform,
        );
        context.read<SmartPostsBloc>().add(const ShareLaunchHandled());
        Navigator.of(context).push(
          MaterialPageRoute<void>(
            builder: (_) => SocialSplashScreen(platform: platform),
          ),
        );
      },
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            SafeArea(
              bottom: false,
              child: Column(
                children: <Widget>[
                  const Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: AppConstants.horizontalPadding,
                    ),
                    child: SmartPostsHeader(),
                  ),
                  BlocSelector<SmartPostsBloc, SmartPostsState, int>(
                    selector: (state) => state.activeTabIndex,
                    builder: (context, activeTabIndex) {
                      return SmartPostsTabs(
                        activeIndex: activeTabIndex,
                        onSelected: (index) {
                          context.read<SmartPostsBloc>().add(
                            SmartPostsTabSelected(index),
                          );
                          if (index != AppConstants.defaultTabIndex) {
                            AppUtils.showFeedback(
                              context,
                              AppStrings.featureOnlyMessage,
                            );
                          }
                        },
                      );
                    },
                  ),
                  Expanded(
                    child: BlocBuilder<SmartPostsBloc, SmartPostsState>(
                      builder: (context, state) {
                        if (state.status != SmartPostsStatus.ready) {
                          return const SizedBox.expand();
                        }

                        return Stack(
                          children: <Widget>[
                            PageView.builder(
                              controller: _pageController,
                              scrollDirection: Axis.vertical,
                              physics: AppConstants.pageScrollPhysics,
                              itemCount: state.posts.length,
                              onPageChanged: (index) => context
                                  .read<SmartPostsBloc>()
                                  .add(SmartPostChanged(index)),
                              itemBuilder: (context, index) {
                                final postPage = SmartPostPage(
                                  post: state.posts[index],
                                  postIndex: index,
                                  postCount: state.posts.length,
                                  productVisible:
                                      state.productVisible &&
                                      index == state.activePostIndex,
                                  onEditCaption: () =>
                                      CaptionEditorSheet.show(context, index),
                                  onShare: (platform) => context
                                      .read<SmartPostsBloc>()
                                      .add(SharePlatformSelected(platform)),
                                  onProductTap: () => AppUtils.showFeedback(
                                    context,
                                    AppStrings.productOpenedMessage,
                                  ),
                                );
                                return _carouselItem(
                                  index: index,
                                  child: postPage,
                                );
                              },
                            ),
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: SmartPostsBottomNavigation(
                                activeIndex: state.activeNavigationIndex,
                                onSelected: (index) {
                                  context.read<SmartPostsBloc>().add(
                                    SmartPostsNavigationSelected(index),
                                  );
                                  if (index !=
                                      AppConstants.defaultNavigationIndex) {
                                    AppUtils.showFeedback(
                                      context,
                                      AppStrings.featureOnlyMessage,
                                    );
                                  }
                                },
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            BlocSelector<
              SmartPostsBloc,
              SmartPostsState,
              (ShareLaunchStatus, int)
            >(
              selector: (state) =>
                  (state.shareLaunchStatus, state.shareLoadingStep),
              builder: (context, shareState) {
                if (shareState.$1 != ShareLaunchStatus.preparing) {
                  return const SizedBox.shrink();
                }
                return ShareLoadingOverlay(step: shareState.$2);
              },
            ),
            BlocSelector<SmartPostsBloc, SmartPostsState, SmartPostsStatus>(
              selector: (state) => state.status,
              builder: (context, status) {
                if (status == SmartPostsStatus.ready) {
                  return const SizedBox.shrink();
                }
                return Positioned.fill(
                  child: SmartPostsIntroVideo(
                    onCompleted: () => context.read<SmartPostsBloc>().add(
                      const SmartPostsIntroCompleted(),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

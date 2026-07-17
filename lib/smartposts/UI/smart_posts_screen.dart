import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../common/app_constants.dart';
import '../../common/app_strings.dart';
import '../../common/utils.dart';
import '../bloc/smart_posts_bloc.dart';
import '../bloc/smart_posts_event.dart';
import '../bloc/smart_posts_state.dart';
import 'widgets/caption_editor_sheet.dart';
import 'widgets/smart_post_page.dart';
import 'widgets/smart_posts_bottom_navigation.dart';
import 'widgets/smart_posts_header.dart';
import 'widgets/smart_posts_loading_view.dart';
import 'widgets/smart_posts_tabs.dart';

class SmartPostsScreen extends StatelessWidget {
  const SmartPostsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
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
                    return SmartPostsLoadingView(
                      completedSteps: state.completedLoadingSteps,
                    );
                  }

                  return Stack(
                    children: <Widget>[
                      PageView.builder(
                        scrollDirection: Axis.vertical,
                        physics: AppConstants.pageScrollPhysics,
                        itemCount: state.posts.length,
                        onPageChanged: (index) => context
                            .read<SmartPostsBloc>()
                            .add(SmartPostChanged(index)),
                        itemBuilder: (context, index) {
                          return SmartPostPage(
                            post: state.posts[index],
                            postIndex: index,
                            postCount: state.posts.length,
                            productVisible:
                                state.productVisible &&
                                index == state.activePostIndex,
                            onEditCaption: () =>
                                CaptionEditorSheet.show(context, index),
                            onShare: (platform) {
                              context.read<SmartPostsBloc>().add(
                                SharePlatformSelected(platform),
                              );
                              AppUtils.showFeedback(
                                context,
                                '${AppStrings.copiedShareMessage} $platform',
                              );
                            },
                            onProductTap: () => AppUtils.showFeedback(
                              context,
                              AppStrings.productOpenedMessage,
                            ),
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
                            if (index != AppConstants.defaultNavigationIndex) {
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
    );
  }
}

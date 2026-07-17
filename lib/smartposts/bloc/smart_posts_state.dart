import 'package:equatable/equatable.dart';

import '../models/smart_post.dart';

enum SmartPostsStatus { initial, loading, ready }

enum ShareLaunchStatus { idle, preparing, ready }

final class SmartPostsState extends Equatable {
  const SmartPostsState({
    required this.status,
    required this.posts,
    required this.activePostIndex,
    required this.completedLoadingSteps,
    required this.productVisible,
    required this.activeTabIndex,
    required this.activeNavigationIndex,
    this.editingPostIndex,
    this.draftCaption = '',
    this.captionDirty = false,
    this.selectedSharePlatform,
    this.shareLaunchStatus = ShareLaunchStatus.idle,
    this.shareLoadingStep = 0,
  });

  factory SmartPostsState.initial() {
    return const SmartPostsState(
      status: SmartPostsStatus.initial,
      posts: SmartPostFixtures.posts,
      activePostIndex: 0,
      completedLoadingSteps: 0,
      productVisible: false,
      activeTabIndex: 0,
      activeNavigationIndex: 2,
    );
  }

  final SmartPostsStatus status;
  final List<SmartPost> posts;
  final int activePostIndex;
  final int completedLoadingSteps;
  final bool productVisible;
  final int activeTabIndex;
  final int activeNavigationIndex;
  final int? editingPostIndex;
  final String draftCaption;
  final bool captionDirty;
  final String? selectedSharePlatform;
  final ShareLaunchStatus shareLaunchStatus;
  final int shareLoadingStep;

  SmartPost get activePost => posts[activePostIndex];
  bool get isEditing => editingPostIndex != null;

  SmartPostsState copyWith({
    SmartPostsStatus? status,
    List<SmartPost>? posts,
    int? activePostIndex,
    int? completedLoadingSteps,
    bool? productVisible,
    int? activeTabIndex,
    int? activeNavigationIndex,
    int? editingPostIndex,
    bool clearEditingPost = false,
    String? draftCaption,
    bool? captionDirty,
    String? selectedSharePlatform,
    bool clearSelectedSharePlatform = false,
    ShareLaunchStatus? shareLaunchStatus,
    int? shareLoadingStep,
  }) {
    return SmartPostsState(
      status: status ?? this.status,
      posts: posts ?? this.posts,
      activePostIndex: activePostIndex ?? this.activePostIndex,
      completedLoadingSteps:
          completedLoadingSteps ?? this.completedLoadingSteps,
      productVisible: productVisible ?? this.productVisible,
      activeTabIndex: activeTabIndex ?? this.activeTabIndex,
      activeNavigationIndex:
          activeNavigationIndex ?? this.activeNavigationIndex,
      editingPostIndex: clearEditingPost
          ? null
          : editingPostIndex ?? this.editingPostIndex,
      draftCaption: draftCaption ?? this.draftCaption,
      captionDirty: captionDirty ?? this.captionDirty,
      selectedSharePlatform: clearSelectedSharePlatform
          ? null
          : selectedSharePlatform ?? this.selectedSharePlatform,
      shareLaunchStatus: shareLaunchStatus ?? this.shareLaunchStatus,
      shareLoadingStep: shareLoadingStep ?? this.shareLoadingStep,
    );
  }

  @override
  List<Object?> get props => <Object?>[
    status,
    posts,
    activePostIndex,
    completedLoadingSteps,
    productVisible,
    activeTabIndex,
    activeNavigationIndex,
    editingPostIndex,
    draftCaption,
    captionDirty,
    selectedSharePlatform,
    shareLaunchStatus,
    shareLoadingStep,
  ];
}

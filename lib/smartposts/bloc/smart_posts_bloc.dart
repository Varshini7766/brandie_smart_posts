import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../common/app_constants.dart';
import '../../common/utils.dart';
import 'smart_posts_event.dart';
import 'smart_posts_state.dart';

final class SmartPostsBloc extends Bloc<SmartPostsEvent, SmartPostsState> {
  SmartPostsBloc() : super(SmartPostsState.initial()) {
    on<SmartPostsStarted>(_onStarted);
    on<SmartPostsIntroCompleted>(_onIntroCompleted);
    on<SmartPostChanged>(_onPostChanged);
    on<SmartPostProductRevealed>(_onProductRevealed);
    on<CaptionEditorOpened>(_onCaptionEditorOpened);
    on<CaptionDraftChanged>(_onCaptionDraftChanged);
    on<CaptionSaved>(_onCaptionSaved);
    on<CaptionEditorClosed>(_onCaptionEditorClosed);
    on<SharePlatformSelected>(_onSharePlatformSelected);
    on<ShareLaunchHandled>(_onShareLaunchHandled);
    on<SmartPostsTabSelected>(_onTabSelected);
    on<SmartPostsNavigationSelected>(_onNavigationSelected);
  }

  /// Survives hot reload so the intro GIF is not replayed until a hot restart.
  static bool introCompletedThisSession = false;

  Timer? _introTimer;
  Timer? _productRevealTimer;

  void _onStarted(SmartPostsStarted event, Emitter<SmartPostsState> emit) {
    _introTimer?.cancel();

    // Skip the intro after it has already played in this Dart isolate. Hot
    // reload can recreate the Bloc, but static state is preserved; hot restart
    // clears it and shows the loader again.
    if (!event.animate || introCompletedThisSession) {
      introCompletedThisSession = true;
      emit(
        state.copyWith(
          status: SmartPostsStatus.ready,
          completedLoadingSteps: AppConstants.animationSteps,
          productVisible: true,
        ),
      );
      return;
    }

    emit(
      state.copyWith(
        status: SmartPostsStatus.loading,
        completedLoadingSteps: 0,
        productVisible: false,
      ),
    );

    // The supplied loader GIF loops forever, so Bloc ends it after one exact
    // 289-frame cycle and reveals the interactive feed.
    _introTimer = Timer(
      AppConstants.introLoaderDuration,
      () => add(const SmartPostsIntroCompleted()),
    );
  }

  void _onIntroCompleted(
    SmartPostsIntroCompleted event,
    Emitter<SmartPostsState> emit,
  ) {
    if (state.status == SmartPostsStatus.ready) return;
    _introTimer?.cancel();
    introCompletedThisSession = true;
    emit(
      state.copyWith(
        status: SmartPostsStatus.ready,
        completedLoadingSteps: AppConstants.animationSteps,
      ),
    );
    _scheduleProductReveal();
  }

  void _onPostChanged(SmartPostChanged event, Emitter<SmartPostsState> emit) {
    emit(state.copyWith(activePostIndex: event.index, productVisible: false));
    _scheduleProductReveal();
  }

  void _scheduleProductReveal() {
    _productRevealTimer?.cancel();
    _productRevealTimer = Timer(
      AppConstants.productRevealDelay,
      () => add(const SmartPostProductRevealed()),
    );
  }

  void _onProductRevealed(
    SmartPostProductRevealed event,
    Emitter<SmartPostsState> emit,
  ) {
    emit(state.copyWith(productVisible: true));
  }

  void _onCaptionEditorOpened(
    CaptionEditorOpened event,
    Emitter<SmartPostsState> emit,
  ) {
    final caption = state.posts[event.postIndex].caption;
    emit(
      state.copyWith(
        editingPostIndex: event.postIndex,
        draftCaption: caption,
        captionDirty: false,
      ),
    );
  }

  void _onCaptionDraftChanged(
    CaptionDraftChanged event,
    Emitter<SmartPostsState> emit,
  ) {
    final editingIndex = state.editingPostIndex;
    if (editingIndex == null) return;

    // Clamp to Instagram's caption limit so the draft and counter stay aligned.
    final caption = AppUtils.clampCaption(event.caption);

    emit(
      state.copyWith(
        draftCaption: caption,
        captionDirty: caption != state.posts[editingIndex].caption,
      ),
    );
  }

  void _onCaptionSaved(CaptionSaved event, Emitter<SmartPostsState> emit) {
    final editingIndex = state.editingPostIndex;
    if (editingIndex == null || !state.captionDirty) return;

    final updatedPosts = List.of(state.posts);
    updatedPosts[editingIndex] = updatedPosts[editingIndex].copyWith(
      caption: state.draftCaption,
    );
    emit(
      state.copyWith(
        posts: List.unmodifiable(updatedPosts),
        captionDirty: false,
      ),
    );
  }

  void _onCaptionEditorClosed(
    CaptionEditorClosed event,
    Emitter<SmartPostsState> emit,
  ) {
    emit(
      state.copyWith(
        clearEditingPost: true,
        draftCaption: '',
        captionDirty: false,
      ),
    );
  }

  Future<void> _onSharePlatformSelected(
    SharePlatformSelected event,
    Emitter<SmartPostsState> emit,
  ) async {
    emit(
      state.copyWith(
        selectedSharePlatform: event.platformName,
        shareLaunchStatus: ShareLaunchStatus.preparing,
        shareLoadingStep: 0,
      ),
    );

    // Quick Share prepares local content in the same staged order as the
    // prototype before handing control to the selected social application.
    for (var step = 1; step < AppConstants.animationSteps; step++) {
      await Future<void>.delayed(AppConstants.shareLoadingStepDuration);
      if (emit.isDone) return;
      emit(state.copyWith(shareLoadingStep: step));
    }

    await Future<void>.delayed(AppConstants.shareLoadingStepDuration);
    if (emit.isDone) return;
    emit(state.copyWith(shareLaunchStatus: ShareLaunchStatus.ready));
  }

  void _onShareLaunchHandled(
    ShareLaunchHandled event,
    Emitter<SmartPostsState> emit,
  ) {
    emit(
      state.copyWith(
        clearSelectedSharePlatform: true,
        shareLaunchStatus: ShareLaunchStatus.idle,
        shareLoadingStep: 0,
      ),
    );
  }

  void _onTabSelected(
    SmartPostsTabSelected event,
    Emitter<SmartPostsState> emit,
  ) {
    emit(state.copyWith(activeTabIndex: event.index));
  }

  void _onNavigationSelected(
    SmartPostsNavigationSelected event,
    Emitter<SmartPostsState> emit,
  ) {
    emit(state.copyWith(activeNavigationIndex: event.index));
  }

  @override
  Future<void> close() {
    _introTimer?.cancel();
    _productRevealTimer?.cancel();
    return super.close();
  }
}

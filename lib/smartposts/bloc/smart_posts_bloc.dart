import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../common/app_constants.dart';
import 'smart_posts_event.dart';
import 'smart_posts_state.dart';

final class SmartPostsBloc extends Bloc<SmartPostsEvent, SmartPostsState> {
  SmartPostsBloc() : super(SmartPostsState.initial()) {
    on<SmartPostsStarted>(_onStarted);
    on<SmartPostChanged>(_onPostChanged);
    on<SmartPostProductRevealed>(_onProductRevealed);
    on<CaptionEditorOpened>(_onCaptionEditorOpened);
    on<CaptionDraftChanged>(_onCaptionDraftChanged);
    on<CaptionSaved>(_onCaptionSaved);
    on<CaptionEditorClosed>(_onCaptionEditorClosed);
    on<SharePlatformSelected>(_onSharePlatformSelected);
    on<SmartPostsTabSelected>(_onTabSelected);
    on<SmartPostsNavigationSelected>(_onNavigationSelected);
  }

  Timer? _productRevealTimer;

  Future<void> _onStarted(
    SmartPostsStarted event,
    Emitter<SmartPostsState> emit,
  ) async {
    emit(
      state.copyWith(
        status: SmartPostsStatus.loading,
        completedLoadingSteps: 0,
        productVisible: false,
      ),
    );

    if (!event.animate) {
      emit(
        state.copyWith(
          status: SmartPostsStatus.ready,
          completedLoadingSteps: AppConstants.animationSteps,
          productVisible: true,
        ),
      );
      return;
    }

    // The design communicates personalization through four sequential steps.
    // Keeping this sequence in Bloc makes the UI a pure representation of it.
    for (var step = 1; step <= AppConstants.animationSteps; step++) {
      await Future<void>.delayed(AppConstants.loadingStepDuration);
      if (emit.isDone) return;
      emit(state.copyWith(completedLoadingSteps: step));
    }

    await Future<void>.delayed(AppConstants.loadingCompletePause);
    if (emit.isDone) return;
    emit(state.copyWith(status: SmartPostsStatus.ready));
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
    emit(
      state.copyWith(
        editingPostIndex: event.postIndex,
        draftCaption: state.posts[event.postIndex].caption,
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
    final caption = event.caption.length > AppConstants.captionMaxLength
        ? event.caption.substring(0, AppConstants.captionMaxLength)
        : event.caption;

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

  void _onSharePlatformSelected(
    SharePlatformSelected event,
    Emitter<SmartPostsState> emit,
  ) {
    emit(state.copyWith(selectedSharePlatform: event.platformName));
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
    _productRevealTimer?.cancel();
    return super.close();
  }
}

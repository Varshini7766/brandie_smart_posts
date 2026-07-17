import 'package:equatable/equatable.dart';

sealed class SmartPostsEvent extends Equatable {
  const SmartPostsEvent();

  @override
  List<Object?> get props => const <Object?>[];
}

final class SmartPostsStarted extends SmartPostsEvent {
  const SmartPostsStarted({this.animate = true});

  final bool animate;

  @override
  List<Object?> get props => <Object?>[animate];
}

final class SmartPostsIntroCompleted extends SmartPostsEvent {
  const SmartPostsIntroCompleted();
}

final class SmartPostChanged extends SmartPostsEvent {
  const SmartPostChanged(this.index);

  final int index;

  @override
  List<Object?> get props => <Object?>[index];
}

final class SmartPostProductRevealed extends SmartPostsEvent {
  const SmartPostProductRevealed();
}

final class CaptionEditorOpened extends SmartPostsEvent {
  const CaptionEditorOpened(this.postIndex);

  final int postIndex;

  @override
  List<Object?> get props => <Object?>[postIndex];
}

final class CaptionDraftChanged extends SmartPostsEvent {
  const CaptionDraftChanged(this.caption);

  final String caption;

  @override
  List<Object?> get props => <Object?>[caption];
}

final class CaptionSaved extends SmartPostsEvent {
  const CaptionSaved();
}

final class CaptionEditorClosed extends SmartPostsEvent {
  const CaptionEditorClosed();
}

final class SharePlatformSelected extends SmartPostsEvent {
  const SharePlatformSelected(this.platformName);

  final String platformName;

  @override
  List<Object?> get props => <Object?>[platformName];
}

final class ShareLaunchHandled extends SmartPostsEvent {
  const ShareLaunchHandled();
}

final class SmartPostsTabSelected extends SmartPostsEvent {
  const SmartPostsTabSelected(this.index);

  final int index;

  @override
  List<Object?> get props => <Object?>[index];
}

final class SmartPostsNavigationSelected extends SmartPostsEvent {
  const SmartPostsNavigationSelected(this.index);

  final int index;

  @override
  List<Object?> get props => <Object?>[index];
}

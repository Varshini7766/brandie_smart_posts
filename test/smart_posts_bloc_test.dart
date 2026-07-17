import 'package:brandie_smart_posts_feature/smartposts/bloc/smart_posts_bloc.dart';
import 'package:brandie_smart_posts_feature/smartposts/bloc/smart_posts_event.dart';
import 'package:brandie_smart_posts_feature/smartposts/bloc/smart_posts_state.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  setUp(() {
    SmartPostsBloc.introCompletedThisSession = false;
  });

  group('SmartPostsBloc', () {
    test('can skip animation and expose the ready feed', () async {
      final bloc = SmartPostsBloc();
      addTearDown(bloc.close);

      bloc.add(const SmartPostsStarted(animate: false));
      await bloc.stream.firstWhere(
        (state) => state.status == SmartPostsStatus.ready,
      );

      expect(bloc.state.posts, hasLength(3));
      expect(bloc.state.productVisible, isTrue);
    });

    test('tracks caption changes and saves them locally', () async {
      const updatedCaption = 'Updated interview caption';
      final bloc = SmartPostsBloc();
      addTearDown(bloc.close);

      bloc
        ..add(const CaptionEditorOpened(0))
        ..add(const CaptionDraftChanged(updatedCaption))
        ..add(const CaptionSaved());

      await bloc.stream.firstWhere(
        (state) =>
            state.posts.first.caption == updatedCaption && !state.captionDirty,
      );

      expect(bloc.state.posts.first.caption, updatedCaption);
      expect(bloc.state.captionDirty, isFalse);
    });

    test('prepares content before launching the selected platform', () async {
      final bloc = SmartPostsBloc();
      addTearDown(bloc.close);

      bloc.add(const SharePlatformSelected('Instagram'));

      await bloc.stream.firstWhere(
        (state) => state.shareLaunchStatus == ShareLaunchStatus.ready,
      );

      expect(bloc.state.selectedSharePlatform, 'Instagram');
      expect(bloc.state.shareLoadingStep, 3);
    });

    test('clamps caption drafts to the Instagram character limit', () async {
      final oversizedCaption = 'a' * 2210;
      final bloc = SmartPostsBloc();
      addTearDown(bloc.close);

      bloc
        ..add(const CaptionEditorOpened(0))
        ..add(CaptionDraftChanged(oversizedCaption));

      await bloc.stream.firstWhere(
        (state) => state.draftCaption.length == 2200,
      );

      expect(bloc.state.draftCaption.length, 2200);
      expect(bloc.state.captionDirty, isTrue);
    });
  });
}

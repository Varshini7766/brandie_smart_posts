import 'package:brandie_smart_posts_feature/smartposts/bloc/smart_posts_bloc.dart';
import 'package:brandie_smart_posts_feature/smartposts/bloc/smart_posts_event.dart';
import 'package:brandie_smart_posts_feature/smartposts/bloc/smart_posts_state.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
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
        (state) => state.posts.first.caption == updatedCaption,
      );

      expect(bloc.state.posts.first.caption, updatedCaption);
      expect(bloc.state.captionDirty, isFalse);
    });
  });
}

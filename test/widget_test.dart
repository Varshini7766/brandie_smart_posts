// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:brandie_smart_posts_feature/common/app_strings.dart';
import 'package:brandie_smart_posts_feature/main.dart';
import 'package:brandie_smart_posts_feature/smartposts/bloc/smart_posts_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  setUp(() {
    SmartPostsBloc.introCompletedThisSession = false;
  });

  testWidgets('shows the Figma intro before the Smart Posts feed', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(375, 812);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const BrandieApp());
    await tester.pump();

    expect(find.text(AppStrings.smartPost), findsOneWidget);
    expect(find.text(AppStrings.loadingTitle), findsNothing);

    for (var step = 0; step < 5; step++) {
      await tester.pump(const Duration(seconds: 1));
    }
  });
}

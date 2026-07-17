import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'common/app_strings.dart';
import 'common/app_theme.dart';
import 'smartposts/UI/smart_posts_screen.dart';
import 'smartposts/bloc/smart_posts_bloc.dart';
import 'smartposts/bloc/smart_posts_event.dart';

void main() => runApp(const BrandieApp());

class BrandieApp extends StatelessWidget {
  const BrandieApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppStrings.appName,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      home: BlocProvider<SmartPostsBloc>(
        create: (_) => SmartPostsBloc()..add(const SmartPostsStarted()),
        child: const SmartPostsScreen(),
      ),
    );
  }
}

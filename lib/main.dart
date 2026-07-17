import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'common/app_strings.dart';
import 'common/app_theme.dart';
import 'smartposts/UI/smart_posts_screen.dart';
import 'smartposts/bloc/smart_posts_bloc.dart';
import 'smartposts/bloc/smart_posts_event.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light,
    ),
  );
  runApp(const BrandieApp());
}

class BrandieApp extends StatelessWidget {
  const BrandieApp({super.key});

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

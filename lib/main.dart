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

class BrandieApp extends StatefulWidget {
  const BrandieApp({super.key});

  @override
  State<BrandieApp> createState() => _BrandieAppState();
}

class _BrandieAppState extends State<BrandieApp> {
  late final SmartPostsBloc _smartPostsBloc;

  @override
  void initState() {
    super.initState();
    _smartPostsBloc = SmartPostsBloc()..add(const SmartPostsStarted());
  }

  @override
  void dispose() {
    _smartPostsBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppStrings.appName,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      home: BlocProvider<SmartPostsBloc>.value(
        value: _smartPostsBloc,
        child: const SmartPostsScreen(),
      ),
    );
  }
}

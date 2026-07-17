import 'package:flutter/material.dart';

import '../../../common/app_colors.dart';
import '../../../common/app_constants.dart';

class SmartPostsIntroLoader extends StatefulWidget {
  const SmartPostsIntroLoader({required this.onReducedMotion, super.key});

  final VoidCallback onReducedMotion;

  @override
  State<SmartPostsIntroLoader> createState() => _SmartPostsIntroLoaderState();
}

class _SmartPostsIntroLoaderState extends State<SmartPostsIntroLoader> {
  bool _reducedMotionHandled = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_reducedMotionHandled && MediaQuery.disableAnimationsOf(context)) {
      _reducedMotionHandled = true;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) widget.onReducedMotion();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: AppColors.white,
      child: SizedBox.expand(
        child: Image.asset(
          AppAssets.introLoader,
          fit: BoxFit.cover,
          gaplessPlayback: true,
        ),
      ),
    );
  }
}

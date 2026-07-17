import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../../../common/app_colors.dart';
import '../../../common/app_constants.dart';

class SmartPostsIntroVideo extends StatefulWidget {
  const SmartPostsIntroVideo({required this.onCompleted, super.key});

  final VoidCallback onCompleted;

  @override
  State<SmartPostsIntroVideo> createState() => _SmartPostsIntroVideoState();
}

class _SmartPostsIntroVideoState extends State<SmartPostsIntroVideo> {
  late final VideoPlayerController _controller;
  late final Future<void> _initialization;
  bool _completionSent = false;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset(
      AppAssets.introVideo,
      videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true),
    )..addListener(_handlePlayback);
    _initialization = _controller
        .initialize()
        .then((_) async {
          await _controller.setVolume(AppConstants.zero);
          await _controller.play();
        })
        .catchError((Object _) {
          _complete();
        });
  }

  void _handlePlayback() {
    final value = _controller.value;
    if (!value.isInitialized || value.duration == Duration.zero) return;

    if (value.position >= value.duration) {
      _complete();
    }
  }

  void _complete() {
    if (_completionSent || !mounted) return;
    _completionSent = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) widget.onCompleted();
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (MediaQuery.disableAnimationsOf(context)) {
      _complete();
    }
  }

  @override
  void dispose() {
    _controller
      ..removeListener(_handlePlayback)
      ..dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: AppColors.white,
      child: FutureBuilder<void>(
        future: _initialization,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done ||
              !_controller.value.isInitialized) {
            return const SizedBox.expand();
          }

          final size = _controller.value.size;
          return SizedBox.expand(
            child: FittedBox(
              fit: BoxFit.cover,
              child: SizedBox(
                width: size.width,
                height: size.height,
                child: VideoPlayer(_controller),
              ),
            ),
          );
        },
      ),
    );
  }
}

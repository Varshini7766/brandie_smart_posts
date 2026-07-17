import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/app_colors.dart';
import '../../../common/app_constants.dart';
import '../../../common/app_strings.dart';
import '../../../common/utils.dart';
import '../../bloc/smart_posts_bloc.dart';
import '../../bloc/smart_posts_event.dart';
import '../../bloc/smart_posts_state.dart';

class CaptionEditorSheet extends StatefulWidget {
  const CaptionEditorSheet({super.key});

  static Future<void> show(BuildContext context, int postIndex) {
    final bloc = context.read<SmartPostsBloc>();
    bloc.add(CaptionEditorOpened(postIndex));

    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: AppColors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppConstants.editorSheetRadius),
        ),
      ),
      builder: (sheetContext) {
        return BlocProvider<SmartPostsBloc>.value(
          value: bloc,
          child: Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.viewInsetsOf(sheetContext).bottom,
            ),
            child: const CaptionEditorSheet(),
          ),
        );
      },
    ).whenComplete(() {
      // Keep sheet dismissal and Bloc editing state in sync.
      if (!bloc.isClosed && bloc.state.isEditing) {
        bloc.add(const CaptionEditorClosed());
      }
    });
  }

  @override
  State<CaptionEditorSheet> createState() => _CaptionEditorSheetState();
}

class _CaptionEditorSheetState extends State<CaptionEditorSheet> {
  late final TextEditingController _controller;
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(
      text: context.read<SmartPostsBloc>().state.draftCaption,
    );
    // Open the keypad as soon as the sheet is visible.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _focusNode.requestFocus();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _close() {
    Navigator.of(context).pop();
  }

  void _save() {
    context.read<SmartPostsBloc>().add(const CaptionSaved());
    Navigator.of(context).pop();
  }

  // Keep the controller and Bloc draft on the same hard 2200-char boundary.
  void _onCaptionChanged(String value) {
    final clamped = AppUtils.clampCaption(value);
    if (clamped != _controller.text) {
      _controller.value = TextEditingValue(
        text: clamped,
        selection: TextSelection.collapsed(offset: clamped.length),
      );
    }
    context.read<SmartPostsBloc>().add(CaptionDraftChanged(clamped));
  }

  @override
  Widget build(BuildContext context) {
    final maxSheetHeight =
        MediaQuery.sizeOf(context).height *
        AppConstants.editorSheetMaxHeightFactor;

    return BlocBuilder<SmartPostsBloc, SmartPostsState>(
      builder: (context, state) {
        final characterCount = AppUtils.captionCharacterCount(
          state.draftCaption.length,
        );
        final isNearLimit =
            state.draftCaption.length >=
            (AppConstants.captionMaxLength -
                AppConstants.captionNearLimitThreshold);

        return SizedBox(
          height: maxSheetHeight,
          child: Column(
            children: <Widget>[
              const SizedBox(height: AppConstants.eight),
              Container(
                width: AppConstants.forty,
                height: AppConstants.four,
                decoration: BoxDecoration(
                  color: AppColors.loadingTrack,
                  borderRadius: BorderRadius.circular(AppConstants.two),
                ),
              ),
              SizedBox(
                height: AppConstants.editorHeaderHeight,
                child: Row(
                  children: <Widget>[
                    IconButton(
                      onPressed: _close,
                      icon: const Icon(Icons.close),
                    ),
                    const Expanded(
                      child: Text(
                        AppStrings.editCaption,
                        textAlign: TextAlign.center,
                        style: AppTextStyles.editorTitle,
                      ),
                    ),
                    SizedBox(
                      width: AppConstants.saveButtonWidth,
                      height: AppConstants.saveButtonHeight,
                      child: FilledButton(
                        onPressed: state.captionDirty ? _save : null,
                        style: FilledButton.styleFrom(
                          padding: EdgeInsets.zero,
                          backgroundColor: AppColors.brandGreen,
                          disabledBackgroundColor: AppColors.loadingTrack,
                        ),
                        child: const Text(
                          AppStrings.save,
                          style: AppTextStyles.editorAction,
                        ),
                      ),
                    ),
                    const SizedBox(width: AppConstants.horizontalPadding),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppConstants.editorHorizontalPadding,
                  ),
                  child: TextField(
                    controller: _controller,
                    focusNode: _focusNode,
                    autofocus: true,
                    maxLines: null,
                    expands: true,
                    textAlignVertical: TextAlignVertical.top,
                    inputFormatters: const <TextInputFormatter>[
                      _CaptionLengthLimitingFormatter(),
                    ],
                    style: AppTextStyles.editorBody,
                    strutStyle: AppTextStruts.editorBody,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      isCollapsed: true,
                    ),
                    
                    onChanged: _onCaptionChanged,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(
                  AppConstants.editorHorizontalPadding,
                  AppConstants.eight,
                  AppConstants.editorHorizontalPadding,
                  AppConstants.sixteen,
                ),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    characterCount,
                    style: AppTextStyles.label.copyWith(
                      color: isNearLimit
                          ? AppColors.readyPink
                          : AppColors.mutedText,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

/// Caps by Dart string length so the field, counter, and Bloc stay aligned.
final class _CaptionLengthLimitingFormatter extends TextInputFormatter {
  const _CaptionLengthLimitingFormatter();

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.length <= AppConstants.captionMaxLength) {
      return newValue;
    }

    final clamped = AppUtils.clampCaption(newValue.text);
    return TextEditingValue(
      text: clamped,
      selection: TextSelection.collapsed(offset: clamped.length),
    );
  }
}

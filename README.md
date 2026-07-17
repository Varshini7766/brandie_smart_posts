# Brandie Smart Posts

Flutter implementation of the Brandie Smart Posts interview assignment. The
project reproduces the supplied 375x812 Figma experience with local mock data,
local images, staged loading, a three-post vertical reel, quick-share actions,
and editable captions.

## Run

```bash
flutter pub get
flutter run
```

The project uses `assets/oriflame_sans.ttf`, supplied separately for the
assignment. Confirm that your licence permits committing or redistributing the
font before publishing this repository.

## Architecture

```text
lib/
  common/             Shared strings, colors, constants, theme, and utilities
  common_widgets/     Reusable feature-independent widgets
  smartposts/
    UI/               Screens and feature widgets
    bloc/             Bloc, events, and state
    models/           Immutable local domain models and mock fixtures
```

`SmartPostsBloc` owns the loading sequence, selected post, delayed product
reveal, caption draft/save state, tabs, navigation, and selected share target.
UI widgets contain no backend logic.

## Assignment decisions

- No backend or API is used; all content is deterministic local fixture data.
- Post photos live under `assets/images/`; social and navigation icons live under `assets/icons/`.
- Edit Caption opens a bottom sheet with the keyboard focused immediately.
- Captions are limited to Instagram's 2200-character maximum, with a live
  counter shown at the bottom of the sheet.
- Share, product, and out-of-scope navigation taps provide local feedback
  instead of invoking external services.
- The product card appears after three seconds, matching the design annotation.
- The reference composition is 375x812 and uses safe-area-aware constraints for
  nearby mobile sizes.

## Verification

```bash
dart format lib test
flutter analyze
flutter test
```

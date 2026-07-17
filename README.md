# Brandie Smart Posts

A single-page Flutter implementation of Brandie's Flutter Developer Assignment.
The application translates the supplied
[Figma design](https://www.figma.com/design/pba5xdsRMWFWWtxThfAnnw/Quick-share-feature?node-id=0-1)
into an interactive Smart Posts experience with close attention to layout,
typography, spacing, imagery, motion, and interaction details.

The implementation is UI-focused and uses deterministic local content, as
requested by the assignment. It does not require a backend, API, account, or
network connection.

## Features

- Three full-height Smart Post pages with vertical, one-page-at-a-time snapping.
- Persistent page indicators that update with the active `PageController` page.
- Figma-matched post overlays, product promotion, caption, song recommendation,
  quick-share controls, header, tabs, and bottom navigation.
- Local startup GIF shown once per app launch or hot restart.
- Delayed product-card reveal matching the prototype interaction.
- Caption editor presented as a modal bottom sheet with immediate keyboard
  focus.
- Instagram-compatible 2,200-character limit with a live character counter.
- Required referral code and referral link prefilled as part of every caption
  and included in its character count.
- Eight-line caption previews with ellipsis overflow.
- Staged sharing animation followed by a local opening screen for the selected
  social platform.
- Local images and icons with no remote asset dependency.

## Requirements

- Flutter SDK compatible with Dart `^3.8.1`
- Android Studio, Xcode, or VS Code/Cursor with Flutter tooling
- An Android/iOS emulator, simulator, or physical device

Confirm the Flutter installation before running:

```bash
flutter doctor
```

## Running the project

Clone the repository and run:

```bash
flutter pub get
flutter run
```

To choose a specific connected device:

```bash
flutter devices
flutter run -d <device-id>
```

The reference design size is 375×812. The interface uses safe areas and bounded
mobile layouts to prevent overflow on nearby screen sizes.

## Project structure

```text
lib/
  common/
    app_colors.dart
    app_constants.dart
    app_strings.dart
    app_theme.dart
    utils.dart
  common_widgets/
    glass_panel.dart
  smartposts/
    UI/
      widgets/
      smart_posts_screen.dart
      social_splash_screen.dart
    bloc/
      smart_posts_bloc.dart
      smart_posts_event.dart
      smart_posts_state.dart
    models/
      smart_post.dart
  main.dart

assets/
  images/                 Post, profile, and product images
  icons/                  Social, navigation, and branding icons
  smart_post_loading_animation.gif

test/
  smart_posts_bloc_test.dart
  widget_test.dart
```

## Architecture and implementation

The project follows a feature-based structure with separation between UI,
business state, immutable models, shared design tokens, and reusable widgets.

`SmartPostsBloc` uses separate event, state, and bloc files. Event handlers are
registered with `on<Event>`, and state changes occur through `emit`. The bloc
owns:

- Intro and product reveal timing
- Active post, tab, and navigation state
- Caption editing, validation, saving, and referral suffix enforcement
- Quick-share preparation stages and selected platform state

Models and bloc states use `Equatable` for value equality. UI widgets remain
focused on rendering and forwarding user interactions.

Shared user-facing strings, colors, dimensions, durations, typography, and
asset paths are centralized under `lib/common/`. The reusable glass treatment
is isolated in `lib/common_widgets/`.

## Assumptions and design decisions

- The assignment prioritizes UI implementation, so all posts, products,
  captions, and platform data are local fixtures.
- Quick Share is intentionally simulated. It shows the designed preparation
  sequence and a local platform opening screen without invoking installed apps
  or external APIs.
- Tabs, product links, and bottom-navigation destinations outside the Smart
  Posts scope provide local feedback rather than incomplete navigation.
- Caption changes are stored in memory for the current session.
- The referral code and link are prefilled caption content and count toward the
  character limit. Users may edit or remove them before saving.
- Helvetica is requested for the interface, with Arial and the platform
  sans-serif font configured as fallbacks where Helvetica is unavailable.
- Design details not explicitly defined in the wireframe were resolved by
  following the prototype, preserving familiar mobile interaction patterns,
  and preventing overflow.
- For editing of the caption I have made the UX decission of using bottomsheet
  instead of navigating to a new page.
- I researched and added 2200 character count based on Instagram's caption limit 
  for this demo.

## Custom UX improvements

- Reduced-motion settings skip the animated intro.
- Hot reload does not replay the startup animation; hot restart and a fresh
  launch do.
- Page snapping provides an Instagram-style one-post-per-swipe interaction.
- Adjacent pages are preloaded for smoother scrolling.
- Semantic labels and selected states are included for interactive icons.
- Caption input is constrained consistently in the formatter and bloc so the
  field, saved value, and counter cannot exceed 2,200 characters.

## Verification

Format, analyze, and test the project with:

```bash
dart format lib test
flutter analyze
flutter test
```

Automated coverage includes loading-state behavior, caption updates and limits,
sharing-state transitions, and initial widget rendering.

## Assignment scope

This repository is intended for evaluation and live presentation of the
single-page Flutter UI. It demonstrates Figma interpretation, component
breakdown, reusable styling, state management, responsive layout decisions, and
thoughtful handling of unspecified interactions without adding unnecessary
backend work.

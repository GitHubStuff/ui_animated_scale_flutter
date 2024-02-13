# SETUP

Wrapper for a widget that allow the child to be perform a scale transform, or use as 'animated button'. The scaling happens over a *Duration*, and transforms from *boundry* of 0.0 to 1.0.

<!--
The comments below are from the Flutter/Dart package generation. Feel free to use or ignore
-->

<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages).
-->

## Getting started

in *pubspec.yaml* file:

```dart
dev_dependencies:
  ui_animated_scale_flutter:
    git: https://github.com/GitHubStuff/ui_animated_scale_flutter.git
```

## Usage

Full use example in **/example** folder

```dart
UIAnimatedScaleWidget(
            onTapDown: (cubit, details) {
              if (cubit.state == AnimatedScaleState.normal) {
                cubit.compress();
              } else {
                cubit.expand();
              }
            },
            onTapUp: null,
            child: const Text(
              'Tap Me for State!',
              style: TextStyle(fontSize: 20),
            ),
          )
```

*NOTE* If no callbacks for onTap Up/Down are provided, the widget does an animated scale {mimics a button press}

## Haptics

There is support for Haptic feed back using:

```dart
import 'package:flutter/services.dart';
```

and an enum to set the type:

```dart
enum HapticFeedbackEnum {
  heavyImpact,
  lightImpact,
  mediumImpact,
  none,
  selectionClick,
  selectionVibrate;
}
```

## Widget Definition

```dart
class UIAnimatedScaleWidget extends StatefulWidget {
  final double upperBoundTransform;
  final Duration animationDuration;
  final Function(AnimatedScaleCubit, TapDownDetails)? onTapDown;
  final Function(AnimatedScaleCubit, TapUpDetails)? onTapUp;
  final HapticFeedbackEnum hapticFeedback;
  final Widget child;

  const UIAnimatedScaleWidget({
    super.key,
    this.animationDuration = const Duration(milliseconds: 200),
    this.hapticFeedback = HapticFeedbackEnum.none,
    this.onTapDown,
    this.onTapUp,
    this.upperBoundTransform = 0.1,
    required this.child,
  });
}
```

## Finally

Be kind to each other

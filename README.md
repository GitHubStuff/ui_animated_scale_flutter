# UIAnimatedScaleWidget

UIAnimatedScaleWidget is a Flutter widget that animates its child's scale on tap, with optional ```haptic``` feedback.

## Features

- Animates child's scale on tap down and up events.
- Supports customizable animation parameters such as duration and upper bound transform.
- Provides options for adding haptic feedback on tap events.
- Allows custom onTapDown and onTapUp callbacks for implementing specific behaviors.

## Installation

To use this widget, add the following dependency to your `pubspec.yaml` file:

```yaml
dependencies:
  ui_animated_scale_flutter:
    git: https://github.com/GitHubStuff/ui_animated_scale_flutter.git
  # To use haptics include:
  ui_haptics_flutter:
    git: https://github.com/GitHubStuff/ui_haptics_flutter.git

```

## Usage

```dart
import 'package:ui_haptics_flutter/ui_haptics_flutter.dart';

UIAnimatedScaleWidget(
            animationDuration: const Duration(milliseconds: 500),
            hapticFeedback: HapticFeedbackEnum.heavyImpact,
            onTapDown: (cubit, details) {
              if (cubit.state == AnimatedScaleState.normal) {
                cubit.compress();
              } else {
                cubit.expand();
              }
            },
            upperBoundTransform: 0.85,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Assets.images.scale1024.image(),
            ),
          ),
```

See ```/example/lib/screens/home_scaffold.dart``` for examples

## Finally

Be kind to each other!

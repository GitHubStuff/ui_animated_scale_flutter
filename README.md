# SETUP

Wrapper for a widget that allow the child to be perform a scale transform,
or use as 'animated button'

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

## Features

Allows a widget to be wrapped and recieve callbacks on tap up/down, or be used as an animated button

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

## Widget Definition

```dart
class UIAnimatedScaleWidget extends StatefulWidget {
  final Widget child;
  final Function(AnimatedScaleCubit, TapDownDetails)? onTapDown;
  final Function(AnimatedScaleCubit, TapUpDetails)? onTapUp;

  const UIAnimatedScaleWidget({
    super.key,
    required this.child,
    this.onTapDown,
    this.onTapUp,
  });

  @override
  State<UIAnimatedScaleWidget> createState() => _UIAnimatedScaleWidgetState();
}
```

## Finally

Be kind to each other

/// A Flutter Cubit for managing animated scaling transformations of a widget.
///
/// This cubit manages the state and animation of a widget's scale transformation
/// with three states: compress, normal, and expand. It provides methods to trigger
/// these state transitions.
///
/// To use this cubit, provide a `TickerProvider` and a widget to animate. By default,
/// the duration of the animation is set to 200 milliseconds and the upper bound of
/// the scale transformation is set to 0.1.
///
/// Example:
/// ```dart
/// AnimatedScaleCubit(
///   vsync: this,
///   widget: MyWidget(),
/// )
/// ```
library;

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

part 'animated_transform.dart';

/// Enumeration representing the state of animated scaling.
enum AnimatedScaleState {
  /// Represents a compressed state.
  compress,

  /// Represents a normal state.
  normal,

  /// Represents an expanded state.
  expand,
}

/// A cubit for managing animated scaling transformations of a widget.
class AnimatedScaleCubit extends Cubit<AnimatedScaleState> {
  late final AnimationController _controller;
  late final AnimatedTransform _animatedButton;

  /// Duration for the animation.
  final Duration duration;

  /// Upper bound of the scale transformation.
  final double upperBoundTransform;

  /// Returns the child widget being animated.
  Widget get child => _animatedButton;

  /// Constructs an instance of AnimatedScaleCubit.
  ///
  /// [vsync] is required to synchronize animations with the screen refresh rate.
  /// [widget] is the widget to be animated.
  /// [duration] is the duration of the animation, defaults to 200 milliseconds.
  /// [upperBoundTransform] specifies the upper bound of the scale transformation,
  /// default is set to 0.1.
  AnimatedScaleCubit({
    required TickerProvider vsync,
    required Widget widget,
    this.duration = const Duration(milliseconds: 200),
    this.upperBoundTransform = 0.1,
  })  : assert(
          upperBoundTransform > 0.0 && upperBoundTransform <= 1.0,
          'upperBoundTransform must be between 0.0 and 1.0',
        ),
        super(AnimatedScaleState.normal) {
    _controller = _defaultController(vsync);
    _animatedButton = AnimatedTransform(
      controller: _controller,
      animatingWidget: widget,
    );
  }

  @override
  Future<void> close() {
    _controller.dispose();
    return super.close();
  }

  /// Triggers the compress animation state.
  void compress() {
    if (state != AnimatedScaleState.normal) return;
    _controller.forward();
    emit(AnimatedScaleState.compress);
  }

  /// Triggers the expand animation state.
  void expand() {
    if (state != AnimatedScaleState.compress) return;
    _controller.reverse();
    emit(AnimatedScaleState.normal);
  }

  /// Resets to the normal animation state.
  void normal() {
    if (state == AnimatedScaleState.normal) return;
    _controller.reset();
    emit(AnimatedScaleState.normal);
  }

  /// Creates a default animation controller.
  AnimationController _defaultController(TickerProvider vsync) =>
      AnimationController(
        vsync: vsync,
        duration: duration,
        lowerBound: 0.0,
        upperBound: upperBoundTransform,
      );
}
